# CERN-Level UX Trilogy — Publication & Distribution

## Zenodo Metadata

Each paper has a `.zenodo.json` file ready for upload:

| Paper | File | SCC | DOI Status |
|-------|------|-----|-----------|
| LXIII — De Particula Experientia | `LXIII_PARTICULA_EXPERIENTIA.zenodo.json` | 4.99 | Pending |
| LXIV — De Collisionibus Cognitivis | `LXIV_COLLISIONIBUS_COGNITIVIS.zenodo.json` | 4.99 | Pending |
| LXV — De Campo Unificato Interfaciei | `LXV_CAMPO_UNIFICATO.zenodo.json` | 5.00 ⭐ | Pending |

### Upload Instructions

1. Go to [zenodo.org/deposit/new](https://zenodo.org/deposit/new)
2. Upload the corresponding markdown paper from `research/`
3. Import metadata from the `.zenodo.json` file
4. Publish → DOI is minted automatically
5. Update DOI back in paper header and entity-counts

## X/Twitter Threads

Pre-composed threads for each paper in `../x-threads/`:

| Paper | Thread File | Posts |
|-------|------------|-------|
| LXIII | `LXIII_PARTICULA_EXPERIENTIA_thread.md` | 8 posts |
| LXIV | `LXIV_COLLISIONIBUS_COGNITIVIS_thread.md` | 8 posts |
| LXV | `LXV_CAMPO_UNIFICATO_thread.md` | 8 posts |

### Posting Strategy

1. **LXIII first** — introduce the particle zoo concept
2. **LXIV 24h later** — build on collision concept
3. **LXV 24h later** — capstone with first SCC 5.00

## Internal OS Systems

Located at `nova_ovo/ux_ai_cern/os_systems/`:

| Module | Purpose | Protocol |
|--------|---------|----------|
| `particle_detection_os.py` | 7-layer detector, trigger system | PROT-612-615 |
| `collision_event_os.py` | Collision runtime, resonances, phases | PROT-622-628 |
| `unified_field_os.py` | Coupling constants, branes, holography | PROT-632-641 |
| `publication_pipeline.py` | Zenodo + X distribution pipeline | PROT-639-641 |

## Protocol Coverage

- PROT-612 to PROT-621: Standard Model of UX (10 protocols)
- PROT-622 to PROT-631: Cognitive Collider (10 protocols)
- PROT-632 to PROT-641: Unified Field Theory (10 protocols)
- **Total: 30 protocols for CERN-Level UX Research**
