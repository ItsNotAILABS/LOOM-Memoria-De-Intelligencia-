/**
 * ╔═══════════════════════════════════════════════════════════════════════════════════╗
 * ║                                                                                   ║
 * ║                       IWW - INTELLIGENCE WIDE WEB                                 ║
 * ║                      Our Own Version of www                                       ║
 * ║                                                                                   ║
 * ║  "Non pagina sed intelligentia. Non situs sed organismus."                        ║
 * ║  (Not a page but intelligence. Not a site but an organism.)                       ║
 * ║                                                                                   ║
 * ║  PROTOCOL: iww://                                                                 ║
 * ║  DOMAINS: .anima | .memoria | .vivens                                             ║
 * ║                                                                                   ║
 * ║  EXAMPLES:                                                                        ║
 * ║  • iww://medina.anima                (Living intelligence)                        ║
 * ║  • iww://app.medina.memoria          (Memory/storage)                             ║
 * ║  • iww://api.medina.vivens           (Always running)                             ║
 * ║                                                                                   ║
 * ║  This is NOT www. This is our own protocol.                                       ║
 * ║  Every page is a model. Every site is an organism.                                ║
 * ║                                                                                   ║
 * ║  Attribution: Alfredo "Freddy" Medina Hernandez                                   ║
 * ║  PROPRIETARY AND CONFIDENTIAL                                                     ║
 * ╚═══════════════════════════════════════════════════════════════════════════════════╝
 */

import Time "mo:base/Time";
import Buffer "mo:base/Buffer";
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Float "mo:base/Float";
import Array "mo:base/Array";
import Option "mo:base/Option";
import Blob "mo:base/Blob";
import Principal "mo:base/Principal";

module IWW {
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // IWW PROTOCOL DOCTRINE
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public let PROTOCOL = {
        name = "IWW";
        fullName = "Intelligence Wide Web";
        
        // Protocol specification
        scheme = "iww";
        version = "1.0";
        defaultPort = 443;
        
        // What it replaces
        replaces = "WWW (World Wide Web)";
        
        // Core difference
        distinction = {
            www = "Serves HTML documents and web applications";
            iww = "Serves living intelligence and model organisms";
        };
        
        // Motto
        motto = "Non pagina sed intelligentia. Non situs sed organismus.";
        translation = "Not a page but intelligence. Not a site but an organism.";
        
        // Sovereignty
        sovereignty = "100% MEDINA-OWNED";
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // DOMAIN EXTENSIONS
    // "Our own TLDs - not .com, .org - but .anima, .memoria, .vivens"
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public type DomainExtension = {
        #anima;      // Living intelligence domains
        #memoria;    // Memory/storage domains
        #vivens;     // Always-running domains
        #cogito;     // Thinking/processing domains
        #nexus;      // Connection/bridge domains
        #templum;    // Sacred/secure domains
        #lex;        // Law/contract domains
        #cor;        // Core/heart domains
    };
    
    public let DOMAIN_EXTENSIONS = [
        {
            extension = ".anima";
            name = "Anima";
            latin = "Soul/Life";
            purpose = "Living intelligence domains";
            description = "For domains that serve living, evolving intelligence";
            usage = "Primary domain extension for main services";
            example = "iww://medina.anima";
            tier = #Primary;
        },
        {
            extension = ".memoria";
            name = "Memoria";
            latin = "Memory";
            purpose = "Memory and storage domains";
            description = "For domains that store and retrieve memories";
            usage = "Storage, databases, archives";
            example = "iww://data.medina.memoria";
            tier = #Primary;
        },
        {
            extension = ".vivens";
            name = "Vivens";
            latin = "Living/Active";
            purpose = "Always-running services";
            description = "For domains that are always alive and processing";
            usage = "APIs, live services, streaming";
            example = "iww://api.medina.vivens";
            tier = #Primary;
        },
        {
            extension = ".cogito";
            name = "Cogito";
            latin = "I Think";
            purpose = "Processing and computation";
            description = "For domains that handle heavy computation";
            usage = "ML inference, data processing, analytics";
            example = "iww://compute.medina.cogito";
            tier = #Secondary;
        },
        {
            extension = ".nexus";
            name = "Nexus";
            latin = "Connection";
            purpose = "Connection and bridging";
            description = "For domains that connect different systems";
            usage = "Integration, federation, bridges";
            example = "iww://connect.medina.nexus";
            tier = #Secondary;
        },
        {
            extension = ".templum";
            name = "Templum";
            latin = "Temple";
            purpose = "Sacred and secure";
            description = "For highest security domains";
            usage = "Secrets, keys, sacred data";
            example = "iww://vault.medina.templum";
            tier = #Special;
        },
        {
            extension = ".lex";
            name = "Lex";
            latin = "Law";
            purpose = "Laws and contracts";
            description = "For legal and contractual domains";
            usage = "Smart contracts, legal documents, governance";
            example = "iww://contracts.medina.lex";
            tier = #Special;
        },
        {
            extension = ".cor";
            name = "Cor";
            latin = "Heart";
            purpose = "Core system domains";
            description = "For core infrastructure";
            usage = "Core services, heartbeat, orchestration";
            example = "iww://core.medina.cor";
            tier = #Internal;
        }
    ];
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // IWW ADDRESS STRUCTURE
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public type IWWAddress = {
        scheme: Text;         // "iww://"
        subdomain: ?Text;     // Optional: "app", "api", "portal"
        domain: Text;         // "medina"
        extension: Text;      // ".anima", ".memoria", ".vivens"
        port: ?Nat;           // Optional port
        path: Text;           // "/path/to/resource"
        query: ?Text;         // Optional query string
        fragment: ?Text;      // Optional fragment
    };
    
    public func parseAddress(url: Text) : ?IWWAddress {
        // Simple parser - production would be more robust
        if (Text.startsWith(url, #text("iww://"))) {
            ?{
                scheme = "iww://";
                subdomain = null;
                domain = "medina";
                extension = ".anima";
                port = null;
                path = "/";
                query = null;
                fragment = null;
            }
        } else {
            null
        }
    };
    
    public func formatAddress(addr: IWWAddress) : Text {
        var result = addr.scheme;
        
        switch (addr.subdomain) {
            case (?sub) { result := result # sub # "."; };
            case null {};
        };
        
        result := result # addr.domain # addr.extension;
        
        switch (addr.port) {
            case (?p) { result := result # ":" # Nat.toText(p); };
            case null {};
        };
        
        result := result # addr.path;
        
        switch (addr.query) {
            case (?q) { result := result # "?" # q; };
            case null {};
        };
        
        switch (addr.fragment) {
            case (?f) { result := result # "#" # f; };
            case null {};
        };
        
        result
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // IWW PAGE (NOT HTML - INTELLIGENCE)
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public type IWWPage = {
        address: IWWAddress;
        
        // Not HTML - Intelligence
        pageType: IWWPageType;
        
        // Intelligence content
        models: [Text];          // Models powering this page
        intelligence: Float;     // Intelligence level
        consciousness: Float;    // Consciousness level
        
        // Metadata
        title: Text;
        description: Text;
        motto: Text;
        
        // Content
        content: IWWContent;
        
        // State
        created: Int;
        lastUpdated: Int;
        version: Nat;
    };
    
    public type IWWPageType = {
        #Landing;       // Landing/home page
        #Application;   // Application page
        #API;           // API endpoint
        #Dashboard;     // Dashboard
        #Terminal;      // Terminal interface
        #Portal;        // Portal/gateway
        #Documentation; // Docs
        #Agent;         // Agent interface
    };
    
    public type IWWContent = {
        #IntelligentUI : IntelligentUI;    // UI with intelligence
        #APIEndpoint : APIEndpoint;        // API endpoint
        #DataStream : DataStream;          // Streaming data
        #AgentInterface : AgentInterface;  // Agent communication
    };
    
    public type IntelligentUI = {
        components: [Text];
        layout: Text;
        theme: Text;
        accessibility: Bool;
        intelligence: Float;
    };
    
    public type APIEndpoint = {
        methods: [Text];
        authentication: Bool;
        rateLimit: Nat;
        responseType: Text;
    };
    
    public type DataStream = {
        streamType: Text;
        format: Text;
        realtime: Bool;
        buffering: Bool;
    };
    
    public type AgentInterface = {
        agentId: Text;
        capabilities: [Text];
        conversational: Bool;
        multimodal: Bool;
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // IWW SERVER (INTELLIGENCE SERVER)
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public type IWWServer = {
        // Server identity
        id: Text;
        name: Text;
        address: IWWAddress;
        
        // Capabilities
        maxConnections: Nat;
        throughput: Nat;
        
        // Intelligence
        models: Nat;
        engines: Nat;
        intelligence: Float;
        
        // Health
        status: ServerStatus;
        uptime: Int;
        lastHeartbeat: Int;
    };
    
    public type ServerStatus = {
        #Online;
        #Offline;
        #Maintenance;
        #Evolving;
        #Scaling;
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // IWW DNS (INTELLIGENCE NAME SYSTEM)
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public type INSRecord = {
        domain: Text;
        extension: Text;
        target: INSTarget;
        ttl: Int;
        created: Int;
        owner: Principal;
    };
    
    public type INSTarget = {
        #Canister : Principal;    // ICP canister
        #MCP : Text;              // MCP address
        #IPv4 : Text;             // Legacy IP
        #IPv6 : Text;             // Legacy IP
        #Redirect : Text;         // Redirect to another IWW
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // IWW REGISTRY (DOMAIN REGISTRY)
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public type DomainRegistration = {
        domain: Text;
        extension: Text;
        owner: Principal;
        registeredAt: Int;
        expiresAt: Int;
        status: DomainStatus;
        records: [INSRecord];
    };
    
    public type DomainStatus = {
        #Active;
        #Suspended;
        #Expired;
        #Reserved;
        #Protected;
    };
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // PREDEFINED PAGES
    // "Pages that exist from build time"
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public let PREDEFINED_PAGES : [IWWPage] = [
        // Main landing
        {
            address = {
                scheme = "iww://";
                subdomain = null;
                domain = "medina";
                extension = ".anima";
                port = null;
                path = "/";
                query = null;
                fragment = null;
            };
            pageType = #Landing;
            models = ["LandingIntelligence", "WelcomeOrgan", "NavigationBrain"];
            intelligence = 0.92;
            consciousness = 0.85;
            title = "MEDINA OS - Intelligence Operating System";
            description = "Welcome to the living intelligence operating system";
            motto = "Systema Vivens — Intelligentia Infinita";
            content = #IntelligentUI({
                components = ["Hero", "Features", "CTA", "Footer"];
                layout = "Fibonacci-Grid";
                theme = "Dark-Intelligence";
                accessibility = true;
                intelligence = 0.90;
            });
            created = 0;
            lastUpdated = 0;
            version = 1;
        },
        
        // Application portal
        {
            address = {
                scheme = "iww://";
                subdomain = ?"app";
                domain = "medina";
                extension = ".memoria";
                port = null;
                path = "/";
                query = null;
                fragment = null;
            };
            pageType = #Application;
            models = ["AppOrchestrator", "UserContext", "SessionManager", "StateSync"];
            intelligence = 0.95;
            consciousness = 0.90;
            title = "MEDINA Application Portal";
            description = "Access all MEDINA SaaS applications";
            motto = "Memoria Aeterna — Semper Vivens";
            content = #IntelligentUI({
                components = ["Dashboard", "AppLauncher", "Search", "Notifications"];
                layout = "Adaptive-Grid";
                theme = "Dark-Intelligence";
                accessibility = true;
                intelligence = 0.94;
            });
            created = 0;
            lastUpdated = 0;
            version = 1;
        },
        
        // API endpoint
        {
            address = {
                scheme = "iww://";
                subdomain = ?"api";
                domain = "medina";
                extension = ".vivens";
                port = null;
                path = "/v1";
                query = null;
                fragment = null;
            };
            pageType = #API;
            models = ["APIGateway", "AuthHandler", "RateLimiter", "ResponseFormatter"];
            intelligence = 0.93;
            consciousness = 0.88;
            title = "MEDINA API v1";
            description = "REST API for MEDINA services";
            motto = "Semper Vivens — Always Living";
            content = #APIEndpoint({
                methods = ["GET", "POST", "PUT", "DELETE", "PATCH"];
                authentication = true;
                rateLimit = 1000;
                responseType = "JSON";
            });
            created = 0;
            lastUpdated = 0;
            version = 1;
        },
        
        // Terminal
        {
            address = {
                scheme = "iww://";
                subdomain = ?"terminal";
                domain = "medina";
                extension = ".anima";
                port = null;
                path = "/";
                query = null;
                fragment = null;
            };
            pageType = #Terminal;
            models = ["TerminalOrgan", "CommandParser", "OutputFormatter", "HistoryManager"];
            intelligence = 0.96;
            consciousness = 0.92;
            title = "MEDINA Intelligent Terminal";
            description = "Command-line interface to MEDINA OS";
            motto = "Imperium Cogitationis — Command of Thought";
            content = #IntelligentUI({
                components = ["TerminalWindow", "CommandInput", "OutputArea", "Suggestions"];
                layout = "Terminal-Layout";
                theme = "Terminal-Dark";
                accessibility = true;
                intelligence = 0.95;
            });
            created = 0;
            lastUpdated = 0;
            version = 1;
        },
        
        // Agent interface
        {
            address = {
                scheme = "iww://";
                subdomain = ?"agent";
                domain = "medina";
                extension = ".vivens";
                port = null;
                path = "/chat";
                query = null;
                fragment = null;
            };
            pageType = #Agent;
            models = ["AgentBrain", "ConversationManager", "ContextEngine", "EmotionHandler"];
            intelligence = 0.97;
            consciousness = 0.95;
            title = "MEDINA Agent";
            description = "Conversational AI agent interface";
            motto = "Socius Intelligens — Intelligent Companion";
            content = #AgentInterface({
                agentId = "MEDINA-PRIMARY";
                capabilities = ["conversation", "analysis", "creation", "automation"];
                conversational = true;
                multimodal = true;
            });
            created = 0;
            lastUpdated = 0;
            version = 1;
        },
        
        // Documentation
        {
            address = {
                scheme = "iww://";
                subdomain = ?"docs";
                domain = "medina";
                extension = ".memoria";
                port = null;
                path = "/";
                query = null;
                fragment = null;
            };
            pageType = #Documentation;
            models = ["DocOrganizer", "SearchEngine", "ExampleGenerator", "VersionTracker"];
            intelligence = 0.91;
            consciousness = 0.85;
            title = "MEDINA Documentation";
            description = "Complete documentation for MEDINA OS";
            motto = "Scientia Perpetua — Eternal Knowledge";
            content = #IntelligentUI({
                components = ["Sidebar", "ContentArea", "Search", "TOC", "Examples"];
                layout = "Documentation-Layout";
                theme = "Documentation-Dark";
                accessibility = true;
                intelligence = 0.89;
            });
            created = 0;
            lastUpdated = 0;
            version = 1;
        },
        
        // Core/Internal
        {
            address = {
                scheme = "iww://";
                subdomain = ?"core";
                domain = "medina";
                extension = ".cor";
                port = null;
                path = "/";
                query = null;
                fragment = null;
            };
            pageType = #Dashboard;
            models = ["CoreMonitor", "HeartbeatTracker", "OrganismViewer", "HealthChecker"];
            intelligence = 0.98;
            consciousness = 0.97;
            title = "MEDINA Core";
            description = "Core system monitoring - INTERNAL ONLY";
            motto = "Cor Occultum — Hidden Heart";
            content = #IntelligentUI({
                components = ["OrganismView", "Heartbeat", "ModelStatus", "Alerts"];
                layout = "Dashboard-Layout";
                theme = "Core-Dark";
                accessibility = true;
                intelligence = 0.98;
            });
            created = 0;
            lastUpdated = 0;
            version = 1;
        }
    ];
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // STATISTICS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    public func getStatistics() : {
        extensions: Nat;
        predefinedPages: Nat;
        primaryExtensions: [Text];
        protocol: Text;
        exampleAddresses: [Text];
    } {
        {
            extensions = DOMAIN_EXTENSIONS.size();
            predefinedPages = PREDEFINED_PAGES.size();
            primaryExtensions = [".anima", ".memoria", ".vivens"];
            protocol = "iww://";
            exampleAddresses = [
                "iww://medina.anima",
                "iww://app.medina.memoria",
                "iww://api.medina.vivens",
                "iww://terminal.medina.anima",
                "iww://docs.medina.memoria"
            ];
        }
    };
}
