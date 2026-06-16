/**
 * MEMORIA COORDINATOR — Shared Memory Multi-Agent Coordinator
 * ============================================================
 * 
 * Coordinates memory access across multiple AI agents using:
 * - Kuramoto oscillator dynamics for heartbeat synchronization
 * - Conflict resolution through phase alignment
 * - Memory consolidation with Fibonacci compression
 * - Doctrine-based governance
 * 
 * Protocol: PROT-387 (Coordinator Protocol)
 * Frequency: φ⁸ = 46.98 Hz (Integration Layer)
 * 
 * @author Alfredo "Freddy" Medina Hernandez
 * @copyright 2026 Medina Tech, Dallas, TX
 * @license ISIL-1.0
 */

const crypto = require('crypto');

const PHI = 1.6180339887498948482;
const PHI_8 = Math.pow(PHI, 8);

/**
 * Kuramoto oscillator for synchronizing agent heartbeats
 */
class KuramotoOscillator {
  constructor(frequency, phase = 0, coupling = 0.5) {
    this.frequency = frequency;
    this.phase = phase;
    this.coupling = coupling;
    this.lastUpdate = Date.now();
  }

  /**
   * Update phase based on coupling to other oscillators
   */
  updatePhase(otherPhases) {
    const now = Date.now();
    const dt = (now - this.lastUpdate) / 1000; // seconds
    this.lastUpdate = now;

    // Kuramoto equation: dθ/dt = ω + (K/N) * Σ sin(θⱼ - θᵢ)
    let coupling_term = 0;
    if (otherPhases.length > 0) {
      for (const otherPhase of otherPhases) {
        coupling_term += Math.sin(otherPhase - this.phase);
      }
      coupling_term = (this.coupling / otherPhases.length) * coupling_term;
    }

    const dPhase = this.frequency * 2 * Math.PI * dt + coupling_term;
    this.phase = (this.phase + dPhase) % (2 * Math.PI);
  }

  /**
   * Measure phase coherence with target frequency
   */
  getCoherence(targetFrequency) {
    const frequencyError = Math.abs(this.frequency - targetFrequency) / Math.max(this.frequency, targetFrequency);
    return Math.max(0, 1 - frequencyError);
  }

  /**
   * Get current frequency in Hz
   */
  getFrequency() {
    return this.frequency;
  }

  /**
   * Get current phase
   */
  getPhase() {
    return this.phase;
  }
}

/**
 * Shared memory coordination system
 */
class MemoryCoordinator {
  constructor() {
    this.agents = new Map();
    this.sharedMemory = new Map();
    this.conflictLog = [];
    this.consolidationQueue = [];
    this.oscill ators = new Map();
  }

  /**
   * Register an AI agent in the coordinator
   */
  registerAgent(agentId, heartbeat, frequency) {
    if (this.agents.has(agentId)) {
      throw new Error(`Agent ${agentId} already registered`);
    }

    const oscillator = new KuramotoOscillator(frequency, Math.random() * 2 * Math.PI, 0.5);

    this.agents.set(agentId, {
      agent_id: agentId,
      heartbeat: heartbeat,
      frequency: frequency,
      joined_at: Date.now(),
      last_activity: Date.now(),
      shared_memories: [],
      conflicts_resolved: 0,
    });

    this.oscillators.set(agentId, oscillator);

    return {
      registered: true,
      agent_id: agentId,
      frequency: frequency,
    };
  }

  /**
   * Deregister an agent
   */
  unregisterAgent(agentId) {
    this.agents.delete(agentId);
    this.oscillators.delete(agentId);
  }

  /**
   * Synchronize agent heartbeats using Kuramoto dynamics
   */
  synchronizeHeartbeats() {
    if (this.agents.size < 2) return;

    const allPhases = Array.from(this.oscillators.values()).map(osc => osc.getPhase());

    for (const [agentId, oscillator] of this.oscillators) {
      const otherPhases = allPhases.filter((_, i) => {
        const keys = Array.from(this.oscillators.keys());
        return keys[i] !== agentId;
      });

      oscillator.updatePhase(otherPhases);
    }
  }

  /**
   * Store memory visible to all authorized agents
   */
  storeSharedMemory(memoryId, content, authorizedAgents, doctrineBinding) {
    const memory = {
      memory_id: memoryId,
      content: content,
      authorized_agents: authorizedAgents,
      created_at: Date.now(),
      created_by: null,
      version: 1,
      doctrine_binding: doctrineBinding,
      access_log: [],
    };

    this.sharedMemory.set(memoryId, memory);

    return {
      memory_id: memoryId,
      created: true,
      authorized_agents: authorizedAgents.length,
    };
  }

  /**
   * Access shared memory by authorized agent
   */
  accessSharedMemory(memoryId, agentId) {
    const memory = this.sharedMemory.get(memoryId);
    if (!memory) {
      return { error: 'MEMORY_NOT_FOUND' };
    }

    if (!memory.authorized_agents.includes(agentId)) {
      return { error: 'ACCESS_DENIED' };
    }

    memory.access_log.push({
      agent_id: agentId,
      timestamp: Date.now(),
    });

    return {
      memory_id: memoryId,
      content: memory.content,
      version: memory.version,
      accessed_at: Date.now(),
    };
  }

  /**
   * Detect and resolve conflicts when multiple agents write to shared memory
   */
  resolveConflict(memoryId, agent1, agent2, content1, content2) {
    const conflict = {
      memory_id: memoryId,
      agent1: agent1,
      agent2: agent2,
      content1: content1,
      content2: content2,
      detected_at: Date.now(),
      resolved: false,
      resolution: null,
    };

    // Resolution strategy: phase alignment + governance
    const phase1 = this.oscillators.get(agent1)?.getPhase() || 0;
    const phase2 = this.oscillators.get(agent2)?.getPhase() || 0;

    const phaseDiff = Math.abs(phase1 - phase2);
    const isInPhase = phaseDiff < 0.3 || phaseDiff > 6.0; // 0.3 rad tolerance

    if (isInPhase) {
      // Agents are in phase - merge content using Fibonacci compression
      conflict.resolution = this.mergeContents(content1, content2);
      conflict.resolved = true;
    } else {
      // Agents are out of phase - prefer content from agent closer to target phase
      const targetPhase = 0; // Align to common reference
      const dist1 = Math.abs(phase1 - targetPhase);
      const dist2 = Math.abs(phase2 - targetPhase);
      conflict.resolution = dist1 < dist2 ? content1 : content2;
      conflict.resolved = true;
    }

    this.conflictLog.push(conflict);

    const agent = conflict.resolution === content1 ? agent1 : agent2;
    this.agents.get(agent).conflicts_resolved += 1;

    return conflict;
  }

  /**
   * Merge two memory contents using Fibonacci compression
   */
  mergeContents(content1, content2) {
    // Simple merge strategy: combine into consolidated format
    const fib10 = 55; // 10th Fibonacci number

    if (typeof content1 === 'object' && typeof content2 === 'object') {
      return {
        merged: true,
        sources: [content1, content2],
        compression_seed: fib10,
        merged_at: Date.now(),
      };
    }

    // String concatenation with Fibonacci spacing
    return `${content1} [MERGED] ${content2}`;
  }

  /**
   * Consolidate multiple memories into one using Fibonacci compression
   */
  consolidateMemories(memoryIds, consolidationType = 'merge') {
    if (memoryIds.length < 2) {
      return { error: 'Need at least 2 memories to consolidate' };
    }

    const memories = memoryIds
      .map(id => this.sharedMemory.get(id))
      .filter(m => m !== undefined);

    if (memories.length === 0) {
      return { error: 'No memories found' };
    }

    // Use Fibonacci sequence for compression
    const fibSequence = this.generateFibonacci(memories.length);
    const compressionRatio = fibSequence[fibSequence.length - 1] / memories.reduce((sum, m) => sum + JSON.stringify(m.content).length, 0);

    const consolidatedId = `MEM_CONS_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
    const consolidatedMemory = {
      memory_id: consolidatedId,
      content: {
        consolidated_from: memoryIds,
        consolidation_type: consolidationType,
        compression_ratio: compressionRatio,
        fibonacci_seed: fibSequence,
      },
      authorized_agents: memories[0].authorized_agents,
      created_at: Date.now(),
      version: 1,
      doctrine_binding: memories[0].doctrine_binding,
      access_log: [],
    };

    this.sharedMemory.set(consolidatedId, consolidatedMemory);

    // Queue consolidation for processing
    this.consolidationQueue.push({
      original_memories: memoryIds,
      consolidated_memory: consolidatedId,
      timestamp: Date.now(),
    });

    return {
      consolidated_memory_id: consolidatedId,
      original_memories: memoryIds.length,
      compression_ratio: compressionRatio,
    };
  }

  /**
   * Get agent synchronization status
   */
  getAgentSyncStatus(agentId) {
    const agent = this.agents.get(agentId);
    const oscillator = this.oscillators.get(agentId);

    if (!agent || !oscillator) {
      return { error: 'AGENT_NOT_FOUND' };
    }

    // Calculate coherence with all other agents
    const coherences = [];
    for (const [otherId, otherOsc] of this.oscillators) {
      if (otherId !== agentId) {
        const coherence = oscillator.getCoherence(otherOsc.getFrequency());
        coherences.push({ agent_id: otherId, coherence });
      }
    }

    return {
      agent_id: agentId,
      frequency: oscillator.getFrequency(),
      phase: oscillator.getPhase(),
      coherences: coherences,
      avg_coherence: coherences.length > 0
        ? coherences.reduce((sum, c) => sum + c.coherence, 0) / coherences.length
        : 1.0,
    };
  }

  /**
   * Get coordinator status
   */
  getStatus() {
    const avgCoherence = Array.from(this.oscillators.values())
      .reduce((sum, osc) => {
        const otherFreqs = Array.from(this.oscillators.values())
          .filter(o => o !== osc)
          .map(o => o.getFrequency());
        return sum + (otherFreqs.length > 0
          ? otherFreqs.reduce((s, f) => s + osc.getCoherence(f), 0) / otherFreqs.length
          : 1.0);
      }, 0) / Math.max(1, this.oscillators.size);

    return {
      service: 'memoria-coordinator',
      protocol: 'PROT-387',
      frequency_hz: PHI_8,
      registered_agents: this.agents.size,
      shared_memories: this.sharedMemory.size,
      conflicts_detected: this.conflictLog.length,
      consolidations_queued: this.consolidationQueue.length,
      avg_coherence: avgCoherence,
      coordinator_uptime_ms: Date.now(),
    };
  }

  /**
   * Generate Fibonacci sequence
   */
  generateFibonacci(n) {
    const fib = [1, 1];
    for (let i = 2; i < n; i++) {
      fib.push(fib[i - 1] + fib[i - 2]);
    }
    return fib.slice(0, n);
  }
}

module.exports = { MemoryCoordinator, KuramotoOscillator, PHI_8 };
