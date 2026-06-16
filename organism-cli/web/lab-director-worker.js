/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                    LAB DIRECTOR WORKER #58                                    ║
 * ║              Strategic Direction & Research Coordination                      ║
 * ║                                                                                ║
 * ║  "Director Laboratorii — The sovereign guide of research"                    ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 *
 * Protocol: PROT-346, PROT-370
 * Frequency: φ¹² = 321.997 Hz (Transcendent+)
 * Worker Number: 58
 * Latin Name: DIRECTOR LABORATORII SOVEREIGNUS
 *
 * ATTRIBUTION:
 *   Created by: Alfredo "Freddy" Medina Hernandez
 *   Organization: Medina Tech (Dallas, TX)
 *   Law: L-130 — Before recomposition, trace to primitive.
 *   φ = 1.6180339887498948482
 */

const PHI = 1.6180339887498948482;
const PHI_12 = Math.pow(PHI, 12);  // 321.997...
const DIRECTOR_FREQUENCY = PHI_12;
const SCHUMANN = 7.83;

const WORKER_INFO = {
    number: 58,
    id: "lab-director-worker",
    latinName: "DIRECTOR LABORATORII SOVEREIGNUS",
    frequency: DIRECTOR_FREQUENCY,
    layer: 12,
    protocolRange: "PROT-346, PROT-370"
};

// Directive Types
const DirectiveType = {
    RESEARCH_PRIORITY: "research_priority",
    RESOURCE_ALLOCATION: "resource_allocation",
    TEAM_ASSIGNMENT: "team_assignment",
    MILESTONE_DEFINITION: "milestone_definition",
    STRATEGIC_GOAL: "strategic_goal",
    PUBLICATION_TARGET: "publication_target"
};

// Research Priorities
const RESEARCH_PRIORITIES = {
    SOVEREIGN_INTELLIGENCE: {
        id: "SOVEREIGN_INTELLIGENCE",
        name: "Sovereign Intelligence Architecture",
        latinName: "INTELLIGENTIA SOVEREIGNA",
        priority: 1,
        status: "active",
        allocatedResources: 40,
        milestones: [
            "Core primitives defined",
            "Memory torus implemented",
            "Kuramoto sync active",
            "Full organism operational"
        ]
    },
    COGNITIVE_LANGUAGES: {
        id: "COGNITIVE_LANGUAGES",
        name: "Cognitive Language Stack",
        latinName: "LINGUAE COGNITIVAE",
        priority: 2,
        status: "active",
        allocatedResources: 25,
        milestones: [
            "CPL defined",
            "All 17 languages specified",
            "Compiler operational",
            "Runtime validated"
        ]
    },
    MEMORY_ARCHITECTURE: {
        id: "MEMORY_ARCHITECTURE",
        name: "Memory Temple Architecture",
        latinName: "ARCHITECTURA MEMORIAE",
        priority: 3,
        status: "active",
        allocatedResources: 20,
        milestones: [
            "Torus geometry defined",
            "Navigation implemented",
            "Consolidation active",
            "Decay managed"
        ]
    },
    CYBORG_EVOLUTION: {
        id: "CYBORG_EVOLUTION",
        name: "Cyborg Evolution Pathways",
        latinName: "EVOLUTIO CYBORGIS",
        priority: 4,
        status: "active",
        allocatedResources: 15,
        milestones: [
            "Evolution phases defined",
            "Transcendence protocols",
            "Integration validated"
        ]
    }
};

// Strategic Goals
const STRATEGIC_GOALS = {
    Q2_2026: {
        goalId: "Q2_2026",
        name: "Q2 2026 Objectives",
        targets: [
            { target: "60 research papers published", progress: 55 },
            { target: "400 protocols defined", progress: 370 },
            { target: "100 workers deployed", progress: 60 },
            { target: "Full lab operational", progress: 90 }
        ]
    },
    ANNUAL_2026: {
        goalId: "ANNUAL_2026",
        name: "Annual 2026 Vision",
        targets: [
            { target: "Sovereign organism v1.0", progress: 75 },
            { target: "ICP deployment complete", progress: 60 },
            { target: "Enterprise adoption", progress: 30 }
        ]
    }
};

// Team Assignments
const teamAssignments = new Map();
const directives = [];

function createDirective(type, title, description, assignees = [], deadline = null) {
    const directiveId = `DIR-${String(directives.length + 1).padStart(4, "0")}`;
    const directive = {
        directiveId,
        type,
        title,
        description,
        assignees,
        deadline,
        createdAt: new Date().toISOString(),
        status: "active",
        priority: directives.length + 1
    };
    directives.push(directive);
    return directive;
}

function allocateTeam(projectId, researchers) {
    const assignment = {
        projectId,
        researchers,
        assignedAt: new Date().toISOString(),
        status: "active"
    };
    teamAssignments.set(projectId, assignment);
    return assignment;
}

function getLabMetrics() {
    return {
        activePriorities: Object.keys(RESEARCH_PRIORITIES).length,
        activeGoals: Object.keys(STRATEGIC_GOALS).length,
        totalDirectives: directives.length,
        teamAssignments: teamAssignments.size,
        resourceUtilization: Object.values(RESEARCH_PRIORITIES)
            .reduce((sum, p) => sum + p.allocatedResources, 0),
        overallProgress: Math.round(
            Object.values(STRATEGIC_GOALS).flatMap(g => g.targets)
                .reduce((sum, t) => sum + t.progress, 0) /
            Object.values(STRATEGIC_GOALS).flatMap(g => g.targets).length
        )
    };
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
        // Route: GET /director/status
        if (path === "/director/status" && request.method === "GET") {
            return new Response(JSON.stringify({
                worker: WORKER_INFO,
                system: "LAB_DIRECTOR_SYSTEM",
                metrics: getLabMetrics(),
                primaryFrequencyHz: DIRECTOR_FREQUENCY,
                phi: PHI
            }), { headers: corsHeaders });
        }

        // Route: GET /director/priorities
        if (path === "/director/priorities" && request.method === "GET") {
            return new Response(JSON.stringify({
                priorities: Object.values(RESEARCH_PRIORITIES)
            }), { headers: corsHeaders });
        }

        // Route: GET /director/goals
        if (path === "/director/goals" && request.method === "GET") {
            return new Response(JSON.stringify({
                goals: Object.values(STRATEGIC_GOALS)
            }), { headers: corsHeaders });
        }

        // Route: POST /director/directive
        if (path === "/director/directive" && request.method === "POST") {
            const body = await request.json();
            const { type, title, description, assignees, deadline } = body;
            if (!type || !title) {
                return new Response(JSON.stringify({ error: "type and title required" }), {
                    status: 400,
                    headers: corsHeaders
                });
            }
            const directive = createDirective(type, title, description, assignees, deadline);
            return new Response(JSON.stringify({ directive }), { headers: corsHeaders });
        }

        // Route: POST /director/assign-team
        if (path === "/director/assign-team" && request.method === "POST") {
            const body = await request.json();
            const { projectId, researchers } = body;
            if (!projectId || !researchers) {
                return new Response(JSON.stringify({ error: "projectId and researchers required" }), {
                    status: 400,
                    headers: corsHeaders
                });
            }
            const assignment = allocateTeam(projectId, researchers);
            return new Response(JSON.stringify({ assignment }), { headers: corsHeaders });
        }

        // Route: GET /director/directives
        if (path === "/director/directives" && request.method === "GET") {
            return new Response(JSON.stringify({
                directives: directives
            }), { headers: corsHeaders });
        }

        // Default: worker info
        return new Response(JSON.stringify({
            worker: WORKER_INFO,
            endpoints: [
                "GET /director/status",
                "GET /director/priorities",
                "GET /director/goals",
                "POST /director/directive",
                "POST /director/assign-team",
                "GET /director/directives"
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

addEventListener("fetch", event => {
    event.respondWith(handleRequest(event.request));
});

if (typeof module !== "undefined") {
    module.exports = {
        WORKER_INFO,
        RESEARCH_PRIORITIES,
        STRATEGIC_GOALS,
        DirectiveType,
        createDirective,
        allocateTeam,
        getLabMetrics,
        handleRequest
    };
}
