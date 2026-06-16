/**
 * ╔═══════════════════════════════════════════════════════════════════════════════╗
 * ║              MEDINA — PROPRIETARY AND CONFIDENTIAL                            ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA       ║
 * ║  ALL RIGHTS RESERVED.  Blockchain-registered on ICP.                         ║
 * ╚═══════════════════════════════════════════════════════════════════════════════╝
 *
 * QuipuEngine.ts
 *
 * Paper VI — "De Architectura Incaica" (The Inca as Substrate)
 *
 * The Inca civilization (~1438–1533 CE) is the canonical proof-of-concept that
 * computation = structure + standards + substrate — not silicon.
 *
 * Four implemented systems:
 *
 *   QuipuEngine          — hierarchical, typed, append-only fiber-encoded memory
 *                           Main cord (spine/bus)
 *                           → Pendant cords (typed fields, colour-coded)
 *                             → Subsidiary cords (nested records)
 *                               → Knots (decimal positional values + markers)
 *                           Canonical formula: SCC = semantic_weight / chars
 *                           φ-optimal if SCC ≥ φ² ≈ 2.618
 *
 *   QhapaqNanMesh        — store-and-forward protocol mesh (Qhapaq Ñan, ~40 000 km)
 *                           Chasqui relay runners as human-readable "packets"
 *                           Tambo waystations as store-and-forward buffers
 *                           Suspension bridges as fault-tolerant links
 *
 *   TawantinsuyuHub      — 4-suyu partitioned hub with Cusco as central root node
 *                           Tawantinsuyu = "Realm of the Four Parts"
 *                           Central compute + distributed edge execution
 *                           Redistribution (food/labor/materials) as feedback loop
 *
 *   TerraceBench         — altitude-parameterised test environments
 *                           Each terrace = a controlled micro-climate context
 *                           Distributed experimentation across altitude bands
 *                           Analogue of parameterised unit-test benches
 *
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 */

// ─── constants ────────────────────────────────────────────────────────────────

const PHI      = 1.618033988749895;
const PHI_INV  = 0.6180339887498949;   // 1/φ  ≈ 0.618
const PHI_SQ   = 2.618033988749895;    // φ²   ≈ 2.618  (SCC threshold)

/** SOVEREIGNTY_FLOOR carried across from FractalSovereignty for cross-module use. */
const SOVEREIGNTY_FLOOR = 0.75;

// ─── quipu types ──────────────────────────────────────────────────────────────

/** Knot type mirrors traditional Incan notation. */
export type KnotType = 'long' | 'figure-eight' | 'single' | 'cluster';

/** Color type-system: maps to semantic domain (like a CSS-class in fiber). */
export type CordColor =
    | 'white'   // neutral / general
    | 'black'   // death / depletion / loss
    | 'red'     // warriors / threat / energy
    | 'yellow'  // gold / computation / intelligence
    | 'green'   // crops / growth / expansion
    | 'blue'    // water / memory / flow
    | 'brown'   // earth / territory / sovereignty
    | 'purple'  // sovereignty / godhead / root';

/** A single knot encodes one value at a positional decimal band. */
export interface Knot {
    type     : KnotType;
    position : number;    // band index (0 = topmost = most significant)
    value    : number;    // 0–9 for decimal, or semantic tag ≥ 10
    marker   : string;    // narrative / status tag (e.g. 'census', 'tribute')
}

/** Subsidiary cord — nested record under a pendant cord. */
export interface SubsidiaryCord {
    id     : string;
    color  : CordColor;
    knots  : Knot[];
    label  : string;   // human-readable category
}

/** Pendant cord — a typed field hanging from the main cord. */
export interface PendantCord {
    id          : string;
    color       : CordColor;
    label       : string;
    knots       : Knot[];
    subsidiaries: SubsidiaryCord[];
    createdAt   : number;          // ms timestamp
}

/** A complete Quipu — portable snapshot of a region's state. */
export interface QuipuRecord {
    id          : string;
    region      : string;
    mainCordLabel: string;
    pendants    : PendantCord[];
    createdAt   : number;
    scc         : number;     // Semantic Compression Coefficient
    phiOptimal  : boolean;    // true if SCC ≥ φ²
}

// ─── QuipuEngine ──────────────────────────────────────────────────────────────

/**
 * QuipuEngine
 *
 * A typed, hierarchical, append-only, human-inspectable "fiber database."
 * Implements the quipu (khipu) as a digital schema.
 *
 * Main cord → pendant cords → subsidiary cords → knots.
 * Color = type system.  Knot position = decimal significance.
 * SCC = semantic_weight / chars;  φ-optimal if SCC ≥ φ² ≈ 2.618.
 */
export class QuipuEngine {
    private records: Map<string, QuipuRecord> = new Map();
    private _tick = 0;

    // ── create ─────────────────────────────────────────────────────────────────

    /**
     * Create a new quipu for the given region.
     * Returns the quipu id.
     */
    createQuipu(region: string, mainCordLabel: string): string {
        const id = `quipu-${region}-${++this._tick}`;
        const record: QuipuRecord = {
            id,
            region,
            mainCordLabel,
            pendants  : [],
            createdAt : Date.now(),
            scc       : 0,
            phiOptimal: false,
        };
        this.records.set(id, record);
        return id;
    }

    // ── append ─────────────────────────────────────────────────────────────────

    /**
     * Append a pendant cord (typed field) to an existing quipu.
     * Append-only: no deletion, no mutation.
     */
    appendPendant(
        quipuId : string,
        label   : string,
        color   : CordColor,
        knots   : Knot[] = [],
    ): string {
        const q = this.records.get(quipuId);
        if (!q) throw new Error(`Quipu not found: ${quipuId}`);
        const cordId = `cord-${quipuId}-${q.pendants.length}`;
        q.pendants.push({ id: cordId, color, label, knots, subsidiaries: [], createdAt: Date.now() });
        this._updateSCC(q);
        return cordId;
    }

    /**
     * Append a subsidiary cord under an existing pendant cord.
     */
    appendSubsidiary(
        quipuId  : string,
        cordId   : string,
        label    : string,
        color    : CordColor,
        knots    : Knot[] = [],
    ): string {
        const q = this.records.get(quipuId);
        if (!q) throw new Error(`Quipu not found: ${quipuId}`);
        const pendant = q.pendants.find(p => p.id === cordId);
        if (!pendant) throw new Error(`Pendant cord not found: ${cordId}`);
        const subId = `sub-${cordId}-${pendant.subsidiaries.length}`;
        pendant.subsidiaries.push({ id: subId, color, knots, label });
        this._updateSCC(q);
        return subId;
    }

    /**
     * Append a knot to a pendant cord (lowest level of encoding).
     */
    appendKnot(quipuId: string, cordId: string, knot: Knot): void {
        const q = this.records.get(quipuId);
        if (!q) throw new Error(`Quipu not found: ${quipuId}`);
        const pendant = q.pendants.find(p => p.id === cordId);
        if (!pendant) throw new Error(`Pendant cord not found: ${cordId}`);
        pendant.knots.push(knot);
        this._updateSCC(q);
    }

    // ── read ───────────────────────────────────────────────────────────────────

    getQuipu(quipuId: string): QuipuRecord | undefined {
        return this.records.get(quipuId);
    }

    /** All quipus for a given region — portable regional snapshots. */
    getRegionSnapshot(region: string): QuipuRecord[] {
        return [...this.records.values()].filter(r => r.region === region);
    }

    /** Cross-check: quipus that cover the same region for auditability. */
    crossCheck(region: string): { consistent: boolean; divergences: string[] } {
        const snaps = this.getRegionSnapshot(region);
        const divergences: string[] = [];
        if (snaps.length < 2) return { consistent: true, divergences };
        const ref = this._totalValue(snaps[0]);
        for (let i = 1; i < snaps.length; i++) {
            const val = this._totalValue(snaps[i]);
            if (Math.abs(val - ref) > 0.001) {
                divergences.push(`${snaps[i].id} diverges by ${(val - ref).toFixed(4)}`);
            }
        }
        return { consistent: divergences.length === 0, divergences };
    }

    /** Decode decimal value from a cord's knots (positional). */
    decodeCord(pendant: PendantCord): number {
        return pendant.knots.reduce((acc, k) => acc + k.value * Math.pow(10, -k.position), 0);
    }

    // ── internal ───────────────────────────────────────────────────────────────

    private _totalValue(q: QuipuRecord): number {
        return q.pendants.reduce((acc, p) => acc + this.decodeCord(p), 0);
    }

    /**
     * SCC = semantic_weight / chars
     * semantic_weight = total knot values + cord count × φ
     * chars = total label chars across all cords
     */
    private _updateSCC(q: QuipuRecord): void {
        let weight = 0;
        let chars  = q.mainCordLabel.length;
        for (const p of q.pendants) {
            weight += this.decodeCord(p) + PHI;
            chars  += p.label.length;
            for (const s of p.subsidiaries) {
                weight += s.knots.reduce((a, k) => a + k.value, 0) + PHI_INV;
                chars  += s.label.length;
            }
        }
        q.scc       = chars > 0 ? weight / chars : 0;
        q.phiOptimal = q.scc >= PHI_SQ;
    }
}

// ─── QhapaqNanMesh types ──────────────────────────────────────────────────────

export type LinkType = 'road' | 'suspension-bridge' | 'tunnel' | 'coastal';

export interface Tambo {
    id       : string;   // waystation id
    name     : string;
    location : string;   // geographic label
    altitude : number;   // metres — affects routing cost
    buffer   : MessagePacket[];  // store-and-forward buffer
}

export interface MessagePacket {
    id        : string;
    origin    : string;
    destination: string;
    payload   : unknown;
    hops      : string[];   // tambo ids traversed
    timestamp : number;
    priority  : number;     // 0 (low) – 1 (sovereign)
}

export interface MeshLink {
    fromId   : string;
    toId     : string;
    type     : LinkType;
    lengthKm : number;
    reliability: number;  // 0–1; suspension bridges ≈ 0.92
}

// ─── QhapaqNanMesh ────────────────────────────────────────────────────────────

/**
 * QhapaqNanMesh
 *
 * Store-and-forward protocol mesh modelled on the Qhapaq Ñan (~40 000 km).
 * Chasqui relay runners are "packets." Tambos are store-and-forward buffers.
 * Suspension bridges are high-reliability links over extreme terrain.
 *
 * Routing cost = lengthKm × altitudePenalty × (1 / reliability).
 */
export class QhapaqNanMesh {
    private tambos  : Map<string, Tambo>   = new Map();
    private links   : MeshLink[]           = [];
    private _packet = 0;

    // ── topology ───────────────────────────────────────────────────────────────

    addTambo(id: string, name: string, location: string, altitude: number): Tambo {
        const tambo: Tambo = { id, name, location, altitude, buffer: [] };
        this.tambos.set(id, tambo);
        return tambo;
    }

    addLink(fromId: string, toId: string, type: LinkType, lengthKm: number, reliability = 0.9): void {
        if (!this.tambos.has(fromId)) throw new Error(`Tambo not found: ${fromId}`);
        if (!this.tambos.has(toId))   throw new Error(`Tambo not found: ${toId}`);
        this.links.push({ fromId, toId, type, lengthKm, reliability });
    }

    // ── routing ────────────────────────────────────────────────────────────────

    /**
     * Dispatch a packet from origin to destination via Dijkstra on routing cost.
     * Each hop stores the packet in the tambo buffer (store-and-forward).
     * Returns the ordered list of tambo ids (the route taken).
     */
    dispatch(
        originId     : string,
        destinationId: string,
        payload      : unknown,
        priority     : number = 0.5,
    ): MessagePacket {
        const route = this._dijkstra(originId, destinationId);
        const packet: MessagePacket = {
            id         : `pkt-${++this._packet}`,
            origin     : originId,
            destination: destinationId,
            payload,
            hops       : route,
            timestamp  : Date.now(),
            priority,
        };
        // store at each intermediate tambo (skip origin and destination)
        for (const tamboid of route.slice(1, -1)) {
            const t = this.tambos.get(tamboid);
            if (t) t.buffer.push(packet);
        }
        return packet;
    }

    /** Drain the buffer at a tambo — chasqui hand-off. */
    drain(tamboId: string): MessagePacket[] {
        const t = this.tambos.get(tamboId);
        if (!t) return [];
        const drained = [...t.buffer];
        t.buffer = [];
        return drained;
    }

    getTambo(id: string): Tambo | undefined { return this.tambos.get(id); }
    getAllTambos(): Tambo[] { return [...this.tambos.values()]; }

    /** Total bandwidth: sum of (reliability × 1/routingCost) across all links. */
    meshBandwidth(): number {
        return this.links.reduce((acc, l) => {
            const cost = this._linkCost(l);
            return acc + (l.reliability / cost);
        }, 0);
    }

    // ── internal ───────────────────────────────────────────────────────────────

    private _linkCost(l: MeshLink): number {
        const fromAlt = this.tambos.get(l.fromId)?.altitude ?? 0;
        const toAlt   = this.tambos.get(l.toId)?.altitude   ?? 0;
        const altPenalty = 1 + Math.abs(toAlt - fromAlt) / 5000;   // 5 000 m reference
        return l.lengthKm * altPenalty * (1 / Math.max(l.reliability, 0.01));
    }

    private _dijkstra(start: string, end: string): string[] {
        const dist: Map<string, number>  = new Map();
        const prev: Map<string, string>  = new Map();
        const unvisited: Set<string>     = new Set(this.tambos.keys());
        for (const id of this.tambos.keys()) dist.set(id, Infinity);
        dist.set(start, 0);

        while (unvisited.size > 0) {
            // pick nearest unvisited
            let u = '';
            let minD = Infinity;
            for (const id of unvisited) {
                const d = dist.get(id)!;
                if (d < minD) { minD = d; u = id; }
            }
            if (u === '' || u === end) break;
            unvisited.delete(u);

            // relax neighbours
            for (const link of this.links) {
                let neighbour = '';
                if (link.fromId === u && unvisited.has(link.toId))   neighbour = link.toId;
                if (link.toId   === u && unvisited.has(link.fromId)) neighbour = link.fromId;
                if (!neighbour) continue;
                const alt = dist.get(u)! + this._linkCost(link);
                if (alt < dist.get(neighbour)!) {
                    dist.set(neighbour, alt);
                    prev.set(neighbour, u);
                }
            }
        }

        // reconstruct path
        const path: string[] = [];
        let cur: string | undefined = end;
        while (cur) { path.unshift(cur); cur = prev.get(cur); }
        return path[0] === start ? path : [start, end];   // fallback direct
    }
}

// ─── TawantinsuyuHub types ────────────────────────────────────────────────────

export type Suyu = 'Chinchaysuyu' | 'Antisuyu' | 'Collasuyu' | 'Cuntisuyu';
export const ALL_SUYUS: Suyu[] = ['Chinchaysuyu', 'Antisuyu', 'Collasuyu', 'Cuntisuyu'];

export interface HubNode {
    id          : string;
    name        : string;
    suyu        : Suyu;
    type        : 'leaf' | 'edge' | 'regional' | 'root';
    resource    : number;   // current resource level (food, labor, materials)
    population  : number;
}

export interface RedistributionEvent {
    fromId  : string;
    toId    : string;
    amount  : number;
    reason  : 'famine-relief' | 'tribute' | 'labor-draft' | 'military' | 'road-build';
    tick    : number;
}

// ─── TawantinsuyuHub ──────────────────────────────────────────────────────────

/**
 * TawantinsuyuHub
 *
 * Central-node + 4-suyu partition hub.
 * Cusco is the root node (hub of all routing and redistribution).
 * Each suyu is a sub-graph of HubNodes.
 *
 * Redistribution acts as a feedback-and-actuation loop:
 *   detect scarcity → route surplus from another suyu → restore balance.
 *
 * Architecture: central compute + distributed edge execution (mitma pattern).
 */
export class TawantinsuyuHub {
    private nodes: Map<string, HubNode> = new Map();
    private events: RedistributionEvent[] = [];
    private _tick = 0;
    readonly rootId = 'cusco';

    constructor() {
        this.nodes.set(this.rootId, {
            id: this.rootId, name: 'Cusco', suyu: 'Chinchaysuyu',
            type: 'root', resource: 1000, population: 40000,
        });
    }

    // ── topology ───────────────────────────────────────────────────────────────

    registerNode(
        id         : string,
        name       : string,
        suyu       : Suyu,
        type       : HubNode['type'] = 'leaf',
        resource   : number = 100,
        population : number = 1000,
    ): HubNode {
        const node: HubNode = { id, name, suyu, type, resource, population };
        this.nodes.set(id, node);
        return node;
    }

    getNode(id: string): HubNode | undefined { return this.nodes.get(id); }

    /** All nodes in a suyu — the sub-graph of that quarter. */
    getSubgraph(suyu: Suyu): HubNode[] {
        return [...this.nodes.values()].filter(n => n.suyu === suyu);
    }

    // ── feedback loop ──────────────────────────────────────────────────────────

    /**
     * Redistribute resources from surplus nodes to deficit nodes.
     * Mimics Inca famine-relief / tribute redistribution via the road network.
     * Returns all redistribution events fired this tick.
     */
    redistribute(
        reason : RedistributionEvent['reason'] = 'famine-relief',
        threshold = SOVEREIGNTY_FLOOR,
    ): RedistributionEvent[] {
        const tick = ++this._tick;
        const allNodes = [...this.nodes.values()];
        const totalResource = allNodes.reduce((a, n) => a + n.resource, 0);
        const avgResource   = totalResource / allNodes.length;
        const fired: RedistributionEvent[] = [];

        const deficit  = allNodes.filter(n => n.resource < avgResource * threshold);
        const surplus  = allNodes.filter(n => n.resource > avgResource * (2 - threshold));

        for (const def of deficit) {
            for (const sur of surplus) {
                if (sur.resource <= avgResource) continue;
                const amount = Math.min(
                    (avgResource - def.resource) * PHI_INV,
                    (sur.resource - avgResource) * PHI_INV,
                );
                if (amount <= 0) continue;
                sur.resource -= amount;
                def.resource += amount;
                const ev: RedistributionEvent = { fromId: sur.id, toId: def.id, amount, reason, tick };
                this.events.push(ev);
                fired.push(ev);
                break;   // one donor per deficit node per tick
            }
        }
        return fired;
    }

    /** Mitma: forcibly relocate population (capacity rebalancing). */
    mitma(fromId: string, toId: string, count: number): void {
        const from = this.nodes.get(fromId);
        const to   = this.nodes.get(toId);
        if (!from || !to) throw new Error('Node not found for mitma');
        const actual = Math.min(count, from.population);
        from.population -= actual;
        to.population   += actual;
    }

    /** Hub summary: per-suyu resource totals + Cusco root resource. */
    summary(): Record<Suyu | 'root', number> {
        const out = {} as Record<Suyu | 'root', number>;
        out['root'] = this.nodes.get(this.rootId)?.resource ?? 0;
        for (const s of ALL_SUYUS) {
            out[s] = this.getSubgraph(s).reduce((a, n) => a + n.resource, 0);
        }
        return out;
    }

    getEvents(): RedistributionEvent[] { return [...this.events]; }
}

// ─── TerraceBench types ───────────────────────────────────────────────────────

export type CropType = 'maize' | 'potato' | 'quinoa' | 'coca' | 'oca' | 'kiwicha';

export interface TerraceConfig {
    id          : string;
    altitudeM   : number;    // altitude in metres (0–6000)
    soilMoisture: number;    // 0–1
    temperature : number;    // °C
    crop        : CropType;
    irrigated   : boolean;
}

export interface TerraceResult {
    terraceId   : string;
    altitudeM   : number;
    crop        : CropType;
    yieldScore  : number;    // 0–1
    adapted     : boolean;   // true if crop is altitude-appropriate
    adaptationFn: number;    // L-78 hormetic adaptation (stressLoad × φ⁻¹)
}

// ─── TerraceBench ─────────────────────────────────────────────────────────────

/**
 * TerraceBench
 *
 * Altitude-parameterised test environments.
 * Each terrace = a controlled micro-climate context (parameterised env).
 * Distributed experimentation: many small benches across altitude bands
 * instead of a single monolithic environment.
 *
 * Analogue to unit-test benches with parameterised configs.
 * The landscape itself is a test suite.
 */
export class TerraceBench {
    private terraces: Map<string, TerraceConfig> = new Map();

    // ── altitude bands ─────────────────────────────────────────────────────────

    /** Altitude-to-crop optimal range (metres). */
    private static readonly CROP_RANGE: Record<CropType, [number, number]> = {
        maize   : [0,    3400],
        potato  : [2700, 4500],
        quinoa  : [3000, 4200],
        coca    : [500,  2000],
        oca     : [2800, 4000],
        kiwicha : [1200, 3600],
    };

    // ── bench registration ─────────────────────────────────────────────────────

    addTerrace(config: TerraceConfig): void {
        this.terraces.set(config.id, config);
    }

    /**
     * Auto-generate a stepped terrace bench across an altitude range.
     * count terraces, evenly spaced, alternating crops.
     */
    generateBench(
        baseAltitude : number,
        topAltitude  : number,
        count        : number,
        crops        : CropType[],
    ): TerraceConfig[] {
        const step = (topAltitude - baseAltitude) / Math.max(count - 1, 1);
        const configs: TerraceConfig[] = [];
        for (let i = 0; i < count; i++) {
            const alt    = baseAltitude + i * step;
            const config : TerraceConfig = {
                id          : `terrace-${i}`,
                altitudeM   : alt,
                soilMoisture: 0.6 - (alt / 10000),     // less moisture at altitude
                temperature : 20  - (alt * 0.0065),    // lapse rate ≈ 6.5°C/km
                crop        : crops[i % crops.length],
                irrigated   : alt < 3500,
            };
            this.terraces.set(config.id, config);
            configs.push(config);
        }
        return configs;
    }

    // ── experiment ─────────────────────────────────────────────────────────────

    /**
     * Run a yield experiment across all registered terraces.
     * Returns a TerraceResult per terrace.
     *
     * Yield model:
     *   stressLoad = deviation from optimal altitude band centre / band half-width
     *   adaptationFn = stressLoad × φ⁻¹  (hormetic L-78 law)  when 0.2 < load < 0.7
     *   yieldScore = irrigationBonus × moistureScore × (1 − stressLoad) × (1 + adaptationFn)
     */
    runExperiment(): TerraceResult[] {
        const results: TerraceResult[] = [];

        for (const t of this.terraces.values()) {
            const [lo, hi] = TerraceBench.CROP_RANGE[t.crop];
            const centre   = (lo + hi) / 2;
            const half     = (hi - lo) / 2;
            const stressLoad = half > 0 ? Math.abs(t.altitudeM - centre) / half : 1;
            const adapted    = t.altitudeM >= lo && t.altitudeM <= hi;

            // L-78 hormetic adaptation: only within 0.2–0.7 range
            const adaptationFn = (stressLoad > 0.2 && stressLoad < 0.7)
                ? stressLoad * PHI_INV
                : 0;

            const irrigBonus   = t.irrigated ? 1.15 : 1.0;
            const moistScore   = Math.max(0, 1 - Math.abs(t.soilMoisture - 0.55) * 2);
            const yieldScore   = Math.min(1,
                irrigBonus * moistScore * (1 - Math.min(stressLoad, 1)) * (1 + adaptationFn)
            );

            results.push({
                terraceId   : t.id,
                altitudeM   : t.altitudeM,
                crop        : t.crop,
                yieldScore,
                adapted,
                adaptationFn,
            });
        }

        return results;
    }

    /** Top-N terraces by yield — the φ-selected survivors. */
    topByYield(n = 5): TerraceResult[] {
        return this.runExperiment()
            .sort((a, b) => b.yieldScore - a.yieldScore)
            .slice(0, n);
    }

    /** Cross-terrace analysis: variance, mean, and φ-optimal count (yield ≥ φ⁻¹). */
    crossTerraceAnalysis(): {
        mean      : number;
        variance  : number;
        phiOptimal: number;
        total     : number;
    } {
        const results = this.runExperiment();
        const n   = results.length;
        if (n === 0) return { mean: 0, variance: 0, phiOptimal: 0, total: 0 };
        const mean = results.reduce((a, r) => a + r.yieldScore, 0) / n;
        const variance = results.reduce((a, r) => a + Math.pow(r.yieldScore - mean, 2), 0) / n;
        const phiOptimal = results.filter(r => r.yieldScore >= PHI_INV).length;
        return { mean, variance, phiOptimal, total: n };
    }
}

// ─── IncaCivilizationEngine ────────────────────────────────────────────────────

/**
 * IncaCivilizationEngine
 *
 * Orchestrator — boots and wires all four Inca substrate systems.
 * Canonical proof: computation = structure + standards + substrate.
 *
 * run() fires one civilizational tick:
 *   1. Quipu records census data for each suyu.
 *   2. QhapaqNan dispatches tribute packets to Cusco.
 *   3. Tawantinsuyu hub redistributes resources to deficit suyus.
 *   4. TerraceBench runs agricultural experiments and returns top yields.
 */
export class IncaCivilizationEngine {
    readonly quipu    = new QuipuEngine();
    readonly mesh     = new QhapaqNanMesh();
    readonly hub      = new TawantinsuyuHub();
    readonly terraces = new TerraceBench();

    private _civilizationTick = 0;

    constructor() {
        this._bootstrapMesh();
        this._bootstrapHub();
        this._bootstrapTerraces();
    }

    // ── civilizational tick ────────────────────────────────────────────────────

    run(): {
        tick         : number;
        quipus       : string[];
        packets      : MessagePacket[];
        redistributed: RedistributionEvent[];
        topYields    : TerraceResult[];
        hubSummary   : Record<Suyu | 'root', number>;
    } {
        const tick = ++this._civilizationTick;

        // 1. Census quipus — one per suyu
        const quipus: string[] = [];
        for (const suyu of ALL_SUYUS) {
            const nodes  = this.hub.getSubgraph(suyu);
            const qid    = this.quipu.createQuipu(suyu, `${suyu}-census-${tick}`);
            const cordId = this.quipu.appendPendant(qid, 'population', 'white');
            nodes.forEach((n, i) =>
                this.quipu.appendKnot(qid, cordId, {
                    type: 'single', position: i, value: n.population % 10, marker: n.id,
                })
            );
            quipus.push(qid);
        }

        // 2. Tribute packets — each suyu sends to Cusco
        const packets: MessagePacket[] = [];
        const tambos = this.mesh.getAllTambos();
        if (tambos.length >= 2) {
            for (const suyu of ALL_SUYUS) {
                const src = tambos.find(t => t.name.includes(suyu));
                const dst = tambos.find(t => t.name === 'Cusco');
                if (src && dst) {
                    packets.push(this.mesh.dispatch(src.id, dst.id, { suyu, tick }, 0.8));
                }
            }
        }

        // 3. Redistribution feedback
        const redistributed = this.hub.redistribute('tribute');

        // 4. Agricultural experiments
        const topYields = this.terraces.topByYield(4);

        return { tick, quipus, packets, redistributed, topYields, hubSummary: this.hub.summary() };
    }

    // ── bootstrap helpers ──────────────────────────────────────────────────────

    private _bootstrapMesh(): void {
        // Cusco root tambo
        this.mesh.addTambo('cusco-tambo',    'Cusco',       'Cusco',        3400);
        this.mesh.addTambo('north-tambo',    'Chinchaysuyu','Quito',        2850);
        this.mesh.addTambo('east-tambo',     'Antisuyu',    'Chachapoyas',  2400);
        this.mesh.addTambo('south-tambo',    'Collasuyu',   'Tiwanaku',     3800);
        this.mesh.addTambo('west-tambo',     'Cuntisuyu',   'Arequipa',     2350);

        this.mesh.addLink('cusco-tambo', 'north-tambo', 'road',             2000, 0.92);
        this.mesh.addLink('cusco-tambo', 'east-tambo',  'suspension-bridge', 800, 0.88);
        this.mesh.addLink('cusco-tambo', 'south-tambo', 'road',             1200, 0.95);
        this.mesh.addLink('cusco-tambo', 'west-tambo',  'road',              950, 0.91);
    }

    private _bootstrapHub(): void {
        this.hub.registerNode('chinchay-1', 'Cajamarca',   'Chinchaysuyu', 'regional', 300, 15000);
        this.hub.registerNode('chinchay-2', 'Quito',       'Chinchaysuyu', 'regional', 250, 10000);
        this.hub.registerNode('anti-1',     'Chachapoyas', 'Antisuyu',     'leaf',     120,  4000);
        this.hub.registerNode('anti-2',     'Vilcabamba',  'Antisuyu',     'leaf',      80,  2000);
        this.hub.registerNode('colla-1',    'Tiwanaku',    'Collasuyu',    'regional', 400, 20000);
        this.hub.registerNode('colla-2',    'Tucumán',     'Collasuyu',    'leaf',     150,  5000);
        this.hub.registerNode('cunti-1',    'Arequipa',    'Cuntisuyu',    'regional', 200,  8000);
        this.hub.registerNode('cunti-2',    'Nazca',       'Cuntisuyu',    'leaf',      90,  3000);
    }

    private _bootstrapTerraces(): void {
        this.terraces.generateBench(
            0, 4500, 12,
            ['maize', 'coca', 'potato', 'quinoa', 'oca', 'kiwicha'],
        );
    }
}
