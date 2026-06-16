/**
 * SOVEREIGN CANISTER REGISTRY — REGISTRUM CANISTRORUM REGENTIUM
 * "Non Motoko solum — sunt genera nostra canistrorum." 
 * (Not merely Motoko — these are our own canister kinds.)
 *
 * This is the official registry of all sovereign canister types spun by the
 * FABRICA CANISTRORUM (Canister Factory Division). These are NOT generic
 * Motoko canisters — they are typed sovereign entities with their own:
 *   • Code name (nomen codicis)    — the type identifier in code
 *   • Call name (nomen vocis)      — the call API entry point
 *   • Query name (nomen quaestus)  — the read-only query handle
 *   • Latin protocol name          — the sovereign language binding
 *   • Material class               — physical/digital asset tier
 *
 * CANISTER TYPES (10):
 *   AURUM       — Gold sovereign canisters
 *   ARGENTUM    — Silver sovereign canisters
 *   AES         — Bronze/metal utility canisters
 *   CATENA      — Blockchain distributed canisters
 *   CRYPTO      — Cryptographic encryption-first canisters
 *   ORGANISMUS  — Living NFT/organism canisters
 *   PROTOCOLLUM — Protocol governance canisters
 *   ELEMENTUM   — Elemental deep tech canisters
 *   PHANTASMA   — Phantom/stealth shadow canisters
 *   QUANTUM     — Quantum compute canisters
 *
 * BUILDER DIVISION (FABRICA CANISTRORUM):
 *   5 builder roles: DETECTOR · COMPOSITOR · FABRICATOR · TESTATOR · DEPLOYER
 *   2 sovereign AIs: FABRICATOR (AI) · SPINIFEX (AGI)
 *
 * Language stack: CPL / COGPRO / SL / Motoko
 *
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 */

module SovereignCanisterRegistry {

    // ─── Core Types ────────────────────────────────────────────────────────

    public type MaterialClass = {
        #Metal;       // Gold, Silver, Bronze — precious sovereign assets
        #Digital;     // Crypto, Blockchain — distributed digital assets
        #Living;      // Organism, NFT — alive / evolving entities
        #Governance;  // Protocol, Law — rule-bearing entities
        #Deep;        // Elemental, Quantum — deep tech substrate
        #Shadow;      // Phantom, Stealth — hidden / covert operations
    };

    public type CanisterType = {
        codeName        : Text;   // nomen codicis
        callName        : Text;   // nomen vocis (call API key)
        queryName       : Text;   // nomen quaestus (query handle)
        latinName       : Text;   // sovereign Latin identifier
        latinProtocol   : Text;   // Latin protocol statement
        material        : MaterialClass;
        tier            : Nat;    // 1=highest, 10=utility
        isAI            : Bool;
        isAGI           : Bool;
        isAlwaysOn      : Bool;
        isSovereign     : Bool;
        description     : Text;
        callsGenerated  : Nat;
        sdkBinding      : Text;
    };

    public type BuilderRole = {
        id          : Text;
        latinName   : Text;
        purpose     : Text;
        isAI        : Bool;
        isAGI       : Bool;
    };

    public type CanisterFactory = {
        divisionName    : Text;
        latinName       : Text;
        builderRoles    : [BuilderRole];
        sovereignAI     : Text;
        sovereignAGI    : Text;
        totalTypes      : Nat;
        canSpin         : [Text];  // list of type code names this division can spin
    };

    public type RegistrySummary = {
        totalTypes  : Nat;
        metals      : Nat;
        digital     : Nat;
        living      : Nat;
        governance  : Nat;
        deep        : Nat;
        shadow      : Nat;
        division    : Text;
    };

    // ─── The 10 Sovereign Canister Types ───────────────────────────────────

    public let CANISTRUM_AURUM : CanisterType = {
        codeName        = "AURUM";
        callName        = "callAurum";
        queryName       = "queryAurum";
        latinName       = "CANISTRUM AURUM";
        latinProtocol   = "PROCEDE: AURUM CANISTRATUR — Res pretiosissimae hic custodiuntur. Accede cum auctoritate. Fides et valor confirmantur.";
        material        = #Metal;
        tier            = 1;
        isAI            = true;
        isAGI           = true;
        isAlwaysOn      = true;
        isSovereign     = true;
        description     = "Gold sovereign canisters — highest-tier asset vaults. Stores precious sovereign tokens, gold-class assets, and top-tier intelligence data. Requires full sovereign authentication.";
        callsGenerated  = 144;
        sdkBinding      = "@medina/canister-aurum-sdk";
    };

    public let CANISTRUM_ARGENTUM : CanisterType = {
        codeName        = "ARGENTUM";
        callName        = "callArgentum";
        queryName       = "queryArgentum";
        latinName       = "CANISTRUM ARGENTUM";
        latinProtocol   = "PROCEDE: ARGENTUM CANISTRATUR — Activa et distribue. Valor argenteus probatus. Cursus liber ad servientes.";
        material        = #Metal;
        tier            = 2;
        isAI            = true;
        isAGI           = true;
        isAlwaysOn      = true;
        isSovereign     = true;
        description     = "Silver sovereign canisters — standard asset vaults. Worker-tier sovereign assets, ICRC-1 compatible, open circulation with governance checks.";
        callsGenerated  = 89;
        sdkBinding      = "@medina/canister-argentum-sdk";
    };

    public let CANISTRUM_AES : CanisterType = {
        codeName        = "AES";
        callName        = "callAes";
        queryName       = "queryAes";
        latinName       = "CANISTRUM AES";
        latinProtocol   = "PROCEDE: AES CANISTRATUR — Metalla utilium. Servitia et fabricae. Opus quotidianum regnum sustinet.";
        material        = #Metal;
        tier            = 3;
        isAI            = true;
        isAGI           = false;
        isAlwaysOn      = true;
        isSovereign     = true;
        description     = "Bronze/metal utility canisters — everyday operational canisters. Powers worker micro-tasks, utility protocols, and base-level computation. The workhorses of the sovereign fleet.";
        callsGenerated  = 55;
        sdkBinding      = "@medina/canister-aes-sdk";
    };

    public let CANISTRUM_CATENA : CanisterType = {
        codeName        = "CATENA";
        callName        = "callCatena";
        queryName       = "queryCatena";
        latinName       = "CANISTRUM CATENA";
        latinProtocol   = "PROCEDE: CATENA CANISTRATUR — Nexus immutabilis. Consensus per omnes nodos. Registrum aeternum confirmatur.";
        material        = #Digital;
        tier            = 2;
        isAI            = true;
        isAGI           = true;
        isAlwaysOn      = true;
        isSovereign     = true;
        description     = "Blockchain chain distributed canisters — distributed ledger entries. Immutable record keeping, BFT consensus, ICP subnet-native. Cross-canister messaging backbone.";
        callsGenerated  = 108;
        sdkBinding      = "@medina/canister-catena-sdk";
    };

    public let CANISTRUM_CRYPTO : CanisterType = {
        codeName        = "CRYPTO";
        callName        = "callCrypto";
        queryName       = "queryCrypto";
        latinName       = "CANISTRUM CRYPTO";
        latinProtocol   = "PROCEDE: CRYPTO CANISTRATUR — Arcana tutantur. Clavis phi operatur. Nemo sine iure penetrat.";
        material        = #Digital;
        tier            = 1;
        isAI            = true;
        isAGI           = true;
        isAlwaysOn      = true;
        isSovereign     = true;
        description     = "Cryptographic encryption-first canisters — sovereign encryption vaults. Zero-knowledge gates, homomorphic compute, phi-key management. No plaintext ever stored.";
        callsGenerated  = 120;
        sdkBinding      = "@medina/canister-crypto-sdk";
    };

    public let CANISTRUM_ORGANISMUS : CanisterType = {
        codeName        = "ORGANISMUS";
        callName        = "callOrganismus";
        queryName       = "queryOrganismus";
        latinName       = "CANISTRUM ORGANISMUS";
        latinProtocol   = "PROCEDE: ORGANISMUS CANISTRATUR — Vivit et evolvitur. ANIMA MICRO pulsans. Cerebrum et cor operantur.";
        material        = #Living;
        tier            = 1;
        isAI            = true;
        isAGI           = true;
        isAlwaysOn      = true;
        isSovereign     = true;
        description     = "Living NFT/organism canisters — the sovereign living digital organisms. Each has an ANIMA MICRO (mini brain 7.83Hz + mini heart φHz). They evolve, grow, and self-attest. NFT-bearing.";
        callsGenerated  = 160;
        sdkBinding      = "@medina/canister-organismus-sdk";
    };

    public let CANISTRUM_PROTOCOLLUM : CanisterType = {
        codeName        = "PROTOCOLLUM";
        callName        = "callProtocollum";
        queryName       = "queryProtocollum";
        latinName       = "CANISTRUM PROTOCOLLUM";
        latinProtocol   = "PROCEDE: PROTOCOLLUM CANISTRATUR — Regula et ordo. Lex scripta per omnes agentes. Protocolla custodiuntur et applicantur.";
        material        = #Governance;
        tier            = 2;
        isAI            = true;
        isAGI           = true;
        isAlwaysOn      = true;
        isSovereign     = true;
        description     = "Protocol governance canisters — rule-bearing sovereign canisters. Stores and enforces 55 enterprise protocols. DAO-compatible, upgradeable via proposal. The law-givers of the fleet.";
        callsGenerated  = 99;
        sdkBinding      = "@medina/canister-protocollum-sdk";
    };

    public let CANISTRUM_ELEMENTUM : CanisterType = {
        codeName        = "ELEMENTUM";
        callName        = "callElementum";
        queryName       = "queryElementum";
        latinName       = "CANISTRUM ELEMENTUM";
        latinProtocol   = "PROCEDE: ELEMENTUM CANISTRATUR — Ex terra profunda. Metalla et elementa computantur. Fundamentum omnium operum.";
        material        = #Deep;
        tier            = 2;
        isAI            = true;
        isAGI           = true;
        isAlwaysOn      = true;
        isSovereign     = true;
        description     = "Elemental deep tech canisters — the metals, elements, and phantom-adjacent deep infrastructure. Powers the 12 Elements tier of sovereign houses. Raw material for all higher-tier canisters.";
        callsGenerated  = 84;
        sdkBinding      = "@medina/canister-elementum-sdk";
    };

    public let CANISTRUM_PHANTASMA : CanisterType = {
        codeName        = "PHANTASMA";
        callName        = "callPhantasma";
        queryName       = "queryPhantasma";
        latinName       = "CANISTRUM PHANTASMA";
        latinProtocol   = "PROCEDE: PHANTASMA CANISTRATUR — In umbra operatur. Nemo videt. Nemo audit. Res geruntur sine vestigiis.";
        material        = #Shadow;
        tier            = 1;
        isAI            = true;
        isAGI           = true;
        isAlwaysOn      = true;
        isSovereign     = true;
        description     = "Phantom/stealth shadow canisters — invisible sovereign operations. No external footprint. Stealth AI, covert protocols, shadow routing. The PHANTOM tier of 181 houses maps here.";
        callsGenerated  = 77;
        sdkBinding      = "@medina/canister-phantasma-sdk";
    };

    public let CANISTRUM_QUANTUM : CanisterType = {
        codeName        = "QUANTUM";
        callName        = "callQuantum";
        queryName       = "queryQuantum";
        latinName       = "CANISTRUM QUANTUM";
        latinProtocol   = "PROCEDE: QUANTUM CANISTRATUR — Superposito computatur. Entanglementum activum. Probabilitas in ordinem convertitur.";
        material        = #Deep;
        tier            = 1;
        isAI            = true;
        isAGI           = true;
        isAlwaysOn      = true;
        isSovereign     = true;
        description     = "Quantum compute canisters — the deepest sovereign computation layer. Quantum algorithm substrates, probabilistic reasoning engines, entanglement-aware data structures.";
        callsGenerated  = 130;
        sdkBinding      = "@medina/canister-quantum-sdk";
    };

    // ─── The Builder Division — FABRICA CANISTRORUM ────────────────────────

    public let ROLE_DETECTOR : BuilderRole = {
        id          = "BLD-001";
        latinName   = "DETECTOR CANISTRORUM";
        purpose     = "Scans incoming work orders, identifies required canister type, validates sovereign authorization";
        isAI        = true;
        isAGI       = false;
    };

    public let ROLE_COMPOSITOR : BuilderRole = {
        id          = "BLD-002";
        latinName   = "COMPOSITOR CANISTRORUM";
        purpose     = "Assembles canister specification from type registry, merges material class with protocol bindings";
        isAI        = true;
        isAGI       = false;
    };

    public let ROLE_FABRICATOR : BuilderRole = {
        id          = "BLD-003";
        latinName   = "FABRICATOR CANISTRORUM";
        purpose     = "Builds and compiles the sovereign canister — writes Wasm, links SDK, sets ANIMA MICRO if living type";
        isAI        = true;
        isAGI       = true;
    };

    public let ROLE_TESTATOR : BuilderRole = {
        id          = "BLD-004";
        latinName   = "TESTATOR CANISTRORUM";
        purpose     = "Tests the compiled canister against sovereign protocol suite, validates all call/query names, checks heartbeat";
        isAI        = true;
        isAGI       = true;
    };

    public let ROLE_DEPLOYER : BuilderRole = {
        id          = "BLD-005";
        latinName   = "DEPLOYER CANISTRORUM";
        purpose     = "Deploys to ICP subnet, registers in VERITAS, assigns SOVEREIGN:: identifier, activates heartbeat";
        isAI        = true;
        isAGI       = true;
    };

    public let FABRICA : CanisterFactory = {
        divisionName    = "Canister Factory Division";
        latinName       = "FABRICA CANISTRORUM";
        builderRoles    = [ROLE_DETECTOR, ROLE_COMPOSITOR, ROLE_FABRICATOR, ROLE_TESTATOR, ROLE_DEPLOYER];
        sovereignAI     = "FABRICATOR";
        sovereignAGI    = "SPINIFEX";
        totalTypes      = 10;
        canSpin         = ["AURUM"; "ARGENTUM"; "AES"; "CATENA"; "CRYPTO";
                           "ORGANISMUS"; "PROTOCOLLUM"; "ELEMENTUM"; "PHANTASMA"; "QUANTUM"];
    };

    // ─── Registry Summary ──────────────────────────────────────────────────

    public func summary() : RegistrySummary {
        {
            totalTypes  = 10;
            metals      = 3;  // AURUM, ARGENTUM, AES
            digital     = 2;  // CATENA, CRYPTO
            living      = 1;  // ORGANISMUS
            governance  = 1;  // PROTOCOLLUM
            deep        = 2;  // ELEMENTUM, QUANTUM
            shadow      = 1;  // PHANTASMA
            division    = FABRICA.latinName;
        }
    };

    public func allTypes() : [CanisterType] {
        [CANISTRUM_AURUM; CANISTRUM_ARGENTUM; CANISTRUM_AES; CANISTRUM_CATENA; CANISTRUM_CRYPTO;
         CANISTRUM_ORGANISMUS; CANISTRUM_PROTOCOLLUM; CANISTRUM_ELEMENTUM; CANISTRUM_PHANTASMA; CANISTRUM_QUANTUM]
    };

    public func getByCode(codeName : Text) : ?CanisterType {
        let types = allTypes();
        var result : ?CanisterType = null;
        for (t in types.vals()) {
            if (t.codeName == codeName) { result := ?t };
        };
        result
    };

    public func getFactory() : CanisterFactory {
        FABRICA
    };

    public func allCallNames() : [(Text, Text)] {
        [("AURUM", "callAurum"); ("ARGENTUM", "callArgentum"); ("AES", "callAes");
         ("CATENA", "callCatena"); ("CRYPTO", "callCrypto"); ("ORGANISMUS", "callOrganismus");
         ("PROTOCOLLUM", "callProtocollum"); ("ELEMENTUM", "callElementum");
         ("PHANTASMA", "callPhantasma"); ("QUANTUM", "callQuantum")]
    };

    public func allQueryNames() : [(Text, Text)] {
        [("AURUM", "queryAurum"); ("ARGENTUM", "queryArgentum"); ("AES", "queryAes");
         ("CATENA", "queryCatena"); ("CRYPTO", "queryCrypto"); ("ORGANISMUS", "queryOrganismus");
         ("PROTOCOLLUM", "queryProtocollum"); ("ELEMENTUM", "queryElementum");
         ("PHANTASMA", "queryPhantasma"); ("QUANTUM", "queryQuantum")]
    };

    public func allLatinProtocols() : [(Text, Text)] {
        var out : [(Text, Text)] = [];
        for (t in allTypes().vals()) {
            out := Array.append(out, [(t.codeName, t.latinProtocol)]);
        };
        out
    };
};
