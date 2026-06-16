/**
 * ANIMUS ENGINE — FRONTEND INTERFACE
 * ISIL-1.0 Licensed — HIGHEST CONFIDENTIALITY — SOVEREIGN-ALPHA
 *
 * TypeScript interface for ANIMUS (Cascade Orchestration & Perpetual Delivery)
 *
 * Latin: "Animus" = Soul, Mind, Life-Force
 * Motto: "Perpetuo Fluit, Perpetuo Creat" (Forever Flows, Forever Creates)
 *
 * Three Sub-Engines:
 * 1. CASCADE ENGINE — Bootstrap orchestration
 * 2. ARTIFACT ENGINE — Internal work generation
 * 3. DELIVERY ENGINE — Delivery flow management
 *
 * © 2024-2026 Alfredo "Freddy" Medina Hernandez | Medina Tech
 */

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS & PRIMITIVES
// ═══════════════════════════════════════════════════════════════════════════

export const PHI = 1.618033988749895;
export const PHI_SQ = 2.618033988749895;
export const PHI_CUBED = 4.236067977499790;

export const LATIN_NAME = "ANIMUS";
export const LATIN_MOTTO = "Perpetuo Fluit, Perpetuo Creat";
export const LATIN_MOTTO_EN = "Forever Flows, Forever Creates";

export const VERSION = "1.0.0";
export const CLASSIFICATION = "SOVEREIGN-ALPHA";
export const LICENSE = "ISIL-1.0";

export const HEARTBEAT_HZ = PHI;
export const HEARTBEAT_MS = 1000 / PHI;

// ═══════════════════════════════════════════════════════════════════════════
// TYPES — CASCADE ENGINE
// ═══════════════════════════════════════════════════════════════════════════

export enum BootstrapLevel {
  Core = "Core",
  Product = "Product",
  Service = "Service",
  Division = "Division",
}

export enum CascadeStatus {
  Created = "Created",
  Bootstrapping = "Bootstrapping",
  Running = "Running",
  Paused = "Paused",
  Failed = "Failed",
}

export interface NodeConfig {
  memory_space: string;
  gate_level: string;
  monitoring: boolean;
  auto_restart: boolean;
}

export interface CascadeNode {
  id: string;
  name: string;
  level: BootstrapLevel;
  parent: string | null;
  status: CascadeStatus;
  heartbeat_hz: number;
  beat_count: number;
  started_at: number;
  last_beat: number;
  config: NodeConfig;
}

export interface BootstrapResult {
  success: boolean;
  node_id: string;
  message: string;
  timestamp: number;
}

// ═══════════════════════════════════════════════════════════════════════════
// TYPES — ARTIFACT ENGINE
// ═══════════════════════════════════════════════════════════════════════════

export enum ArtifactType {
  DailyReport = "DailyReport",
  WeeklyReport = "WeeklyReport",
  ManagerReport = "ManagerReport",
  Analytics = "Analytics",
  Metrics = "Metrics",
  HealthCheck = "HealthCheck",
  Custom = "Custom",
}

export interface ArtifactMetadata {
  word_count: number;
  scc_score: number;
  frequency: string;
  parent_node: string | null;
}

export interface Artifact {
  id: string;
  artifact_type: ArtifactType;
  title: string;
  content: string;
  author: string;
  classification: string;
  created_at: number;
  beat_count: number;
  metadata: ArtifactMetadata;
}

// ═══════════════════════════════════════════════════════════════════════════
// TYPES — DELIVERY ENGINE
// ═══════════════════════════════════════════════════════════════════════════

export enum DeliveryChannel {
  Internal = "Internal",
  Slack = "Slack",
  Email = "Email",
  Webhook = "Webhook",
  Custom = "Custom",
}

export enum DeliveryStatus {
  Queued = "Queued",
  Sending = "Sending",
  Delivered = "Delivered",
  Failed = "Failed",
}

export interface DeliveryMetadata {
  retry_count: number;
  priority: number;
  artifact_id: string | null;
}

export interface Delivery {
  id: string;
  channel: DeliveryChannel;
  content: string;
  recipient: string;
  sender: string;
  delivered_at: number;
  status: DeliveryStatus;
  metadata: DeliveryMetadata;
}

// ═══════════════════════════════════════════════════════════════════════════
// TYPES — STATE
// ═══════════════════════════════════════════════════════════════════════════

export interface AnimusState {
  beat_count: number;
  started_at: number;
  last_beat: number;
  cascade_nodes: CascadeNode[];
  artifacts: Artifact[];
  deliveries: Delivery[];
}

export interface AnimusIdentity {
  name: string;
  version: string;
  classification: string;
  license: string;
  latinName: string;
  latinMotto: string;
  latinMottoEN: string;
  primitiveTrace: string;
  frequency_Hz: number;
}

// ═══════════════════════════════════════════════════════════════════════════
// CASCADE ENGINE CLIENT
// ═══════════════════════════════════════════════════════════════════════════

export class CascadeEngineClient {
  private backend: any;

  constructor(backend: any) {
    this.backend = backend;
  }

  async bootstrapNode(
    name: string,
    level: BootstrapLevel,
    parent: string | null,
    config: NodeConfig
  ): Promise<BootstrapResult> {
    try {
      const result = await this.backend.animus_bootstrap_node(
        name,
        level,
        parent ? [parent] : [],
        config
      );
      return result;
    } catch (error) {
      console.error("CASCADE ENGINE: Bootstrap failed", error);
      throw error;
    }
  }

  async updateNodeStatus(nodeId: string, status: CascadeStatus): Promise<boolean> {
    try {
      return await this.backend.animus_update_node_status(nodeId, status);
    } catch (error) {
      console.error("CASCADE ENGINE: Update status failed", error);
      return false;
    }
  }

  async beatNode(nodeId: string): Promise<boolean> {
    try {
      return await this.backend.animus_beat_node(nodeId);
    } catch (error) {
      console.error("CASCADE ENGINE: Beat node failed", error);
      return false;
    }
  }

  async getCascadeTree(): Promise<CascadeNode[]> {
    try {
      return await this.backend.animus_get_cascade_tree();
    } catch (error) {
      console.error("CASCADE ENGINE: Get cascade tree failed", error);
      return [];
    }
  }

  async getNode(nodeId: string): Promise<CascadeNode | null> {
    try {
      const result = await this.backend.animus_get_node(nodeId);
      return result.length > 0 ? result[0] : null;
    } catch (error) {
      console.error("CASCADE ENGINE: Get node failed", error);
      return null;
    }
  }

  async getNodesByLevel(level: BootstrapLevel): Promise<CascadeNode[]> {
    try {
      return await this.backend.animus_get_nodes_by_level(level);
    } catch (error) {
      console.error("CASCADE ENGINE: Get nodes by level failed", error);
      return [];
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ARTIFACT ENGINE CLIENT
// ═══════════════════════════════════════════════════════════════════════════

export class ArtifactEngineClient {
  private backend: any;

  constructor(backend: any) {
    this.backend = backend;
  }

  async generateArtifact(
    artifactType: ArtifactType,
    title: string,
    content: string,
    author: string,
    beatCount: number
  ): Promise<Artifact> {
    try {
      return await this.backend.animus_generate_artifact(
        artifactType,
        title,
        content,
        author,
        beatCount
      );
    } catch (error) {
      console.error("ARTIFACT ENGINE: Generate failed", error);
      throw error;
    }
  }

  async getArtifact(artifactId: string): Promise<Artifact | null> {
    try {
      const result = await this.backend.animus_get_artifact(artifactId);
      return result.length > 0 ? result[0] : null;
    } catch (error) {
      console.error("ARTIFACT ENGINE: Get artifact failed", error);
      return null;
    }
  }

  async getAllArtifacts(): Promise<Artifact[]> {
    try {
      return await this.backend.animus_get_all_artifacts();
    } catch (error) {
      console.error("ARTIFACT ENGINE: Get all artifacts failed", error);
      return [];
    }
  }

  async getArtifactsByType(artifactType: ArtifactType): Promise<Artifact[]> {
    try {
      return await this.backend.animus_get_artifacts_by_type(artifactType);
    } catch (error) {
      console.error("ARTIFACT ENGINE: Get artifacts by type failed", error);
      return [];
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DELIVERY ENGINE CLIENT
// ═══════════════════════════════════════════════════════════════════════════

export class DeliveryEngineClient {
  private backend: any;

  constructor(backend: any) {
    this.backend = backend;
  }

  async deliver(
    channel: DeliveryChannel,
    content: string,
    recipient: string,
    sender: string,
    artifactId: string | null
  ): Promise<Delivery> {
    try {
      return await this.backend.animus_deliver(
        channel,
        content,
        recipient,
        sender,
        artifactId ? [artifactId] : []
      );
    } catch (error) {
      console.error("DELIVERY ENGINE: Deliver failed", error);
      throw error;
    }
  }

  async updateDeliveryStatus(deliveryId: string, status: DeliveryStatus): Promise<boolean> {
    try {
      return await this.backend.animus_update_delivery_status(deliveryId, status);
    } catch (error) {
      console.error("DELIVERY ENGINE: Update status failed", error);
      return false;
    }
  }

  async getDelivery(deliveryId: string): Promise<Delivery | null> {
    try {
      const result = await this.backend.animus_get_delivery(deliveryId);
      return result.length > 0 ? result[0] : null;
    } catch (error) {
      console.error("DELIVERY ENGINE: Get delivery failed", error);
      return null;
    }
  }

  async getAllDeliveries(): Promise<Delivery[]> {
    try {
      return await this.backend.animus_get_all_deliveries();
    } catch (error) {
      console.error("DELIVERY ENGINE: Get all deliveries failed", error);
      return [];
    }
  }

  async getDeliveriesByChannel(channel: DeliveryChannel): Promise<Delivery[]> {
    try {
      return await this.backend.animus_get_deliveries_by_channel(channel);
    } catch (error) {
      console.error("DELIVERY ENGINE: Get deliveries by channel failed", error);
      return [];
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN ANIMUS CLIENT
// ═══════════════════════════════════════════════════════════════════════════

export class AnimusClient {
  public cascadeEngine: CascadeEngineClient;
  public artifactEngine: ArtifactEngineClient;
  public deliveryEngine: DeliveryEngineClient;

  private backend: any;
  private beatInterval: number | null = null;

  constructor(backend: any) {
    this.backend = backend;
    this.cascadeEngine = new CascadeEngineClient(backend);
    this.artifactEngine = new ArtifactEngineClient(backend);
    this.deliveryEngine = new DeliveryEngineClient(backend);
  }

  // Start ANIMUS heartbeat
  startHeartbeat(onBeat?: (beatCount: number) => void): void {
    if (this.beatInterval !== null) {
      console.warn("ANIMUS heartbeat already running");
      return;
    }

    this.beatInterval = window.setInterval(async () => {
      try {
        const beatCount = await this.beat();
        if (onBeat) {
          onBeat(beatCount);
        }
      } catch (error) {
        console.error("ANIMUS heartbeat failed", error);
      }
    }, HEARTBEAT_MS);

    console.log(`ANIMUS heartbeat started at φ Hz (${HEARTBEAT_HZ.toFixed(3)} beats/sec)`);
  }

  // Stop ANIMUS heartbeat
  stopHeartbeat(): void {
    if (this.beatInterval !== null) {
      clearInterval(this.beatInterval);
      this.beatInterval = null;
      console.log("ANIMUS heartbeat stopped");
    }
  }

  // Send a single beat
  async beat(): Promise<number> {
    try {
      return await this.backend.animus_beat();
    } catch (error) {
      console.error("ANIMUS beat failed", error);
      throw error;
    }
  }

  // Get ANIMUS status
  async getStatus(): Promise<string> {
    try {
      return await this.backend.animus_get_status();
    } catch (error) {
      console.error("ANIMUS get status failed", error);
      return "ERROR";
    }
  }

  // Get full state
  async getState(): Promise<AnimusState> {
    try {
      return await this.backend.animus_get_state();
    } catch (error) {
      console.error("ANIMUS get state failed", error);
      throw error;
    }
  }

  // Get identity
  async getIdentity(): Promise<string> {
    try {
      return await this.backend.animus_get_identity();
    } catch (error) {
      console.error("ANIMUS get identity failed", error);
      return "ANIMUS (Unknown)";
    }
  }

  // Get structured identity
  getIdentityInfo(): AnimusIdentity {
    return {
      name: LATIN_NAME,
      version: VERSION,
      classification: CLASSIFICATION,
      license: LICENSE,
      latinName: LATIN_NAME,
      latinMotto: LATIN_MOTTO,
      latinMottoEN: LATIN_MOTTO_EN,
      primitiveTrace: "ANIMUS → Cascade → Artifact → Delivery → φ",
      frequency_Hz: HEARTBEAT_HZ,
    };
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// EXPORTS
// ═══════════════════════════════════════════════════════════════════════════

export default AnimusClient;
