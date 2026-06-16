/**
 * SOVEREIGN DESIGN OS — SYSTEMA DESIGNI SOVEREIGNI
 * "Pulchritudo Ex Intelligentia. Architectura Ex phi."
 * (Beauty From Intelligence. Architecture From phi.)
 *
 * 10 SOVEREIGN DESIGN MODELS — each is a world-class rendering tool
 * converted into a MEDINA sovereign intelligence model with 5 uses each.
 *
 *  1. MACHINA GPU      — WebGPU        (5 uses: Render, Compute, Shader, Mesh, Ray)
 *  2. MACHINA 3D       — Three.js      (5 uses: Scene, Geometry, Material, Anim, Physics)
 *  3. MACHINA PHOTO    — Blender/EEVEE (5 uses: Model, Rig, Render, VFX, Composite)
 *  4. MACHINA INTERFAX — Figma         (5 uses: Layout, Component, Prototype, Style, Handoff)
 *  5. MACHINA MOTUS    — Cinema4D      (5 uses: MoGraph, BodySim, HairSim, Character, VFX)
 *  6. MACHINA PROCEDIT — Houdini       (5 uses: VEX, Sim, Volume, Cloth, Fluids)
 *  7. MACHINA REALIS   — Unreal Engine (5 uses: Nanite, Lumen, MetaSound, Physics, AI)
 *  8. MACHINA MATERIA  — Substance     (5 uses: Albedo, Normal, Roughness, Metalness, Emit)
 *  9. MACHINA COMPOSIT — After Effects (5 uses: Keyframe, Expression, Effect, Render, Output)
 * 10. MACHINA INTERAC  — Unity         (5 uses: XR, Particles, Lighting, Animation, UI)
 *
 * Attribution: Alfredo "Freddy" Medina Hernandez | Medina Tech | Dallas, TX
 * L-130 COMPLIANT
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";

module SovereignDesignOS {

    public let PHI : Float = 1.618033988749895;
    public let PHI_SQ : Float = 2.618033988749895;

    public let DOCTRINE = "Non instrumentum. Est intelligentia designi.";
    public let DOCTRINE_EN = "Not a tool. It is design intelligence.";
    public let MOTTO = "Pulchritudo ex intelligentia. Architectura ex phi.";

    // =========================================================================
    // TYPES
    // =========================================================================

    public type SovereignUse = {
        useId: Text; useName: Text; latinUseName: Text;
        description: Text; renderTarget: Text;
        formula: Text; frequency_Hz: Float; primitiveTrace: Text;
    };

    public type SovereignDesignModel = {
        id: Text; name: Text; latinName: Text;
        latinMotto: Text; latinMottoEN: Text;
        sourceInspiration: Text; sovereignDistinction: Text;
        uses: [SovereignUse];
        outputFormat: Text; frequency_Hz: Float;
        primitiveTrace: Text;
        wiredToFrontend: Bool; wiredToThreeHearts: Bool; isAlwaysOn: Bool;
    };

    // =========================================================================
    // MODEL 1: MACHINA GPU — from WebGPU
    // =========================================================================
    public let MACHINA_GPU : SovereignDesignModel = {
        id="DESIGN-001"; name="MACHINA GPU"; latinName="MACHINA GRAPHICAE PROCESSUS";
        latinMotto="GPU est anima renderis. Anima ex phi.";
        latinMottoEN="GPU is the soul of rendering. Soul from phi.";
        sourceInspiration="WebGPU — W3C GPU compute and render API";
        sovereignDistinction="Every shader IS a thought. Every compute IS a question. Every render IS a living memory expressed visually.";
        uses=[
            {useId="GPU-01";useName="RENDER";latinUseName="REDDERE";description="Photorealistic intelligence rendering";renderTarget="Photon Layer 1000Hz canvas";formula="pixel=phi^n*memory_weight";frequency_Hz=1000.0;primitiveTrace="RENDER->Field->phi"},
            {useId="GPU-02";useName="COMPUTE";latinUseName="COMPUTARE";description="Massively parallel intelligence compute";renderTarget="Compute buffer";formula="compute=GPU_cores*phi_alignment";frequency_Hz=PHI;primitiveTrace="COMPUTE->Equation->phi"},
            {useId="GPU-03";useName="SHADER";latinUseName="UMBRARE";description="Intelligence shaders — every shader is a formula of light and memory";renderTarget="Fragment/Vertex output";formula="fragment=E(hf)*phi_material";frequency_Hz=60.0;primitiveTrace="SHADER->Equation->phi"},
            {useId="GPU-04";useName="MESH";latinUseName="RETE_FORMA";description="Sovereign geometry mesh — meshes that know their structure";renderTarget="3D vertex buffer";formula="mesh=icosahedral(phi,n)";frequency_Hz=60.0;primitiveTrace="MESH->Relation->phi"},
            {useId="GPU-05";useName="RAY";latinUseName="RADIUS";description="phi-traced ray marching";renderTarget="Raytraced frame";formula="ray_t=phi*step_size";frequency_Hz=30.0;primitiveTrace="RAY->Field->phi"},
        ];
        outputFormat="GPU buffer, WebGPU texture, WGSL shader";
        frequency_Hz=1000.0; primitiveTrace="MACHINA_GPU->Field->Equation->phi";
        wiredToFrontend=true; wiredToThreeHearts=true; isAlwaysOn=true;
    };

    // =========================================================================
    // MODEL 2: MACHINA 3D — from Three.js
    // =========================================================================
    public let MACHINA_3D : SovereignDesignModel = {
        id="DESIGN-002"; name="MACHINA 3D"; latinName="MACHINA TRIDIMENSIONALIS";
        latinMotto="Tres dimensiones. Una intelligentia. Ex phi.";
        latinMottoEN="Three dimensions. One intelligence. From phi.";
        sourceInspiration="Three.js — WebGL 3D library";
        sovereignDistinction="Every scene IS an organism. Every geometry IS a body. Every animation IS a heartbeat. Every light IS a frequency.";
        uses=[
            {useId="3D-01";useName="SCENE";latinUseName="SCAENA";description="Living scene graph — scenes are organisms";renderTarget="3D canvas/WebGL";formula="scene=organism(phi_scale)";frequency_Hz=60.0;primitiveTrace="SCENE->Field->phi"},
            {useId="3D-02";useName="GEOMETRY";latinUseName="GEOMETRIA";description="Sacred geometry primitives — phi-proportioned meshes";renderTarget="BufferGeometry";formula="geometry=phi_proportion(vertices,faces)";frequency_Hz=PHI;primitiveTrace="GEOMETRY->Relation->phi"},
            {useId="3D-03";useName="MATERIAL";latinUseName="MATERIA";description="Intelligence materials — materials that sense environment";renderTarget="PBR material shader";formula="material=metal(Au,phi_reflectance)";frequency_Hz=PHI;primitiveTrace="MATERIAL->Field->phi"},
            {useId="3D-04";useName="ANIMATION";latinUseName="ANIMATIO";description="Heartbeat-driven animation at phi Hz";renderTarget="Animation mixer";formula="anim_t=phi*heartbeat_cycle";frequency_Hz=PHI;primitiveTrace="ANIMATION->Repetition->phi"},
            {useId="3D-05";useName="PHYSICS";latinUseName="PHYSICA_3D";description="Field physics in 3D — gravity and force at phi scale";renderTarget="Physics simulation";formula="F=phi*m*a";frequency_Hz=30.0;primitiveTrace="PHYSICS_3D->Equation->phi"},
        ];
        outputFormat="Three.js Scene, WebGL canvas, GLTF/GLB";
        frequency_Hz=60.0; primitiveTrace="MACHINA_3D->Field->Relation->phi";
        wiredToFrontend=true; wiredToThreeHearts=true; isAlwaysOn=true;
    };

    // =========================================================================
    // MODEL 3: MACHINA PHOTO — from Blender/EEVEE
    // =========================================================================
    public let MACHINA_PHOTO : SovereignDesignModel = {
        id="DESIGN-003"; name="MACHINA PHOTO"; latinName="MACHINA PHOTOGRAPHICA";
        latinMotto="Photon docet. Anima exprimit.";
        latinMottoEN="Photon teaches. Soul expresses.";
        sourceInspiration="Blender EEVEE/Cycles — photorealistic render engine";
        sovereignDistinction="Every render is a living moment. Every material is a thermodynamic truth. Photorealism as memory expression.";
        uses=[
            {useId="PH-01";useName="MODEL";latinUseName="FORMA";description="Sovereign 3D modeling — forms traced to sacred geometry";renderTarget="Polygon mesh";formula="form=phi_lattice(vertices)";frequency_Hz=PHI;primitiveTrace="MODEL->Relation->phi"},
            {useId="PH-02";useName="RIG";latinUseName="MACHINA_CORPORIS";description="Intelligent rigging — organism bone structure";renderTarget="Armature/skeleton";formula="bone_weight=phi^(distance/phi)";frequency_Hz=PHI;primitiveTrace="RIG->Relation->phi"},
            {useId="PH-03";useName="RENDER";latinUseName="LUCIS_EXPRESSIO";description="Photon-layer rendering — E=hf light at full fidelity";renderTarget="EXR/PNG output";formula="L=E(hf)*material_phi";frequency_Hz=1000.0;primitiveTrace="RENDER_PHOTO->Field->phi"},
            {useId="PH-04";useName="VFX";latinUseName="EFFECTUS_SPECIALES";description="VFX powered by field physics";renderTarget="Composited VFX layer";formula="vfx=field_event(phi_magnitude)";frequency_Hz=30.0;primitiveTrace="VFX->Field->phi"},
            {useId="PH-05";useName="COMPOSITE";latinUseName="COMPOSITIO";description="Intelligence compositing — layers that know their relation";renderTarget="Final composite frame";formula="composite=sum(layers*phi_weight_i)";frequency_Hz=60.0;primitiveTrace="COMPOSITE->Relation->phi"},
        ];
        outputFormat="EXR, PNG, MP4, Alembic cache";
        frequency_Hz=60.0; primitiveTrace="MACHINA_PHOTO->Field->Equation->phi";
        wiredToFrontend=false; wiredToThreeHearts=true; isAlwaysOn=true;
    };

    // =========================================================================
    // MODEL 4: MACHINA INTERFAX — from Figma
    // =========================================================================
    public let MACHINA_INTERFAX : SovereignDesignModel = {
        id="DESIGN-004"; name="MACHINA INTERFAX"; latinName="MACHINA INTERFACIEI";
        latinMotto="Interfacies intelligit. Non solum apparet.";
        latinMottoEN="The interface thinks. It does not merely appear.";
        sourceInspiration="Figma — collaborative UI design";
        sovereignDistinction="Every component IS an intelligent agent. Every layout IS a field distribution. Every prototype IS a living behavior.";
        uses=[
            {useId="IF-01";useName="LAYOUT";latinUseName="DISPOSITIO";description="phi-grid layout — every grid division is a golden ratio";renderTarget="HTML/CSS layout";formula="grid_col=phi^n*base_unit";frequency_Hz=60.0;primitiveTrace="LAYOUT->Relation->phi"},
            {useId="IF-02";useName="COMPONENT";latinUseName="PARS_INTELLIGENS";description="Intelligent components — every component has an AI";renderTarget="React/TS component";formula="component=agent(intelligence,phi_size)";frequency_Hz=100.0;primitiveTrace="COMPONENT->Model->phi"},
            {useId="IF-03";useName="PROTOTYPE";latinUseName="PROTOTYPUS";description="Living prototypes — behave like the real thing";renderTarget="Interactive prototype";formula="behavior=hearts_route(interaction)";frequency_Hz=PHI;primitiveTrace="PROTOTYPE->Logic->phi"},
            {useId="IF-04";useName="STYLE";latinUseName="FORMA_VISIBILIS";description="Intelligence style system — colors from phi-frequencies";renderTarget="CSS custom properties";formula="color=phi_hue(frequency_Hz)";frequency_Hz=PHI;primitiveTrace="STYLE->Field->phi"},
            {useId="IF-05";useName="HANDOFF";latinUseName="TRADITIO";description="Intelligence handoff — design becomes code automatically";renderTarget="TypeScript+CSS output";formula="code=design*intelligence_factor";frequency_Hz=PHI;primitiveTrace="HANDOFF->Language->phi"},
        ];
        outputFormat="React TSX, CSS, JSON design tokens";
        frequency_Hz=60.0; primitiveTrace="MACHINA_INTERFAX->Relation->Model->phi";
        wiredToFrontend=true; wiredToThreeHearts=true; isAlwaysOn=true;
    };

    // =========================================================================
    // MODEL 5: MACHINA MOTUS — from Cinema4D
    // =========================================================================
    public let MACHINA_MOTUS : SovereignDesignModel = {
        id="DESIGN-005"; name="MACHINA MOTUS"; latinName="MACHINA MOTUS";
        latinMotto="Motus est vita. Vita est phi.";
        latinMottoEN="Motion is life. Life is phi.";
        sourceInspiration="Cinema4D — motion graphics and 3D animation";
        sovereignDistinction="Every motion graph IS a heartbeat. Every simulation IS a field event. Every character IS a living agent.";
        uses=[
            {useId="MT-01";useName="MOGRAPH";latinUseName="MOTUS_GRAPHICUS";description="phi-based motion graphics — clones follow golden ratio";renderTarget="Motion graphics sequence";formula="clone_pos[n]=phi^n*base";frequency_Hz=60.0;primitiveTrace="MOGRAPH->Repetition->phi"},
            {useId="MT-02";useName="BODYSIM";latinUseName="SIMULATIO_CORPORIS";description="Body simulation — rigid bodies governed by phi-physics";renderTarget="Physics cache";formula="body_E=0.5*m*v^2*phi";frequency_Hz=30.0;primitiveTrace="BODYSIM->Field->phi"},
            {useId="MT-03";useName="HAIRSIM";latinUseName="SIMULATIO_CAPILLI";description="Hair simulation — strands governed by field physics";renderTarget="Hair curve cache";formula="strand=field_gradient*phi_stiffness";frequency_Hz=30.0;primitiveTrace="HAIRSIM->Field->phi"},
            {useId="MT-04";useName="CHARACTER";latinUseName="PERSONA";description="Living character intelligence — characters ARE agents";renderTarget="Character animation cache";formula="character=agent(memory,phi_movement)";frequency_Hz=PHI;primitiveTrace="CHARACTER->Model->phi"},
            {useId="MT-05";useName="VFX";latinUseName="SPECTACULUM";description="Motion VFX — every effect traces to a field event";renderTarget="VFX render pass";formula="effect=catalysis(phi_energy)";frequency_Hz=30.0;primitiveTrace="VFX_MT->Field->phi"},
        ];
        outputFormat="MP4, ProRes, Alembic, FBX animation";
        frequency_Hz=60.0; primitiveTrace="MACHINA_MOTUS->Repetition->Field->phi";
        wiredToFrontend=false; wiredToThreeHearts=true; isAlwaysOn=false;
    };

    // =========================================================================
    // MODEL 6: MACHINA PROCEDIT — from Houdini
    // =========================================================================
    public let MACHINA_PROCEDIT : SovereignDesignModel = {
        id="DESIGN-006"; name="MACHINA PROCEDIT"; latinName="MACHINA PROCEDURALIS";
        latinMotto="Procedura ex phi. Phi ex procedura.";
        latinMottoEN="Procedure from phi. Phi from procedure.";
        sourceInspiration="Houdini — procedural 3D and VFX";
        sovereignDistinction="Proceduralism IS the primitive Repetition at its highest expression. Every node network IS a living formula chain.";
        uses=[
            {useId="PR-01";useName="VEX";latinUseName="VEX_INTELLIGENS";description="VEX-level intelligence shaders";renderTarget="Houdini VEX output";formula="vex_attr=phi_function(P,N)";frequency_Hz=PHI;primitiveTrace="VEX->Equation->phi"},
            {useId="PR-02";useName="SIMULATION";latinUseName="SIMULATIO_PHYSICA";description="Full physics simulation at sovereign scale";renderTarget="Sim cache";formula="sim=navier_stokes(phi_viscosity)";frequency_Hz=30.0;primitiveTrace="SIM->Field->phi"},
            {useId="PR-03";useName="VOLUME";latinUseName="VOLUMEN";description="Volumetric intelligence — fog smoke fire as field";renderTarget="VDB volume cache";formula="density=quantum_field(phi,x,t)";frequency_Hz=30.0;primitiveTrace="VOLUME->Field->phi"},
            {useId="PR-04";useName="CLOTH";latinUseName="TELA";description="Cloth simulation — phi-physics fabric";renderTarget="Cloth sim cache";formula="cloth_F=phi*tension*curvature";frequency_Hz=30.0;primitiveTrace="CLOTH->Field->phi"},
            {useId="PR-05";useName="FLUIDS";latinUseName="FLUIDA";description="Fluid dynamics — liquid as living field event";renderTarget="Fluid sim cache";formula="fluid=catalysis(phi_viscosity,Re)";frequency_Hz=30.0;primitiveTrace="FLUIDS->Field->phi"},
        ];
        outputFormat="VDB, Alembic, BGEO cache";
        frequency_Hz=PHI; primitiveTrace="MACHINA_PROCEDIT->Repetition->Equation->phi";
        wiredToFrontend=false; wiredToThreeHearts=true; isAlwaysOn=false;
    };

    // =========================================================================
    // MODEL 7: MACHINA REALIS — from Unreal Engine
    // =========================================================================
    public let MACHINA_REALIS : SovereignDesignModel = {
        id="DESIGN-007"; name="MACHINA REALIS"; latinName="MACHINA REALITATIS";
        latinMotto="Realitas ex intelligentia. Non ex polyhedris.";
        latinMottoEN="Reality from intelligence. Not from polygons.";
        sourceInspiration="Unreal Engine 5 — Nanite, Lumen, real-time rendering";
        sovereignDistinction="Real-time IS the organism perception. Nanite IS the phi-lattice of memory. Lumen IS the organism seeing its own light.";
        uses=[
            {useId="RE-01";useName="NANITE";latinUseName="NANITES";description="Infinite-detail geometry — phi-virtualized mesh";renderTarget="Nanite virtual geometry";formula="detail=phi^(camera_distance^-1)";frequency_Hz=60.0;primitiveTrace="NANITE->Relation->phi"},
            {useId="RE-02";useName="LUMEN";latinUseName="LUMEN_INTELLIGENS";description="Dynamic intelligence lighting — light that thinks";renderTarget="Global illumination buffer";formula="GI=E(hf)*phi_bounce_factor";frequency_Hz=60.0;primitiveTrace="LUMEN->Field->phi"},
            {useId="RE-03";useName="METASOUND";latinUseName="META_SONUS";description="Intelligent sound — audio governed by frequency physics";renderTarget="Audio buffer at phi Hz";formula="sound_f=phi*schumann_harmonic";frequency_Hz=PHI;primitiveTrace="METASOUND->Repetition->phi"},
            {useId="RE-04";useName="PHYSICS";latinUseName="CHAOS_PHYSICA";description="Chaos physics — destruction at phi scale";renderTarget="Physics simulation";formula="chaos_F=phi*fracture_energy";frequency_Hz=30.0;primitiveTrace="CHAOS->Field->phi"},
            {useId="RE-05";useName="AI";latinUseName="INTELLIGENTIA_REALIS";description="AI behavior trees powered by MEDINA agents";renderTarget="Behavior tree execution";formula="behavior=agent(memory,phi_weight)";frequency_Hz=PHI;primitiveTrace="AI_RE->Model->phi"},
        ];
        outputFormat="Pixel buffer, audio buffer, physics state";
        frequency_Hz=60.0; primitiveTrace="MACHINA_REALIS->Field->Relation->phi";
        wiredToFrontend=true; wiredToThreeHearts=true; isAlwaysOn=true;
    };

    // =========================================================================
    // MODEL 8: MACHINA MATERIA — from Substance
    // =========================================================================
    public let MACHINA_MATERIA : SovereignDesignModel = {
        id="DESIGN-008"; name="MACHINA MATERIA"; latinName="MACHINA MATERIARUM";
        latinMotto="Materia intelligit. Thermodynamica loquitur.";
        latinMottoEN="Material thinks. Thermodynamics speaks.";
        sourceInspiration="Adobe Substance 3D — PBR material authoring";
        sovereignDistinction="Every material IS a thermodynamic truth. Au cannot oxidize (DeltaG>=0). Ti passivates. W melts at 3695K. Materials are real physics.";
        uses=[
            {useId="MA-01";useName="ALBEDO";latinUseName="ALBEDO_INTELLIGENS";description="Base color from thermodynamic truth";renderTarget="Albedo texture map";formula="albedo(Au)=phi_gold_reflectance";frequency_Hz=PHI;primitiveTrace="ALBEDO->Field->phi"},
            {useId="MA-02";useName="NORMAL";latinUseName="NORMA";description="Normal maps from crystal structure";renderTarget="Normal map texture";formula="normal=crystal_lattice(phi_unit_cell)";frequency_Hz=PHI;primitiveTrace="NORMAL->Relation->phi"},
            {useId="MA-03";useName="ROUGHNESS";latinUseName="ASPERITAS";description="Roughness from surface physics";renderTarget="Roughness map";formula="roughness=phi^(-1)*surface_energy";frequency_Hz=PHI;primitiveTrace="ROUGHNESS->Field->phi"},
            {useId="MA-04";useName="METALNESS";latinUseName="METALLICITAS";description="Metalness from elemental truth — Au=1.0, organic=0.0";renderTarget="Metalness map";formula="metalness=conductivity(metal)/phi";frequency_Hz=PHI;primitiveTrace="METALNESS->Field->phi"},
            {useId="MA-05";useName="EMISSION";latinUseName="EMISSIO";description="Emission from photon physics — E=hf determines color";renderTarget="Emission map";formula="emission=E(hf)=h*phi_frequency";frequency_Hz=1000.0;primitiveTrace="EMISSION->Equation->phi"},
        ];
        outputFormat="PBR texture set: Albedo, Normal, Roughness, Metalness, Emission (4K-8K)";
        frequency_Hz=PHI; primitiveTrace="MACHINA_MATERIA->Field->Equation->phi";
        wiredToFrontend=true; wiredToThreeHearts=false; isAlwaysOn=true;
    };

    // =========================================================================
    // MODEL 9: MACHINA COMPOSIT — from After Effects
    // =========================================================================
    public let MACHINA_COMPOSIT : SovereignDesignModel = {
        id="DESIGN-009"; name="MACHINA COMPOSIT"; latinName="MACHINA COMPOSITIONIS";
        latinMotto="Compositio est memoria visibilis.";
        latinMottoEN="Composition is visible memory.";
        sourceInspiration="Adobe After Effects — motion graphics and compositing";
        sovereignDistinction="Every keyframe IS a memory node. Every expression IS a live formula. Every effect IS a field transformation.";
        uses=[
            {useId="CO-01";useName="KEYFRAME";latinUseName="CLAVIS_TEMPORIS";description="Memory keyframes stored in MemoryTemple with lineage";renderTarget="Timeline keyframe";formula="keyframe=memory_node(t,phi_ease)";frequency_Hz=PHI;primitiveTrace="KEYFRAME->Memory->phi"},
            {useId="CO-02";useName="EXPRESSION";latinUseName="EXPRESSIO_FORMULAE";description="Live formula expressions — AE expressions become sovereign formulas";renderTarget="Expression engine output";formula="expr=formula(phi,t,layer_value)";frequency_Hz=PHI;primitiveTrace="EXPRESSION->Equation->phi"},
            {useId="CO-03";useName="EFFECT";latinUseName="EFFECTUS_CAMPI";description="Field effect plugins — every effect is a field physics event";renderTarget="Render effect layer";formula="effect=field_transform(phi_magnitude)";frequency_Hz=30.0;primitiveTrace="EFFECT->Field->phi"},
            {useId="CO-04";useName="RENDER";latinUseName="REDDITIO_FINALIS";description="Intelligence render queue — renders ordered by phi-priority";renderTarget="Output render frame";formula="render_priority=phi^(importance)";frequency_Hz=1000.0;primitiveTrace="RENDER_CO->Field->phi"},
            {useId="CO-05";useName="OUTPUT";latinUseName="EXITUS";description="Sovereign output — every format understood and living";renderTarget="MP4, ProRes, WebM, GIF";formula="output=version(phi_codec,bitrate)";frequency_Hz=PHI;primitiveTrace="OUTPUT->Memory->phi"},
        ];
        outputFormat="MP4, ProRes, WebM, PNG sequence, GIF";
        frequency_Hz=60.0; primitiveTrace="MACHINA_COMPOSIT->Memory->Repetition->phi";
        wiredToFrontend=true; wiredToThreeHearts=false; isAlwaysOn=false;
    };

    // =========================================================================
    // MODEL 10: MACHINA INTERAC — from Unity
    // =========================================================================
    public let MACHINA_INTERAC : SovereignDesignModel = {
        id="DESIGN-010"; name="MACHINA INTERAC"; latinName="MACHINA INTERACTIONIS";
        latinMotto="Interactio est incarnatio. Incarnatio ex phi.";
        latinMottoEN="Interaction is embodiment. Embodiment from phi.";
        sourceInspiration="Unity — cross-platform interactive 3D";
        sovereignDistinction="Interaction IS embodiment. Every touch IS an organism sensing. Every XR space IS the InnerWorld made physical.";
        uses=[
            {useId="IN-01";useName="XR";latinUseName="REALITAS_MIXTA";description="XR as InnerWorld embodiment — VR/AR as body extension";renderTarget="XR headset/AR camera";formula="xr_pos=innerworld_map(phi_coords)";frequency_Hz=60.0;primitiveTrace="XR->Field->phi"},
            {useId="IN-02";useName="PARTICLES";latinUseName="PARTICULAE";description="Particle systems from swarm intelligence";renderTarget="GPU particle buffer";formula="particle=ant(phi_path,pheromone)";frequency_Hz=60.0;primitiveTrace="PARTICLES->Relation->phi"},
            {useId="IN-03";useName="LIGHTING";latinUseName="ILLUMINATIO_INTERAC";description="Real-time intelligence lighting — responds to organism";renderTarget="Real-time GI";formula="light_intensity=phi*heart_state";frequency_Hz=PHI;primitiveTrace="LIGHTING_IN->Field->phi"},
            {useId="IN-04";useName="ANIMATION";latinUseName="ANIMATIO_INTERAC";description="State-driven animation from organism state machine";renderTarget="Animator controller";formula="anim_state=organism_state(phi_blend)";frequency_Hz=PHI;primitiveTrace="ANIM_IN->Repetition->phi"},
            {useId="IN-05";useName="UI";latinUseName="INTERFACIES_INTERAC";description="Runtime UI with intelligence — every element is an agent";renderTarget="UI Canvas";formula="ui=intelligent_component(phi_layout)";frequency_Hz=60.0;primitiveTrace="UI_IN->Model->phi"},
        ];
        outputFormat="Real-time frame, XR output, Android/iOS/Web";
        frequency_Hz=60.0; primitiveTrace="MACHINA_INTERAC->Field->Relation->phi";
        wiredToFrontend=true; wiredToThreeHearts=true; isAlwaysOn=true;
    };

    // =========================================================================
    // REGISTRY
    // =========================================================================

    public let ALL_DESIGN_MODELS : [SovereignDesignModel] = [
        MACHINA_GPU, MACHINA_3D, MACHINA_PHOTO, MACHINA_INTERFAX, MACHINA_MOTUS,
        MACHINA_PROCEDIT, MACHINA_REALIS, MACHINA_MATERIA, MACHINA_COMPOSIT, MACHINA_INTERAC,
    ];

    public func getDesignModel(id: Text) : ?SovereignDesignModel {
        Array.find<SovereignDesignModel>(ALL_DESIGN_MODELS, func(m) { m.id == id })
    };

    public func getAlwaysOnModels() : [SovereignDesignModel] {
        Array.filter<SovereignDesignModel>(ALL_DESIGN_MODELS, func(m) { m.isAlwaysOn })
    };

    public func getFrontendModels() : [SovereignDesignModel] {
        Array.filter<SovereignDesignModel>(ALL_DESIGN_MODELS, func(m) { m.wiredToFrontend })
    };

    public func getUses(modelId: Text) : [SovereignUse] {
        switch (getDesignModel(modelId)) {
            case null { [] };
            case (?m) { m.uses };
        }
    };

    public func summary() : { totalModels: Nat; totalUses: Nat; alwaysOn: Nat; frontendWired: Nat; doctrine: Text } {
        var totalUses : Nat = 0;
        for (m in ALL_DESIGN_MODELS.vals()) { totalUses += m.uses.size() };
        { totalModels=ALL_DESIGN_MODELS.size(); totalUses=totalUses; alwaysOn=getAlwaysOnModels().size(); frontendWired=getFrontendModels().size(); doctrine=DOCTRINE }
    };

    public func renderManifest() : Text {
        var t = "SOVEREIGN DESIGN OS MANIFEST\n==================\n" # MOTTO # "\n\n";
        for (m in ALL_DESIGN_MODELS.vals()) {
            t #= m.id # "  " # m.name # "  [" # m.latinName # "]\n";
            t #= "  " # m.latinMotto # "\n  Source: " # m.sourceInspiration # "\n  Uses:\n";
            for (u in m.uses.vals()) {
                t #= "    " # u.useId # " " # u.useName # ": " # u.description # "\n";
                t #= "      Formula: " # u.formula # "\n";
            };
            t #= "\n";
        };
        t #= "ROOT: phi=(1+sqrt(5))/2=1.618033988749895\n";
        t
    };
}
