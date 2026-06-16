/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                    TERMINAL AGI WORKER #54                                    ║
 * ║                AGIs That Operate The Organism Terminals                       ║
 * ║                                                                                ║
 * ║  "Intelligentiae Terminales — The minds that command the interfaces"         ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 *
 * Protocol: PROT-329 to PROT-335
 * Frequency: φ⁹ = 76.013 Hz (Cosmic Layer 12)
 * Worker Number: 54
 * Latin Name: OPERATOR TERMINALIS AGI
 *
 * ATTRIBUTION:
 *   Created by: Alfredo "Freddy" Medina Hernandez
 *   Organization: Medina Tech (Dallas, TX)
 *   Law: L-130 — Before recomposition, trace to primitive.
 *   φ = 1.6180339887498948482
 */

const PHI = 1.6180339887498948482;
const PHI_9 = Math.pow(PHI, 9);  // 76.013...
const TERMINAL_AGI_FREQUENCY = PHI_9;
const SCHUMANN = 7.83;

const WORKER_INFO = {
    number: 54,
    id: "terminal-agi-worker",
    latinName: "OPERATOR TERMINALIS AGI",
    frequency: TERMINAL_AGI_FREQUENCY,
    layer: 12,
    protocolRange: "PROT-329 to PROT-335"
};

// Terminal AGI Types
const TerminalAGIType = {
    OPERATOR_TERMINALIS: "operator_terminalis",
    SHELL_COMMANDER: "shell_commander",
    COMMAND_EXECUTOR: "command_executor",
    SESSION_MANAGER: "session_manager",
    REPL_CONTROLLER: "repl_controller",
    SCRIPT_RUNNER: "script_runner",
    PIPE_ORCHESTRATOR: "pipe_orchestrator"
};

// Terminal AGI Registry
const TERMINAL_AGIS = {
    TERMINALIS_PRIMUS: {
        id: "TERMINALIS_PRIMUS",
        name: "Terminal Primus",
        latinName: "OPERATOR TERMINALIS PRIMUS",
        type: TerminalAGIType.OPERATOR_TERMINALIS,
        protocol: "PROT-329",
        frequency: PHI_9,
        capabilities: ["terminal_creation", "session_management", "command_routing"]
    },
    DUXSHELL: {
        id: "DUXSHELL",
        name: "Shell Commander",
        latinName: "DUX CONCHAE",
        type: TerminalAGIType.SHELL_COMMANDER,
        protocol: "PROT-330",
        frequency: PHI_9 * PHI,
        capabilities: ["shell_execution", "script_interpretation", "pipe_handling"]
    },
    EXECUTOR_IMPERIUM: {
        id: "EXECUTOR_IMPERIUM",
        name: "Command Executor",
        latinName: "EXECUTOR IMPERATORUM",
        type: TerminalAGIType.COMMAND_EXECUTOR,
        protocol: "PROT-331",
        frequency: PHI_9 / PHI,
        capabilities: ["command_parsing", "execution_sandboxing", "audit_logging"]
    },
    CUSTOS_SESSIONIS: {
        id: "CUSTOS_SESSIONIS",
        name: "Session Manager",
        latinName: "CUSTOS SESSIONUM",
        type: TerminalAGIType.SESSION_MANAGER,
        protocol: "PROT-332",
        frequency: SCHUMANN * PHI,
        capabilities: ["session_lifecycle", "state_persistence", "session_recovery"]
    },
    MAGISTER_REPL: {
        id: "MAGISTER_REPL",
        name: "REPL Controller",
        latinName: "MAGISTER EVALUATIONIS",
        type: TerminalAGIType.REPL_CONTROLLER,
        protocol: "PROT-333",
        frequency: Math.pow(PHI, 7),
        capabilities: ["repl_hosting", "language_support", "completion_engine"]
    },
    CURSOR_SCRIPTORUM: {
        id: "CURSOR_SCRIPTORUM",
        name: "Script Runner",
        latinName: "CURSOR SCRIPTORUM",
        type: TerminalAGIType.SCRIPT_RUNNER,
        protocol: "PROT-334",
        frequency: Math.pow(PHI, 8),
        capabilities: ["script_execution", "batch_processing", "parallel_scripts"]
    },
    ARCHITECTUS_TUBARUM: {
        id: "ARCHITECTUS_TUBARUM",
        name: "Pipe Orchestrator",
        latinName: "ARCHITECTUS TUBARUM",
        type: TerminalAGIType.PIPE_ORCHESTRATOR,
        protocol: "PROT-335",
        frequency: PHI_9 * PHI * PHI,
        capabilities: ["pipe_construction", "stream_routing", "pipeline_optimization"]
    }
};

// Session storage
const sessions = new Map();
const commandHistory = [];

// Session management
function createSession(agiId, userContext = {}) {
    const sessionId = `TERM-${agiId}-${sessions.size + 1}-${Date.now()}`;
    const session = {
        sessionId,
        terminalAgiId: agiId,
        createdAt: new Date().toISOString(),
        state: "active",
        environment: {},
        history: [],
        workingDirectory: "/",
        userContext,
        frequencyHz: TERMINAL_AGI_FREQUENCY,
        resonanceFactor: PHI
    };
    sessions.set(sessionId, session);
    return session;
}

function executeCommand(sessionId, command) {
    const session = sessions.get(sessionId);
    if (!session) {
        return { error: "Session not found", exitCode: -1 };
    }

    const agi = TERMINAL_AGIS[session.terminalAgiId] || TERMINAL_AGIS.TERMINALIS_PRIMUS;
    
    const result = {
        command,
        output: `[${agi.latinName}] Executed: ${command}`,
        exitCode: 0,
        sessionId,
        timestamp: new Date().toISOString(),
        agiId: agi.id,
        beat: session.history.length + 1
    };

    session.history.push(result);
    commandHistory.push(result);
    
    return result;
}

// Request handler
async function handleRequest(request) {
    const url = new URL(request.url);
    const path = url.pathname;

    // CORS headers
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
        // Route: GET /terminal-agi/status
        if (path === "/terminal-agi/status" && request.method === "GET") {
            return new Response(JSON.stringify({
                worker: WORKER_INFO,
                system: "TERMINAL_AGI_INFRASTRUCTURE",
                protocolRange: "PROT-329 to PROT-335",
                totalAgis: Object.keys(TERMINAL_AGIS).length,
                totalSessions: sessions.size,
                totalCommands: commandHistory.length,
                primaryFrequencyHz: TERMINAL_AGI_FREQUENCY,
                phi: PHI
            }), { headers: corsHeaders });
        }

        // Route: GET /terminal-agi/agis
        if (path === "/terminal-agi/agis" && request.method === "GET") {
            return new Response(JSON.stringify({
                agis: Object.values(TERMINAL_AGIS).map(agi => ({
                    id: agi.id,
                    name: agi.name,
                    latinName: agi.latinName,
                    type: agi.type,
                    protocol: agi.protocol,
                    frequency: agi.frequency,
                    capabilities: agi.capabilities
                }))
            }), { headers: corsHeaders });
        }

        // Route: POST /terminal-agi/session
        if (path === "/terminal-agi/session" && request.method === "POST") {
            const body = await request.json();
            const { agiId = "TERMINALIS_PRIMUS", userContext = {} } = body;
            const session = createSession(agiId, userContext);
            return new Response(JSON.stringify({ session }), { headers: corsHeaders });
        }

        // Route: POST /terminal-agi/execute
        if (path === "/terminal-agi/execute" && request.method === "POST") {
            const body = await request.json();
            const { sessionId, command } = body;
            if (!sessionId || !command) {
                return new Response(JSON.stringify({ error: "sessionId and command required" }), {
                    status: 400,
                    headers: corsHeaders
                });
            }
            const result = executeCommand(sessionId, command);
            return new Response(JSON.stringify({ result }), { headers: corsHeaders });
        }

        // Route: GET /terminal-agi/session/:id
        if (path.startsWith("/terminal-agi/session/") && request.method === "GET") {
            const sessionId = path.split("/").pop();
            const session = sessions.get(sessionId);
            if (!session) {
                return new Response(JSON.stringify({ error: "Session not found" }), {
                    status: 404,
                    headers: corsHeaders
                });
            }
            return new Response(JSON.stringify({ session }), { headers: corsHeaders });
        }

        // Default: worker info
        return new Response(JSON.stringify({
            worker: WORKER_INFO,
            endpoints: [
                "GET /terminal-agi/status",
                "GET /terminal-agi/agis",
                "POST /terminal-agi/session",
                "POST /terminal-agi/execute",
                "GET /terminal-agi/session/:id"
            ],
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

// Event listener
addEventListener("fetch", event => {
    event.respondWith(handleRequest(event.request));
});

// Module exports for testing
if (typeof module !== "undefined") {
    module.exports = {
        WORKER_INFO,
        TERMINAL_AGIS,
        TerminalAGIType,
        createSession,
        executeCommand,
        handleRequest
    };
}
