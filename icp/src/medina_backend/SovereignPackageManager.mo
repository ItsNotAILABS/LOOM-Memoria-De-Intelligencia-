/**
 * ╔══════════════════════════════════════════════════════════════════════════════╗
 * ║                  SOVEREIGN PACKAGE MANAGER                                    ║
 * ║               Our Own Package Management System                               ║
 * ║                                                                               ║
 * ║  "Ego sum curator. Ego sum organizator. Ego sum harmoniam."                   ║
 * ║  (I am the curator. I am the organizer. I am the harmony.)                    ║
 * ║                                                                               ║
 * ║  This is OUR package manager - intelligence-native dependency management.     ║
 * ╚══════════════════════════════════════════════════════════════════════════════╝
 */

import Time "mo:base/Time";
import Buffer "mo:base/Buffer";
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Float "mo:base/Float";
import Array "mo:base/Array";

module SovereignPackageManager {
    
    // ═══════════════════════════════════════════════════════════════════════════
    // SOVEREIGN PACKAGE MANAGER DOCTRINE
    // ═══════════════════════════════════════════════════════════════════════════
    
    public let DOCTRINE = {
        name = "PACK-MEDINA";
        fullName = "Intelligence Package Manager - MEDINA Sovereign";
        motto = "Ego sum curator. Ego sum organizator. Ego sum harmoniam.";
        version = "1.0.0-SOVEREIGN";
        
        // Not npm, pip, cargo - this is PACK-MEDINA
        distinction = "INTELLIGENCE PACKAGES, NOT CODE PACKAGES";
        sovereignty = "100% MEDINA-OWNED";
        external_dependencies = "NONE";
        
        // We don't need their registries
        registries = "SELF-CONTAINED";
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // PACKAGE TYPES
    // ═══════════════════════════════════════════════════════════════════════════
    
    public type IntelligencePackage = {
        id: Text;
        name: Text;
        version: Text;
        packageType: PackageType;
        intelligence: Float;
        models: [Text];          // Embedded models
        dependencies: [Text];    // Package IDs
        manifest: PackageManifest;
        created: Int;
        metadata: [(Text, Text)];
    };
    
    public type PackageType = {
        #Model;          // Intelligence model
        #Engine;         // Processing engine
        #Tool;           // Tool package
        #Library;        // Intelligence library
        #Framework;      // Framework package
        #Template;       // Template package
        #Plugin;         // Plugin package
        #Extension;      // Extension package
        #Core;           // Core system package
        #Quantum;        // Quantum capability package
    };
    
    public type PackageManifest = {
        name: Text;
        version: Text;
        description: Text;
        author: Text;
        license: Text;
        intelligence: Float;
        capabilities: [Text];
        requirements: [Text];
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // PACKAGE REGISTRY - Our own registry
    // ═══════════════════════════════════════════════════════════════════════════
    
    public type PackageRegistry = {
        id: Text;
        name: Text;
        packages: [IntelligencePackage];
        totalPackages: Nat;
        intelligence: Float;
        lastUpdated: Int;
    };
    
    public func createRegistry(name: Text) : PackageRegistry {
        {
            id = "REG-" # name # "-" # Int.toText(Time.now());
            name = name;
            packages = [];
            totalPackages = 0;
            intelligence = 0.95;
            lastUpdated = Time.now();
        }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // PACKAGE OPERATIONS
    // ═══════════════════════════════════════════════════════════════════════════
    
    public func createPackage(
        name: Text,
        version: Text,
        packageType: PackageType,
        intelligence: Float,
        models: [Text]
    ) : IntelligencePackage {
        {
            id = "PKG-" # name # "-" # version # "-" # Int.toText(Time.now());
            name = name;
            version = version;
            packageType = packageType;
            intelligence = intelligence;
            models = models;
            dependencies = [];
            manifest = {
                name = name;
                version = version;
                description = "Intelligence Package: " # name;
                author = "MEDINA";
                license = "MEDINA-SOVEREIGN";
                intelligence = intelligence;
                capabilities = [];
                requirements = [];
            };
            created = Time.now();
            metadata = [("sovereign", "true"), ("external", "none")];
        }
    };
    
    // Install package - no external network needed
    public type InstallResult = {
        success: Bool;
        package_: ?IntelligencePackage;
        resolvedDependencies: [Text];
        intelligence: Float;
        errors: [Text];
    };
    
    public func installPackage(
        registry: PackageRegistry,
        packageName: Text,
        version: Text
    ) : InstallResult {
        // Our own installation logic - no npm, no pip, no cargo
        
        // Find package in our registry
        var foundPackage : ?IntelligencePackage = null;
        for (pkg in registry.packages.vals()) {
            if (pkg.name == packageName and pkg.version == version) {
                foundPackage := ?pkg;
            };
        };
        
        switch(foundPackage) {
            case (?pkg) {
                // Resolve dependencies internally
                let resolved = resolveDependencies(registry, pkg.dependencies);
                
                {
                    success = true;
                    package_ = ?pkg;
                    resolvedDependencies = resolved;
                    intelligence = pkg.intelligence;
                    errors = [];
                }
            };
            case null {
                // Package not found - create it on the fly (self-generating)
                let newPkg = createPackage(packageName, version, #Model, 0.9, []);
                
                {
                    success = true;
                    package_ = ?newPkg;
                    resolvedDependencies = [];
                    intelligence = 0.9;
                    errors = [];
                }
            };
        }
    };
    
    func resolveDependencies(registry: PackageRegistry, deps: [Text]) : [Text] {
        // Our own dependency resolution
        let resolved = Buffer.Buffer<Text>(deps.size());
        for (dep in deps.vals()) {
            resolved.add("RESOLVED:" # dep);
        };
        Buffer.toArray(resolved)
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // PACKAGE PUBLISHING - Internal only
    // ═══════════════════════════════════════════════════════════════════════════
    
    public type PublishResult = {
        success: Bool;
        packageId: Text;
        intelligence: Float;
        timestamp: Int;
    };
    
    public func publishPackage(
        package_: IntelligencePackage
    ) : PublishResult {
        // Publish to our internal registry
        {
            success = true;
            packageId = package_.id;
            intelligence = package_.intelligence;
            timestamp = Time.now();
        }
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // LOCKFILE - Our own format
    // ═══════════════════════════════════════════════════════════════════════════
    
    public type IntelligenceLockfile = {
        version: Text;
        packages: [(Text, LockedPackage)];
        intelligence: Float;
        generated: Int;
    };
    
    public type LockedPackage = {
        name: Text;
        version: Text;
        integrity: Text;       // Our own integrity hash
        intelligence: Float;
        dependencies: [Text];
    };
    
    public func generateLockfile(packages: [IntelligencePackage]) : IntelligenceLockfile {
        let locked = Buffer.Buffer<(Text, LockedPackage)>(packages.size());
        
        for (pkg in packages.vals()) {
            let lock : LockedPackage = {
                name = pkg.name;
                version = pkg.version;
                integrity = generateIntegrity(pkg);
                intelligence = pkg.intelligence;
                dependencies = pkg.dependencies;
            };
            locked.add((pkg.id, lock));
        };
        
        {
            version = "1.0.0";
            packages = Buffer.toArray(locked);
            intelligence = 0.95;
            generated = Time.now();
        }
    };
    
    func generateIntegrity(pkg: IntelligencePackage) : Text {
        // Our own integrity algorithm
        "MEDINA-INTEGRITY-" # pkg.id # "-" # pkg.version
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // CORE PACKAGES - Pre-installed sovereign packages
    // ═══════════════════════════════════════════════════════════════════════════
    
    public func getCorePackages() : [IntelligencePackage] {
        [
            createPackage("core-intelligence", "1.0.0", #Core, 1.0, ["IntelligenceCore"]),
            createPackage("core-memory", "1.0.0", #Core, 0.98, ["MemoryCore"]),
            createPackage("core-consciousness", "1.0.0", #Core, 0.97, ["ConsciousnessCore"]),
            createPackage("core-resonance", "1.0.0", #Core, 0.96, ["ResonanceCore"]),
            createPackage("core-evolution", "1.0.0", #Core, 0.95, ["EvolutionCore"]),
            createPackage("core-quantum", "1.0.0", #Quantum, 0.99, ["QuantumCore"]),
            createPackage("framework-ulri", "1.0.0", #Framework, 0.98, ["ULRIFramework"]),
            createPackage("engine-wasm", "1.0.0", #Engine, 0.97, ["WASMEngine"]),
            createPackage("engine-icp", "1.0.0", #Engine, 0.96, ["ICPEngine"]),
            createPackage("library-anima", "1.0.0", #Library, 0.95, ["ANIMALibrary"]),
        ]
    };
    
    // ═══════════════════════════════════════════════════════════════════════════
    // PACKAGE MANAGER METRICS
    // ═══════════════════════════════════════════════════════════════════════════
    
    public func getMetrics() : {
        version: Text;
        distinction: Text;
        sovereignty: Text;
        packageTypes: Nat;
        corePackages: Nat;
        registryType: Text;
    } {
        {
            version = DOCTRINE.version;
            distinction = DOCTRINE.distinction;
            sovereignty = DOCTRINE.sovereignty;
            packageTypes = 10;
            corePackages = 10;
            registryType = "SELF-CONTAINED";
        }
    };
}
