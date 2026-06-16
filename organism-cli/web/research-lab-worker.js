/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                    RESEARCH LAB WORKER #56                                    ║
 * ║           Full Research Laboratory Platform Infrastructure                    ║
 * ║                                                                                ║
 * ║  "Laboratorium Investigationis — Where intelligence researches itself"       ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 *
 * Protocol: PROT-346 to PROT-370
 * Frequency: φ¹¹ = 199.005 Hz (Transcendent)
 * Worker Number: 56
 * Latin Name: LABORATORIUM INVESTIGATIONIS
 *
 * ATTRIBUTION:
 *   Created by: Alfredo "Freddy" Medina Hernandez
 *   Organization: Medina Tech (Dallas, TX)
 *   Law: L-130 — Before recomposition, trace to primitive.
 *   φ = 1.6180339887498948482
 */

const PHI = 1.6180339887498948482;
const PHI_11 = Math.pow(PHI, 11);  // 199.005...
const LAB_FREQUENCY = PHI_11;
const SCHUMANN = 7.83;
const HEARTBEAT_WEBSITE_ORGANISM_HZ = PHI;

const WORKER_INFO = {
    number: 56,
    id: "research-lab-worker",
    latinName: "LABORATORIUM INVESTIGATIONIS",
    frequency: LAB_FREQUENCY,
    layer: 12,
    protocolRange: "PROT-346 to PROT-370"
};

// Researcher Roles
const ResearcherRole = {
    LAB_DIRECTOR: "lab_director",
    PRINCIPAL_INVESTIGATOR: "principal_investigator",
    RESEARCH_LEAD: "research_lead",
    SENIOR_RESEARCHER: "senior_researcher",
    RESEARCHER: "researcher",
    RESEARCH_ASSOCIATE: "research_associate",
    PAPER_WRITER: "paper_writer",
    TECHNICAL_WRITER: "technical_writer",
    EDITOR: "editor",
    REVIEWER: "reviewer",
    PEER_REVIEWER: "peer_reviewer",
    DATA_ANALYST: "data_analyst",
    THEORIST: "theorist",
    EXPERIMENTALIST: "experimentalist",
    ARCHIVIST: "archivist"
};

// Paper States
const PaperState = {
    DRAFT: "draft",
    WRITING: "writing",
    REVIEW: "review",
    REVISION: "revision",
    APPROVED: "approved",
    SUBMITTED: "submitted",
    PUBLISHED: "published",
    ARCHIVED: "archived"
};

const TARGET_IDENTIFIERS = {
    SSN: {
        canonicalId: "SSN",
        aliases: ["ssn", "sovereign social network", "social substrate network"],
        researchDomain: "ssn",
        laneId: "lane://ssn",
        domainPack: "governance"
    },
    RESEARCH_WEBSITES: {
        canonicalId: "RESEARCH_WEBSITES",
        aliases: ["research websites", "research sites", "research web", "novato", "cars"],
        researchDomain: "research-websites",
        laneId: "lane://research-websites",
        domainPack: "infrastructure"
    },
    EDUCATION: {
        canonicalId: "EDUCATION",
        aliases: ["education", "learning", "edtech"],
        researchDomain: "education",
        laneId: "lane://education",
        domainPack: "education"
    },
    HEALTH: {
        canonicalId: "HEALTH",
        aliases: ["health", "healthcare", "medical"],
        researchDomain: "health",
        laneId: "lane://health",
        domainPack: "health"
    },
    LEGAL: {
        canonicalId: "LEGAL",
        aliases: ["legal", "law", "compliance"],
        researchDomain: "legal",
        laneId: "lane://legal",
        domainPack: "legal"
    },
    ECONOMICS: {
        canonicalId: "ECONOMICS",
        aliases: ["economics", "finance", "market"],
        researchDomain: "economics",
        laneId: "lane://economics",
        domainPack: "economics"
    },
    GOVERNANCE: {
        canonicalId: "GOVERNANCE",
        aliases: ["governance", "public policy", "government"],
        researchDomain: "governance",
        laneId: "lane://governance",
        domainPack: "governance"
    },
    INFRASTRUCTURE: {
        canonicalId: "INFRASTRUCTURE",
        aliases: ["infrastructure", "infra", "platform"],
        researchDomain: "infrastructure",
        laneId: "lane://infrastructure",
        domainPack: "infrastructure"
    }
};

// Lab Researchers Registry
const LAB_RESEARCHERS = {
    DIRECTOR_LABORATORII: {
        id: "DIRECTOR_LABORATORII",
        name: "Lab Director",
        latinName: "DIRECTOR LABORATORII PRIMARIUS",
        role: ResearcherRole.LAB_DIRECTOR,
        protocol: "PROT-346",
        frequency: PHI_11,
        layer: 12,
        specializations: ["lab_management", "research_direction", "strategic_planning"]
    },
    INVESTIGATOR_PRINCIPALIS: {
        id: "INVESTIGATOR_PRINCIPALIS",
        name: "Principal Investigator",
        latinName: "INVESTIGATOR PRINCIPALIS",
        role: ResearcherRole.PRINCIPAL_INVESTIGATOR,
        protocol: "PROT-347",
        frequency: Math.pow(PHI, 10),
        layer: 11,
        specializations: ["sovereign_intelligence", "cognitive_architecture", "primitive_computation"]
    },
    SCRIPTOR_SENIOR: {
        id: "SCRIPTOR_SENIOR",
        name: "Senior Paper Writer",
        latinName: "SCRIPTOR PAPYRORUM SENIOR",
        role: ResearcherRole.PAPER_WRITER,
        protocol: "PROT-348",
        frequency: Math.pow(PHI, 9),
        layer: 10,
        specializations: ["academic_writing", "technical_documentation", "latin_terminology"]
    },
    SCRIPTOR_TECHNICUS: {
        id: "SCRIPTOR_TECHNICUS",
        name: "Technical Writer",
        latinName: "SCRIPTOR TECHNICUS",
        role: ResearcherRole.TECHNICAL_WRITER,
        protocol: "PROT-349",
        frequency: Math.pow(PHI, 8),
        layer: 9,
        specializations: ["protocol_documentation", "api_specification", "implementation_guides"]
    },
    CENSOR_PRINCIPALIS: {
        id: "CENSOR_PRINCIPALIS",
        name: "Chief Reviewer",
        latinName: "CENSOR PRINCIPALIS",
        role: ResearcherRole.REVIEWER,
        protocol: "PROT-350",
        frequency: SCHUMANN * Math.pow(PHI, 4),
        layer: 10,
        specializations: ["quality_assurance", "peer_review", "coherence_validation"]
    },
    ANALYST_DATORUM: {
        id: "ANALYST_DATORUM",
        name: "Data Analyst",
        latinName: "ANALYST DATORUM",
        role: ResearcherRole.DATA_ANALYST,
        protocol: "PROT-351",
        frequency: Math.pow(PHI, 7),
        layer: 9,
        specializations: ["data_analysis", "pattern_recognition", "visualization"]
    },
    THEORETICUS_PRIMUS: {
        id: "THEORETICUS_PRIMUS",
        name: "Chief Theorist",
        latinName: "THEORETICUS PRIMUS",
        role: ResearcherRole.THEORIST,
        protocol: "PROT-352",
        frequency: PHI_11 / PHI,
        layer: 11,
        specializations: ["theoretical_foundations", "mathematical_proofs", "primitive_theory"]
    },
    SOCIUS_ALPHA: {
        id: "SOCIUS_ALPHA",
        name: "Research Associate Alpha",
        latinName: "SOCIUS INVESTIGATIONIS ALPHA",
        role: ResearcherRole.RESEARCH_ASSOCIATE,
        protocol: "PROT-353",
        frequency: Math.pow(PHI, 6),
        layer: 9,
        specializations: ["literature_review", "experiment_design", "data_collection"]
    },
    SOCIUS_BETA: {
        id: "SOCIUS_BETA",
        name: "Research Associate Beta",
        latinName: "SOCIUS INVESTIGATIONIS BETA",
        role: ResearcherRole.RESEARCH_ASSOCIATE,
        protocol: "PROT-354",
        frequency: Math.pow(PHI, 5),
        layer: 9,
        specializations: ["implementation", "testing", "validation"]
    },
    EDITOR_PAPYRORUM: {
        id: "EDITOR_PAPYRORUM",
        name: "Paper Editor",
        latinName: "EDITOR PAPYRORUM",
        role: ResearcherRole.EDITOR,
        protocol: "PROT-355",
        frequency: SCHUMANN * Math.pow(PHI, 3),
        layer: 9,
        specializations: ["copy_editing", "formatting", "style_consistency"]
    },
    ARCHIVARIUS: {
        id: "ARCHIVARIUS",
        name: "Research Archivist",
        latinName: "ARCHIVARIUS INVESTIGATIONIS",
        role: ResearcherRole.ARCHIVIST,
        protocol: "PROT-356",
        frequency: Math.pow(PHI, 4),
        layer: 8,
        specializations: ["archival_management", "metadata_curation", "knowledge_preservation"]
    },
    EXPERIMENTATOR: {
        id: "EXPERIMENTATOR",
        name: "Chief Experimentalist",
        latinName: "EXPERIMENTATOR PRIMUS",
        role: ResearcherRole.EXPERIMENTALIST,
        protocol: "PROT-357",
        frequency: Math.pow(PHI, 8) * PHI,
        layer: 10,
        specializations: ["experiment_execution", "benchmark_design", "performance_analysis"]
    },
    CENSOR_PARIUM: {
        id: "CENSOR_PARIUM",
        name: "Peer Reviewer",
        latinName: "CENSOR PARIUM",
        role: ResearcherRole.PEER_REVIEWER,
        protocol: "PROT-358",
        frequency: SCHUMANN * Math.pow(PHI, 5),
        layer: 10,
        specializations: ["blind_review", "constructive_feedback", "novelty_assessment"]
    }
};

// Lab Areas
const LAB_AREAS = {
    LABORATORIUM_PRINCIPALE: {
        id: "LABORATORIUM_PRINCIPALE",
        name: "Main Laboratory",
        latinName: "LABORATORIUM PRINCIPALE",
        protocol: "PROT-359",
        capacity: 50,
        equipment: ["compute_cluster", "visualization_wall", "collaboration_terminals"]
    },
    OFFICIUM_DIRECTORIS: {
        id: "OFFICIUM_DIRECTORIS",
        name: "Director's Office",
        latinName: "OFFICIUM DIRECTORIS",
        protocol: "PROT-360",
        capacity: 5,
        equipment: ["executive_terminal", "secure_communications", "strategic_display"]
    },
    CENTRUM_SCRIPTIONIS: {
        id: "CENTRUM_SCRIPTIONIS",
        name: "Writing Center",
        latinName: "CENTRUM SCRIPTIONIS",
        protocol: "PROT-361",
        capacity: 20,
        equipment: ["writing_stations", "latex_processors", "citation_managers"]
    },
    CAMERA_RECENSIONIS: {
        id: "CAMERA_RECENSIONIS",
        name: "Review Chamber",
        latinName: "CAMERA RECENSIONIS",
        protocol: "PROT-362",
        capacity: 15,
        equipment: ["review_terminals", "comparison_engines", "annotation_systems"]
    },
    AULA_THEORIAE: {
        id: "AULA_THEORIAE",
        name: "Theory Room",
        latinName: "AULA THEORIAE",
        protocol: "PROT-363",
        capacity: 10,
        equipment: ["whiteboard_infinity", "proof_assistants", "symbolic_engines"]
    },
    CENTRUM_DATORUM: {
        id: "CENTRUM_DATORUM",
        name: "Data Center",
        latinName: "CENTRUM DATORUM",
        protocol: "PROT-364",
        capacity: 8,
        equipment: ["analysis_clusters", "visualization_suite", "storage_arrays"]
    },
    BIBLIOTHECA_INVESTIGATIONIS: {
        id: "BIBLIOTHECA_INVESTIGATIONIS",
        name: "Research Library",
        latinName: "BIBLIOTHECA INVESTIGATIONIS",
        protocol: "PROT-365",
        capacity: 30,
        equipment: ["knowledge_retrieval", "citation_graph", "paper_repository"]
    }
};

// Paper management
const papers = new Map();
const publishedPapers = [];
let paperCounter = 0;
const researchPrograms = new Map();
const liveWebsiteOrganisms = new Map();
const intelligenceContracts = new Map();
const runtimeArtifacts = new Map();
const governanceAuditTrail = [];
let programCounter = 0;
let websiteOrganismCounter = 0;
let artifactCounter = 0;

function appendAuditEvent(action, gate, status, metadata = {}) {
    governanceAuditTrail.push({
        eventId: `AUDIT-${String(governanceAuditTrail.length + 1).padStart(6, "0")}`,
        action,
        gate,
        status,
        metadata,
        timestamp: new Date().toISOString()
    });
}

function enforcePolicy({ gate, canonicalTarget, program = null, paper = null }) {
    if (!TARGET_IDENTIFIERS[canonicalTarget]) {
        return { allowed: false, reason: `Unknown canonical target: ${canonicalTarget}` };
    }
    if (gate === "publish" && paper && paper.state !== PaperState.APPROVED) {
        return { allowed: false, reason: "Paper must be approved before publish." };
    }
    if ((gate === "execute" || gate === "publish") && !program) {
        return { allowed: false, reason: "Program context required." };
    }
    return { allowed: true, reason: "policy_passed" };
}

function buildContract(program, paper, runtimeStatus) {
    const contractId = `CONTRACT-${program.programId}`;
    const existing = intelligenceContracts.get(contractId);
    const contract = existing || {
        contractId,
        canonicalTarget: program.canonicalTarget,
        laneId: program.laneId,
        domainPack: program.domainPack,
        programId: program.programId,
        paperId: paper.paperId,
        protocol: program.protocol,
        frequencyHz: HEARTBEAT_WEBSITE_ORGANISM_HZ,
        heartbeatBeats: 0,
        lineage: {},
        attestation: {},
        createdAt: new Date().toISOString()
    };
    contract.workflowState = program.workflowState;
    contract.runtimeStatus = runtimeStatus;
    contract.lineage = {
        programId: program.programId,
        paperId: paper.paperId,
        protocol: program.protocol,
        laneId: program.laneId
    };
    contract.attestation = {
        policyGate: "passed",
        validatedBy: WORKER_INFO.id,
        validatedAt: new Date().toISOString()
    };
    contract.updatedAt = new Date().toISOString();
    intelligenceContracts.set(contractId, contract);
    return contract;
}

function createRuntimeArtifact(program, paper) {
    artifactCounter++;
    const artifact = {
        artifactId: `ARTIFACT-${String(artifactCounter).padStart(5, "0")}`,
        programId: program.programId,
        paperId: paper.paperId,
        canonicalTarget: program.canonicalTarget,
        laneId: program.laneId,
        domainPack: program.domainPack,
        workerEndpoint: "/lab/program/:id/advance",
        inventoryRegistryEntry: "atlas/registry/runtime/research-runtime-artifacts.json",
        status: "deployable",
        publishedAt: new Date().toISOString()
    };
    runtimeArtifacts.set(artifact.artifactId, artifact);
    return artifact;
}

function createPaper(title, latinTitle, primaryAuthor, abstract = "", protocol = "") {
    paperCounter++;
    const paperId = `PAPER-${String(paperCounter).padStart(4, "0")}`;
    const paper = {
        paperId,
        title,
        latinTitle,
        abstract,
        primaryAuthor,
        coAuthors: [],
        sections: {},
        references: [],
        keywords: [],
        protocol,
        sccScore: 0,
        state: PaperState.DRAFT,
        createdAt: new Date().toISOString(),
        lastModified: new Date().toISOString(),
        reviewers: [],
        reviewComments: [],
        revisionCount: 0
    };
    papers.set(paperId, paper);
    return paper;
}

function writeSection(paperId, sectionName, content) {
    const paper = papers.get(paperId);
    if (!paper) return { error: "Paper not found" };
    
    paper.sections[sectionName] = content;
    paper.state = PaperState.WRITING;
    paper.lastModified = new Date().toISOString();
    return paper;
}

function submitForReview(paperId) {
    const paper = papers.get(paperId);
    if (!paper) return { error: "Paper not found" };
    
    paper.state = PaperState.REVIEW;
    paper.lastModified = new Date().toISOString();
    
    // Auto-assign reviewers
    const reviewers = ["CENSOR_PRINCIPALIS", "CENSOR_PARIUM"];
    paper.reviewers = reviewers;
    
    return paper;
}

function calculateSCC(paper) {
    const sectionCount = Object.keys(paper.sections).length;
    const refCount = paper.references.length;
    const authorCount = 1 + paper.coAuthors.length;
    
    paper.sccScore = (
        (sectionCount * 0.3) +
        (refCount * 0.1) +
        (authorCount * PHI * 0.2) +
        (paper.revisionCount * 0.1)
    ) / PHI;
    
    return paper.sccScore;
}

function publishPaper(paperId) {
    const paper = papers.get(paperId);
    if (!paper) return { error: "Paper not found" };
    if (paper.state !== PaperState.APPROVED) return { error: "Paper not approved" };
    
    paper.state = PaperState.PUBLISHED;
    calculateSCC(paper);
    publishedPapers.push(paperId);
    
    return paper;
}

function normalizeTargetIdentifier(input) {
    const normalized = (input || "").trim().toLowerCase();
    const all = Object.values(TARGET_IDENTIFIERS);
    for (const target of all) {
        if (normalized === target.canonicalId.toLowerCase() || target.aliases.includes(normalized)) {
            return target;
        }
    }
    return {
        canonicalId: (input || "CUSTOM").trim().toUpperCase() || "CUSTOM",
        aliases: input ? [input] : [],
        researchDomain: "custom",
        laneId: "lane://custom",
        domainPack: "custom"
    };
}

function assignPrimaryAuthor(topic, canonicalTarget) {
    const lowered = (topic || "").toLowerCase();
    if (canonicalTarget === "RESEARCH_WEBSITES" || lowered.includes("website") || lowered.includes("web")) {
        return "SCRIPTOR_TECHNICUS";
    }
    if (canonicalTarget === "SSN" || lowered.includes("network")) {
        return "INVESTIGATOR_PRINCIPALIS";
    }
    return "SCRIPTOR_SENIOR";
}

function intakeProgram(topic, targetIdentifier = "RESEARCH_WEBSITES", requestedBy = "DIRECTOR_MEDINA", abstract = "") {
    const target = normalizeTargetIdentifier(targetIdentifier);
    const policy = enforcePolicy({ gate: "intake", canonicalTarget: target.canonicalId });
    if (!policy.allowed) {
        appendAuditEvent("intake", "intake", "denied", { topic, reason: policy.reason });
        return { success: false, error: policy.reason };
    }
    const primaryAuthor = assignPrimaryAuthor(topic, target.canonicalId);
    const latinTitle = (topic || "PROGRAMMA_INVESTIGATIONIS").toUpperCase().replace(/\s+/g, "_").slice(0, 64);
    const paper = createPaper(
        `${topic} (${target.canonicalId})`,
        latinTitle,
        primaryAuthor,
        abstract,
        "PROT-366"
    );
    writeSection(
        paper.paperId,
        "Topic Intake",
        `Requester=${requestedBy}; Target=${target.canonicalId}; Topic=${topic}`
    );

    programCounter++;
    const programId = `PROGRAM-${String(programCounter).padStart(4, "0")}`;
    const program = {
        programId,
        topic,
        canonicalTarget: target.canonicalId,
        laneId: target.laneId || "lane://custom",
        domainPack: target.domainPack || "custom",
        targetAlias: targetIdentifier,
        paperId: paper.paperId,
        assignedResearcher: primaryAuthor,
        protocol: "PROT-366",
        workflowState: "draft",
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
        notes: ["Topic intake completed and draft bootstrapped."]
    };
    researchPrograms.set(programId, program);
    const contract = buildContract(program, paper, "draft");
    appendAuditEvent("intake", "intake", "allowed", {
        programId: program.programId,
        paperId: program.paperId,
        laneId: program.laneId
    });
    return { ...program, success: true, contractId: contract.contractId };
}

function advanceProgram(programId, action, sectionName, content) {
    const program = researchPrograms.get(programId);
    if (!program) return { success: false, error: `Program not found: ${programId}` };
    const paper = papers.get(program.paperId);
    if (!paper) return { success: false, error: `Program paper missing: ${program.paperId}` };

    const actionNorm = (action || "").trim().toLowerCase();
    const gate = actionNorm === "publish" ? "publish" : "execute";
    const policy = enforcePolicy({ gate, canonicalTarget: program.canonicalTarget, program, paper });
    if (!policy.allowed) {
        appendAuditEvent(actionNorm, gate, "denied", { programId: program.programId, reason: policy.reason });
        return { success: false, error: policy.reason };
    }
    let artifact = null;
    if (actionNorm === "draft") {
        if (sectionName && content) {
            writeSection(program.paperId, sectionName, content);
        }
        program.workflowState = "draft";
    } else if (actionNorm === "review") {
        submitForReview(program.paperId);
        program.workflowState = "review";
    } else if (actionNorm === "approve") {
        paper.state = PaperState.APPROVED;
        program.workflowState = "approved";
    } else if (actionNorm === "publish") {
        if (paper.state !== PaperState.APPROVED) {
            return { success: false, error: "Paper must be approved before publish." };
        }
        publishPaper(program.paperId);
        program.workflowState = "published";
        artifact = createRuntimeArtifact(program, paper);
    } else {
        return { success: false, error: `Unknown action: ${action}` };
    }

    const runtimeStatus = actionNorm === "publish" ? "deployable" : actionNorm === "approve" ? "running" : "draft";
    const contract = buildContract(program, paper, runtimeStatus);
    appendAuditEvent(actionNorm, gate, "allowed", { programId: program.programId, contractId: contract.contractId });
    program.updatedAt = new Date().toISOString();
    return {
        success: true,
        programId: program.programId,
        paperId: program.paperId,
        workflowState: program.workflowState,
        paperState: paper.state,
        contractId: contract.contractId,
        artifact
    };
}

function provisionWebsiteOrganism(websiteName, websiteUrl, topic, requestedBy = "DIRECTOR_MEDINA") {
    const program = intakeProgram(
        topic,
        "RESEARCH_WEBSITES",
        requestedBy,
        `Live website organism for ${websiteName} (${websiteUrl})`
    );
    if (program.error) return program;

    websiteOrganismCounter++;
    const organismId = `ORG-WEB-${String(websiteOrganismCounter).padStart(4, "0")}`;
    const organism = {
        organismId,
        websiteName,
        websiteUrl,
        canonicalTarget: "RESEARCH_WEBSITES",
        laneId: "lane://research-websites",
        domainPack: "infrastructure",
        programId: program.programId,
        paperId: program.paperId,
        status: "active",
        runtimeStatus: "running",
        frequencyHz: HEARTBEAT_WEBSITE_ORGANISM_HZ,
        heartbeatBeats: 0,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
    };
    liveWebsiteOrganisms.set(organismId, organism);
    const trackedProgram = researchPrograms.get(program.programId);
    const paper = papers.get(program.paperId);
    const contract = buildContract(trackedProgram, paper, "running");
    appendAuditEvent("provision-organism", "execute", "allowed", { organismId, contractId: contract.contractId });
    return { ...organism, contractId: contract.contractId };
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
        // Route: GET /lab/status
        if (path === "/lab/status" && request.method === "GET") {
            return new Response(JSON.stringify({
                worker: WORKER_INFO,
                labName: "LABORATORIUM INTELLIGENTIAE SOVEREIGNAE",
                protocolRange: "PROT-346 to PROT-370",
                totalResearchers: Object.keys(LAB_RESEARCHERS).length,
                totalAreas: Object.keys(LAB_AREAS).length,
                totalPapers: papers.size,
                publishedPapers: publishedPapers.length,
                totalPrograms: researchPrograms.size,
                liveWebsiteOrganisms: liveWebsiteOrganisms.size,
                intelligenceContracts: intelligenceContracts.size,
                runtimeArtifacts: runtimeArtifacts.size,
                governanceAuditEvents: governanceAuditTrail.length,
                primaryFrequencyHz: LAB_FREQUENCY,
                phi: PHI
            }), { headers: corsHeaders });
        }

        // Route: GET /lab/targets
        if (path === "/lab/targets" && request.method === "GET") {
            return new Response(JSON.stringify({
                targets: Object.values(TARGET_IDENTIFIERS)
            }), { headers: corsHeaders });
        }

        // Route: GET /lab/researchers
        if (path === "/lab/researchers" && request.method === "GET") {
            return new Response(JSON.stringify({
                researchers: Object.values(LAB_RESEARCHERS).map(r => ({
                    id: r.id,
                    name: r.name,
                    latinName: r.latinName,
                    role: r.role,
                    protocol: r.protocol,
                    frequency: r.frequency,
                    layer: r.layer,
                    specializations: r.specializations
                }))
            }), { headers: corsHeaders });
        }

        // Route: GET /lab/areas
        if (path === "/lab/areas" && request.method === "GET") {
            return new Response(JSON.stringify({
                areas: Object.values(LAB_AREAS).map(a => ({
                    id: a.id,
                    name: a.name,
                    latinName: a.latinName,
                    protocol: a.protocol,
                    capacity: a.capacity,
                    equipment: a.equipment
                }))
            }), { headers: corsHeaders });
        }

        // Route: POST /lab/paper
        if (path === "/lab/paper" && request.method === "POST") {
            const body = await request.json();
            const { title, latinTitle, primaryAuthor, abstract, protocol } = body;
            if (!title || !latinTitle || !primaryAuthor) {
                return new Response(JSON.stringify({ error: "title, latinTitle, and primaryAuthor required" }), {
                    status: 400,
                    headers: corsHeaders
                });
            }
            const paper = createPaper(title, latinTitle, primaryAuthor, abstract, protocol);
            return new Response(JSON.stringify({ paper }), { headers: corsHeaders });
        }

        // Route: POST /lab/paper/:id/section
        if (path.match(/\/lab\/paper\/.*\/section/) && request.method === "POST") {
            const paperId = path.split("/")[3];
            const body = await request.json();
            const { sectionName, content } = body;
            const result = writeSection(paperId, sectionName, content);
            return new Response(JSON.stringify({ result }), { headers: corsHeaders });
        }

        // Route: POST /lab/paper/:id/submit
        if (path.match(/\/lab\/paper\/.*\/submit/) && request.method === "POST") {
            const paperId = path.split("/")[3];
            const result = submitForReview(paperId);
            return new Response(JSON.stringify({ result }), { headers: corsHeaders });
        }

        // Route: GET /lab/papers
        if (path === "/lab/papers" && request.method === "GET") {
            return new Response(JSON.stringify({
                papers: Array.from(papers.values()).map(p => ({
                    paperId: p.paperId,
                    title: p.title,
                    latinTitle: p.latinTitle,
                    primaryAuthor: p.primaryAuthor,
                    state: p.state,
                    sccScore: p.sccScore,
                    sections: Object.keys(p.sections).length,
                    createdAt: p.createdAt
                }))
            }), { headers: corsHeaders });
        }

        // Route: POST /lab/program
        if (path === "/lab/program" && request.method === "POST") {
            const body = await request.json();
            const { topic, targetIdentifier = "RESEARCH_WEBSITES", requestedBy = "DIRECTOR_MEDINA", abstract = "" } = body;
            if (!topic) {
                return new Response(JSON.stringify({ error: "topic required" }), { status: 400, headers: corsHeaders });
            }
            const program = intakeProgram(topic, targetIdentifier, requestedBy, abstract);
            return new Response(JSON.stringify({ program }), { headers: corsHeaders });
        }

        // Route: POST /lab/program/:id/advance
        if (path.match(/\/lab\/program\/.*\/advance/) && request.method === "POST") {
            const programId = path.split("/")[3];
            const body = await request.json();
            const { action, sectionName, content } = body;
            const result = advanceProgram(programId, action, sectionName, content);
            return new Response(JSON.stringify({ result }), { headers: corsHeaders });
        }

        // Route: GET /lab/programs
        if (path === "/lab/programs" && request.method === "GET") {
            return new Response(JSON.stringify({
                programs: Array.from(researchPrograms.values())
            }), { headers: corsHeaders });
        }

        // Route: GET /lab/contracts
        if (path === "/lab/contracts" && request.method === "GET") {
            return new Response(JSON.stringify({
                contracts: Array.from(intelligenceContracts.values())
            }), { headers: corsHeaders });
        }

        // Route: GET /lab/artifacts
        if (path === "/lab/artifacts" && request.method === "GET") {
            return new Response(JSON.stringify({
                artifacts: Array.from(runtimeArtifacts.values())
            }), { headers: corsHeaders });
        }

        // Route: GET /lab/governance/audit
        if (path === "/lab/governance/audit" && request.method === "GET") {
            return new Response(JSON.stringify({
                events: governanceAuditTrail
            }), { headers: corsHeaders });
        }

        // Route: GET /lab/coordination
        if (path === "/lab/coordination" && request.method === "GET") {
            const totalHeartbeatBeats = Array.from(liveWebsiteOrganisms.values())
                .reduce((sum, o) => sum + (o.heartbeatBeats || 0), 0);
            return new Response(JSON.stringify({
                coordinationLayer: "SOVEREIGN_ORGANISM_COORDINATION",
                liveOrganisms: liveWebsiteOrganisms.size,
                contracts: intelligenceContracts.size,
                runtimeArtifacts: runtimeArtifacts.size,
                auditEvents: governanceAuditTrail.length,
                heartbeatSync: {
                    frequencyHz: HEARTBEAT_WEBSITE_ORGANISM_HZ,
                    totalHeartbeatBeats
                }
            }), { headers: corsHeaders });
        }

        // Route: POST /lab/website-organism
        if (path === "/lab/website-organism" && request.method === "POST") {
            const body = await request.json();
            const { websiteName, websiteUrl, topic, requestedBy = "DIRECTOR_MEDINA" } = body;
            if (!websiteName || !websiteUrl || !topic) {
                return new Response(JSON.stringify({ error: "websiteName, websiteUrl, topic required" }), { status: 400, headers: corsHeaders });
            }
            const organism = provisionWebsiteOrganism(websiteName, websiteUrl, topic, requestedBy);
            return new Response(JSON.stringify({ organism }), { headers: corsHeaders });
        }

        // Route: GET /lab/organisms
        if (path === "/lab/organisms" && request.method === "GET") {
            return new Response(JSON.stringify({
                organisms: Array.from(liveWebsiteOrganisms.values())
            }), { headers: corsHeaders });
        }

        // Default: worker info
        return new Response(JSON.stringify({
            worker: WORKER_INFO,
            endpoints: [
                "GET /lab/status",
                "GET /lab/targets",
                "GET /lab/researchers",
                "GET /lab/areas",
                "POST /lab/paper",
                "POST /lab/paper/:id/section",
                "POST /lab/paper/:id/submit",
                "GET /lab/papers",
                "POST /lab/program",
                "POST /lab/program/:id/advance",
                "GET /lab/programs",
                "GET /lab/contracts",
                "GET /lab/artifacts",
                "GET /lab/governance/audit",
                "GET /lab/coordination",
                "POST /lab/website-organism",
                "GET /lab/organisms"
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
        LAB_RESEARCHERS,
        LAB_AREAS,
        ResearcherRole,
        PaperState,
        createPaper,
        writeSection,
        submitForReview,
        publishPaper,
        intakeProgram,
        advanceProgram,
        provisionWebsiteOrganism,
        buildContract,
        createRuntimeArtifact,
        appendAuditEvent,
        handleRequest
    };
}
