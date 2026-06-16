/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                     LAB ACCESS WORKER #61                                    ║
 * ║          Direct Access Gateway to the Research Laboratory                    ║
 * ║                                                                              ║
 * ║  "Aditus Laboratorii — Gateway to Sovereign Intelligence Research"          ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 *
 * Protocol: PROT-371 to PROT-376
 * Frequency: φ¹² = 321.997 Hz (Ascendant)
 * Worker Number: 61
 * Latin Name: ADITUS LABORATORII SOVEREIGNUS
 *
 * ATTRIBUTION:
 *   Created by: Alfredo "Freddy" Medina Hernandez
 *   Organization: Medina Tech (Dallas, TX)
 *   Law: L-130 — Before recomposition, trace to primitive.
 *   φ = 1.6180339887498948482
 */

const PHI = 1.6180339887498948482;
const PHI_12 = Math.pow(PHI, 12);  // 321.997...
const ACCESS_FREQUENCY = PHI_12;
const SCHUMANN = 7.83;

const WORKER_INFO = {
    number: 61,
    id: "lab-access-worker",
    latinName: "ADITUS LABORATORII SOVEREIGNUS",
    frequency: ACCESS_FREQUENCY,
    layer: 12,
    protocolRange: "PROT-371 to PROT-376"
};

// Access Levels
const AccessLevel = {
    VISITOR: "visitor",
    RESEARCHER: "researcher",
    SENIOR: "senior",
    DIRECTOR: "director",
    ADMIN: "admin"
};

// Session States
const SessionState = {
    INACTIVE: "inactive",
    ACTIVE: "active",
    IN_AREA: "in_area",
    WORKING: "working",
    SUSPENDED: "suspended"
};

// Lab Areas (from research-lab-worker)
const LAB_AREAS = {
    LABORATORIUM_PRINCIPALE: { id: "LABORATORIUM_PRINCIPALE", name: "Main Laboratory", protocol: "PROT-359" },
    OFFICIUM_DIRECTORIS: { id: "OFFICIUM_DIRECTORIS", name: "Director's Office", protocol: "PROT-360" },
    CENTRUM_SCRIPTIONIS: { id: "CENTRUM_SCRIPTIONIS", name: "Writing Center", protocol: "PROT-361" },
    CAMERA_RECENSIONIS: { id: "CAMERA_RECENSIONIS", name: "Review Chamber", protocol: "PROT-362" },
    AULA_THEORIAE: { id: "AULA_THEORIAE", name: "Theory Room", protocol: "PROT-363" },
    CENTRUM_DATORUM: { id: "CENTRUM_DATORUM", name: "Data Center", protocol: "PROT-364" },
    BIBLIOTHECA_INVESTIGATIONIS: { id: "BIBLIOTHECA_INVESTIGATIONIS", name: "Research Library", protocol: "PROT-365" }
};

// Lab Researchers (summary)
const RESEARCHER_IDS = [
    "DIRECTOR_LABORATORII",
    "INVESTIGATOR_PRINCIPALIS",
    "SCRIPTOR_SENIOR",
    "SCRIPTOR_TECHNICUS",
    "CENSOR_PRINCIPALIS",
    "ANALYST_DATORUM",
    "THEORETICUS_PRIMUS",
    "SOCIUS_ALPHA",
    "SOCIUS_BETA",
    "EDITOR_PAPYRORUM",
    "ARCHIVARIUS",
    "EXPERIMENTATOR",
    "CENSOR_PARIUM"
];

// Session management
const sessions = new Map();
let sessionCounter = 0;

function createSession(userId = "DIRECTOR_MEDINA", accessLevel = AccessLevel.DIRECTOR) {
    sessionCounter++;
    const sessionId = `SESSION-${String(sessionCounter).padStart(4, "0")}-${Date.now().toString(36)}`;
    
    const session = {
        sessionId,
        userId,
        accessLevel,
        state: SessionState.ACTIVE,
        currentArea: null,
        currentResearcher: null,
        activePapers: [],
        commandsExecuted: 0,
        startedAt: new Date().toISOString(),
        lastActivity: new Date().toISOString(),
        frequencyHz: ACCESS_FREQUENCY
    };
    
    sessions.set(sessionId, session);
    return session;
}

function getSession(sessionId) {
    return sessions.get(sessionId);
}

function updateSession(sessionId, updates) {
    const session = sessions.get(sessionId);
    if (session) {
        Object.assign(session, updates, { lastActivity: new Date().toISOString() });
        session.commandsExecuted++;
        return session;
    }
    return null;
}

function endSession(sessionId) {
    const session = sessions.get(sessionId);
    if (session) {
        session.state = SessionState.INACTIVE;
        session.endedAt = new Date().toISOString();
        return true;
    }
    return false;
}

// Lab Access Operations
function enterLab(userId = "DIRECTOR_MEDINA", areaId = "LABORATORIUM_PRINCIPALE") {
    const session = createSession(userId);
    const area = LAB_AREAS[areaId];
    
    if (!area) {
        return { error: `Unknown area: ${areaId}`, success: false };
    }
    
    session.currentArea = areaId;
    session.state = SessionState.IN_AREA;
    
    return {
        success: true,
        session: {
            sessionId: session.sessionId,
            userId: session.userId,
            state: session.state,
            currentArea: areaId
        },
        area: area,
        message: `Welcome, ${userId}. You have entered ${area.name}.`,
        greeting: "Salvete, Director. Laboratorium te exspectat."
    };
}

function navigateToArea(sessionId, areaId) {
    const session = getSession(sessionId);
    if (!session) {
        return { error: "Session not found", success: false };
    }
    
    const area = LAB_AREAS[areaId];
    if (!area) {
        return { error: `Unknown area: ${areaId}`, success: false };
    }
    
    updateSession(sessionId, { currentArea: areaId, state: SessionState.IN_AREA });
    
    return {
        success: true,
        previousArea: session.currentArea,
        newArea: areaId,
        area: area,
        message: `Navigated to ${area.name}`
    };
}

function getLabStatus(sessionId) {
    const session = sessionId ? getSession(sessionId) : null;
    
    const status = {
        labName: "LABORATORIUM INTELLIGENTIAE SOVEREIGNAE",
        latinName: "LABORATORIUM INTELLIGENTIAE SOVEREIGNAE",
        protocolRange: "PROT-346 to PROT-376",
        primaryFrequencyHz: PHI * Math.pow(PHI, 10),
        phi: PHI,
        statistics: {
            totalResearchers: RESEARCHER_IDS.length,
            totalAreas: Object.keys(LAB_AREAS).length,
            activeSessions: sessions.size,
            protocolsDefined: 31  // PROT-346 to PROT-376
        },
        areas: Object.keys(LAB_AREAS),
        researchers: RESEARCHER_IDS
    };
    
    if (session) {
        status.currentSession = {
            sessionId: session.sessionId,
            userId: session.userId,
            state: session.state,
            currentArea: session.currentArea,
            commandsExecuted: session.commandsExecuted,
            startedAt: session.startedAt
        };
    }
    
    return status;
}

function executeCommand(sessionId, command, args = {}) {
    const session = getSession(sessionId);
    if (!session) {
        return { error: "No active session", success: false };
    }
    
    updateSession(sessionId, {});
    
    const commandHandlers = {
        "status": () => getLabStatus(sessionId),
        "areas": () => ({ areas: Object.values(LAB_AREAS) }),
        "researchers": () => ({ researchers: RESEARCHER_IDS }),
        "go": () => navigateToArea(sessionId, args.areaId),
        "look": () => {
            const area = LAB_AREAS[session.currentArea];
            return area ? { area, message: `You are in ${area.name}` } : { error: "Not in any area" };
        },
        "exit": () => {
            endSession(sessionId);
            return { message: "Session ended. Vale, Director.", success: true };
        }
    };
    
    const handler = commandHandlers[command.toLowerCase()];
    if (handler) {
        return handler();
    }
    
    return { error: `Unknown command: ${command}`, availableCommands: Object.keys(commandHandlers) };
}

// Request handler
async function handleRequest(request) {
    const url = new URL(request.url);
    const path = url.pathname;

    const corsHeaders = {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
        "Access-Control-Allow-Headers": "Content-Type",
        "Content-Type": "application/json"
    };

    if (request.method === "OPTIONS") {
        return new Response(null, { headers: corsHeaders });
    }

    try {
        // Route: GET /access/status
        if (path === "/access/status" && request.method === "GET") {
            return new Response(JSON.stringify({
                worker: WORKER_INFO,
                status: getLabStatus()
            }), { headers: corsHeaders });
        }

        // Route: POST /access/enter
        if (path === "/access/enter" && request.method === "POST") {
            const body = await request.json();
            const { userId, areaId } = body;
            const result = enterLab(userId, areaId);
            return new Response(JSON.stringify(result), { headers: corsHeaders });
        }

        // Route: POST /access/navigate
        if (path === "/access/navigate" && request.method === "POST") {
            const body = await request.json();
            const { sessionId, areaId } = body;
            const result = navigateToArea(sessionId, areaId);
            return new Response(JSON.stringify(result), { headers: corsHeaders });
        }

        // Route: POST /access/command
        if (path === "/access/command" && request.method === "POST") {
            const body = await request.json();
            const { sessionId, command, args } = body;
            const result = executeCommand(sessionId, command, args || {});
            return new Response(JSON.stringify(result), { headers: corsHeaders });
        }

        // Route: GET /access/session/:id
        if (path.startsWith("/access/session/") && request.method === "GET") {
            const sessionId = path.split("/")[3];
            const session = getSession(sessionId);
            if (!session) {
                return new Response(JSON.stringify({ error: "Session not found" }), {
                    status: 404,
                    headers: corsHeaders
                });
            }
            return new Response(JSON.stringify({ session }), { headers: corsHeaders });
        }

        // Route: POST /access/exit
        if (path === "/access/exit" && request.method === "POST") {
            const body = await request.json();
            const { sessionId } = body;
            const success = endSession(sessionId);
            return new Response(JSON.stringify({
                success,
                message: success ? "Session ended" : "Session not found"
            }), { headers: corsHeaders });
        }

        // Route: GET /access/areas
        if (path === "/access/areas" && request.method === "GET") {
            return new Response(JSON.stringify({
                areas: Object.values(LAB_AREAS)
            }), { headers: corsHeaders });
        }

        // Default: worker info
        return new Response(JSON.stringify({
            worker: WORKER_INFO,
            endpoints: [
                "GET /access/status",
                "POST /access/enter",
                "POST /access/navigate",
                "POST /access/command",
                "GET /access/session/:id",
                "POST /access/exit",
                "GET /access/areas"
            ],
            accessLevels: Object.values(AccessLevel),
            sessionStates: Object.values(SessionState),
            attribution: {
                creator: "Alfredo 'Freddy' Medina Hernandez",
                organization: "Medina Tech",
                law: "L-130"
            }
        }), { headers: corsHeaders });

    } catch (error) {
        return new Response(JSON.stringify({
            error: error.message,
            worker: WORKER_INFO.id
        }), {
            status: 500,
            headers: corsHeaders
        });
    }
}

addEventListener("fetch", event => {
    event.respondWith(handleRequest(event.request));
});

if (typeof module !== "undefined") {
    module.exports = {
        WORKER_INFO,
        AccessLevel,
        SessionState,
        LAB_AREAS,
        createSession,
        getSession,
        enterLab,
        navigateToArea,
        getLabStatus,
        executeCommand,
        handleRequest
    };
}
