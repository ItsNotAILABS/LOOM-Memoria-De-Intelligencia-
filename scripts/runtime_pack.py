#!/usr/bin/env python3
"""
Runtime pack and inventory orchestration.

- Freeze canonical backend inventory snapshots
- Run layered pack profiles with lineage/checkpoints
- Enforce preflight/postflight gates
"""

from __future__ import annotations

import argparse
import datetime as dt
import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path
from typing import Any, Dict, List, Tuple

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from nova_ovo.orchestrators.alpha_profile_pack import run_native_validation_bundle
ATLAS_RUNTIME = ROOT / "atlas" / "registry" / "runtime"
SNAPSHOTS_DIR = ATLAS_RUNTIME / "inventory-snapshots"
PACK_PROFILES_PATH = ATLAS_RUNTIME / "pack-profiles.json"
PACK_RUNS_PATH = ATLAS_RUNTIME / "pack-runs.json"
NATIVE_AGENTS_PATH = ATLAS_RUNTIME / "internal-native-agents.json"
NATIVE_VALIDATION_CONFIG_PATH = ATLAS_RUNTIME / "native-validation-config.json"
LATEST_SNAPSHOT_PATH = SNAPSHOTS_DIR / "latest.json"

PHI = 1.618033988749895
PHI_SQ = 2.618033988749895
INV_PHI = 0.6180339887498948


def _load_json(path: Path) -> Dict[str, Any]:
    with path.open("r", encoding="utf-8") as f:
        return json.load(f)


def _write_json(path: Path, data: Dict[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
        f.write("\n")


def _safe_parse_json(path: Path) -> Tuple[bool, str]:
    try:
        _load_json(path)
        return True, "ok"
    except Exception as exc:  # noqa: BLE001
        return False, str(exc)


def _read_model_registry_entries() -> List[str]:
    registry_path = ROOT / "nova_ovo" / "models" / "registry.py"
    text = registry_path.read_text(encoding="utf-8")
    entries = re.findall(r'\("([A-Z0-9\-]+|D\d+|N\d+)",\s*ModelFamily\.[A-Z_]+', text)
    entries.extend([f"D{i}" for i in range(1, 11)])
    entries.extend([f"N{i}" for i in range(1, 13)])
    return sorted(set(entries))


def _list_web_workers() -> List[str]:
    workers_dir = ROOT / "organism-cli" / "web"
    return sorted(
        p.name
        for p in workers_dir.glob("*worker*.js")
        if p.is_file()
    )


def _list_runtime_bridges() -> List[str]:
    bridges: List[str] = []
    candidates = [
        ROOT / "organism-cli" / "web" / "organism-bridge.js",
    ]
    candidates.extend(sorted((ROOT / "nova_ovo" / "bridges").glob("*.py")))
    for path in candidates:
        if path.exists():
            bridges.append(str(path.relative_to(ROOT)))
    return bridges


def _list_sdk_packages() -> List[Dict[str, Any]]:
    package_entries: List[Dict[str, Any]] = []
    packages_dir = ROOT / "packages"
    for pkg_path in sorted(packages_dir.glob("*/package.json")):
        try:
            data = _load_json(pkg_path)
        except Exception:
            continue
        package_entries.append(
            {
                "name": data.get("name", pkg_path.parent.name),
                "version": data.get("version", "0.0.0"),
                "path": str(pkg_path.parent.relative_to(ROOT)),
            }
        )
    return package_entries


def _hash_ids(items: List[str]) -> str:
    h = hashlib.sha256()
    h.update("\n".join(sorted(items)).encode("utf-8"))
    return h.hexdigest()


def _build_inventory(profile: str = "full", mode: str = "pyramid") -> Dict[str, Any]:
    utc_now = dt.datetime.now(dt.timezone.utc)
    timestamp = utc_now.isoformat()
    snapshot_id = f"inventory-{utc_now.strftime('%Y%m%dT%H%M%SZ')}"

    atlas_entities = sorted(
        p.name for p in (ROOT / "atlas" / "registry" / "entities").glob("*.json") if p.is_file()
    )
    native_agents = _load_json(NATIVE_AGENTS_PATH).get("entities", [])
    web_workers = _list_web_workers()
    model_registry_entries = _read_model_registry_entries()
    sdk_packages = _list_sdk_packages()
    runtime_bridges = _list_runtime_bridges()

    profile_config = _load_json(PACK_PROFILES_PATH)
    profiles = profile_config.get("profiles", {})
    selected_profile = profiles.get(profile, {})

    ids_for_digest: List[str] = []
    ids_for_digest.extend([f"atlas:{name}" for name in atlas_entities])
    ids_for_digest.extend([f"native:{e.get('entity_id')}" for e in native_agents])
    ids_for_digest.extend([f"worker:{name}" for name in web_workers])
    ids_for_digest.extend([f"model:{name}" for name in model_registry_entries])
    ids_for_digest.extend([f"package:{pkg['name']}@{pkg['version']}" for pkg in sdk_packages])
    ids_for_digest.extend([f"bridge:{name}" for name in runtime_bridges])

    return {
        "snapshot_id": snapshot_id,
        "version": "1.0.0",
        "created_at": timestamp,
        "profile": profile,
        "mode": mode,
        "math_surface": {
            "phi": PHI,
            "phi_sq": PHI_SQ,
            "inv_phi": INV_PHI,
        },
        "counts": {
            "atlas_entities": len(atlas_entities),
            "internal_native_agents": len(native_agents),
            "web_workers": len(web_workers),
            "model_registry_entries": len(model_registry_entries),
            "sdk_packages": len(sdk_packages),
            "runtime_bridges": len(runtime_bridges),
            "total_components": len(ids_for_digest),
        },
        "profile_config": selected_profile,
        "inventory": {
            "atlas_entities": atlas_entities,
            "internal_native_agents": native_agents,
            "web_workers": web_workers,
            "model_registry_entries": model_registry_entries,
            "sdk_packages": sdk_packages,
            "runtime_bridges": runtime_bridges,
        },
        "digest": _hash_ids(ids_for_digest),
    }


def _delta(previous: Dict[str, Any], current: Dict[str, Any]) -> Dict[str, Any]:
    if not previous:
        return {
            "baseline_snapshot_id": "initial",
            "is_digest_changed": True,
            "count_deltas": current.get("counts", {}),
        }

    count_deltas: Dict[str, int] = {}
    prev_counts = previous.get("counts", {})
    cur_counts = current.get("counts", {})
    for key in sorted(set(prev_counts) | set(cur_counts)):
        count_deltas[key] = int(cur_counts.get(key, 0)) - int(prev_counts.get(key, 0))

    def _to_set(path: str) -> set[str]:
        data = current
        pdata = previous
        for part in path.split("."):
            data = data.get(part, {})
            pdata = pdata.get(part, {})
        if isinstance(data, list) and isinstance(pdata, list):
            return set(data), set(pdata)
        return set(), set()

    cur_workers, prev_workers = _to_set("inventory.web_workers")
    cur_models, prev_models = _to_set("inventory.model_registry_entries")

    return {
        "baseline_snapshot_id": previous.get("snapshot_id"),
        "is_digest_changed": previous.get("digest") != current.get("digest"),
        "count_deltas": count_deltas,
        "workers": {
            "added": sorted(cur_workers - prev_workers),
            "removed": sorted(prev_workers - cur_workers),
        },
        "models": {
            "added": sorted(cur_models - prev_models),
            "removed": sorted(prev_models - cur_models),
        },
    }


def _validate_activation_graph(profile_name: str, inventory: Dict[str, Any]) -> Tuple[bool, str]:
    profiles = _load_json(PACK_PROFILES_PATH).get("profiles", {})
    profile = profiles.get(profile_name)
    if profile is None:
        return False, f"unknown profile: {profile_name}"

    workers = profile.get("workers", [])
    if workers == "all":
        return True, "ok"

    available_workers = set(inventory["inventory"]["web_workers"])
    normalized_available = set(name.replace("-worker.js", "") for name in available_workers)
    missing = sorted(w for w in workers if w not in normalized_available)
    if missing:
        return False, f"profile workers missing from inventory: {', '.join(missing)}"

    return True, "ok"


def _run_node_check(path: Path) -> Tuple[bool, str]:
    result = subprocess.run(
        ["node", "--check", str(path)],
        cwd=ROOT,
        capture_output=True,
        text=True,
        check=False,
    )
    if result.returncode == 0:
        return True, "ok"
    return False, (result.stderr or result.stdout).strip()


def _preflight(profile: str, inventory: Dict[str, Any]) -> Dict[str, Any]:
    checks: Dict[str, Dict[str, Any]] = {}

    for file_path in [PACK_PROFILES_PATH, NATIVE_AGENTS_PATH, NATIVE_VALIDATION_CONFIG_PATH]:
        ok, detail = _safe_parse_json(file_path)
        checks[str(file_path.relative_to(ROOT))] = {"ok": ok, "detail": detail}

    ok_bridge, detail_bridge = _run_node_check(ROOT / "organism-cli" / "web" / "organism-bridge.js")
    checks["organism-cli/web/organism-bridge.js"] = {"ok": ok_bridge, "detail": detail_bridge}

    ok_graph, detail_graph = _validate_activation_graph(profile, inventory)
    checks["activation_graph"] = {"ok": ok_graph, "detail": detail_graph}

    passed = all(item["ok"] for item in checks.values())
    return {"passed": passed, "checks": checks}


def _postflight(inventory: Dict[str, Any]) -> Dict[str, Any]:
    checks: Dict[str, Dict[str, Any]] = {}

    checks["latest_snapshot_exists"] = {
        "ok": LATEST_SNAPSHOT_PATH.exists(),
        "detail": str(LATEST_SNAPSHOT_PATH.relative_to(ROOT)),
    }

    latest_ok, latest_detail = _safe_parse_json(LATEST_SNAPSHOT_PATH)
    checks["latest_snapshot_json"] = {"ok": latest_ok, "detail": latest_detail}

    expected = inventory.get("snapshot_id")
    if latest_ok:
        latest = _load_json(LATEST_SNAPSHOT_PATH)
        checks["latest_snapshot_id_match"] = {
            "ok": latest.get("snapshot_id") == expected,
            "detail": f"expected={expected} actual={latest.get('snapshot_id')}",
        }

    passed = all(item["ok"] for item in checks.values())
    return {"passed": passed, "checks": checks}


def freeze_inventory(profile: str = "full", mode: str = "pyramid") -> Dict[str, Any]:
    previous = _load_json(LATEST_SNAPSHOT_PATH) if LATEST_SNAPSHOT_PATH.exists() else {}
    current = _build_inventory(profile=profile, mode=mode)
    current["delta"] = _delta(previous, current)

    snapshot_path = SNAPSHOTS_DIR / f"{current['snapshot_id']}.json"
    _write_json(snapshot_path, current)
    _write_json(LATEST_SNAPSHOT_PATH, current)

    return current


def run_pack(profile: str, mode: str) -> Dict[str, Any]:
    inventory = _build_inventory(profile=profile, mode=mode)
    preflight = _preflight(profile=profile, inventory=inventory)
    previous_latest = _load_json(LATEST_SNAPSHOT_PATH) if LATEST_SNAPSHOT_PATH.exists() else {}

    if not preflight["passed"]:
        return {
            "ok": False,
            "phase": "preflight",
            "preflight": preflight,
        }

    native_validation = run_native_validation_bundle(profile=profile)

    frozen = freeze_inventory(profile=profile, mode=mode)
    postflight = _postflight(frozen)

    pack_runs = _load_json(PACK_RUNS_PATH)
    previous_run_id = pack_runs.get("last_run_id")
    run_id = f"pack-{dt.datetime.now(dt.timezone.utc).strftime('%Y%m%dT%H%M%SZ')}"

    run_record = {
        "run_id": run_id,
        "profile": profile,
        "mode": mode,
        "created_at": dt.datetime.now(dt.timezone.utc).isoformat(),
        "lineage": {
            "foundation_run": previous_run_id,
            "overlay_run": run_id,
            "active_snapshot": frozen["snapshot_id"],
        },
        "checkpoints": {
            "preflight": preflight,
            "native_validation": native_validation,
            "snapshot": f"inventory-snapshots/{frozen['snapshot_id']}.json",
            "rollback_snapshot": (
                f"inventory-snapshots/{previous_latest.get('snapshot_id')}.json"
                if previous_latest.get("snapshot_id")
                else "inventory-snapshots/latest.json"
            ),
            "postflight": postflight,
        },
        "status": "passed" if postflight["passed"] else "warning",
    }

    pack_runs.setdefault("runs", []).append(run_record)
    pack_runs["last_run_id"] = run_id
    _write_json(PACK_RUNS_PATH, pack_runs)

    return {
        "ok": postflight["passed"],
        "run": run_record,
        "snapshot_id": frozen["snapshot_id"],
        "digest": frozen["digest"],
    }


def main() -> int:
    parser = argparse.ArgumentParser(description="Atlas runtime pack and inventory tooling")
    sub = parser.add_subparsers(dest="command", required=True)

    p_freeze = sub.add_parser("freeze", help="Freeze inventory snapshot")
    p_freeze.add_argument("--profile", default="full", choices=["full", "ops", "minimal", "rebuild"])
    p_freeze.add_argument("--mode", default="pyramid", choices=["pyramid", "incremental"])

    p_run = sub.add_parser("run", help="Run layered pack profile")
    p_run.add_argument("--profile", default="full", choices=["full", "ops", "minimal", "rebuild"])
    p_run.add_argument("--mode", default="pyramid", choices=["pyramid", "incremental"])

    p_native = sub.add_parser("native-validate", help="Run native backend validation flows")
    p_native.add_argument("--profile", default="ops", choices=["full", "ops", "minimal", "rebuild"])

    args = parser.parse_args()

    if args.command == "freeze":
        output = freeze_inventory(profile=args.profile, mode=args.mode)
    elif args.command == "run":
        output = run_pack(profile=args.profile, mode=args.mode)
    else:
        output = run_native_validation_bundle(profile=args.profile)

    print(json.dumps(output, indent=2, ensure_ascii=False))
    return 0 if output.get("ok", True) else 2


if __name__ == "__main__":
    raise SystemExit(main())
