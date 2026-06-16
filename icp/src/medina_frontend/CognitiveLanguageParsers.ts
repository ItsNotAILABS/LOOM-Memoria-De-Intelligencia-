/**
 * ╔══════════════════════════════════════════════════════════════════════════════════╗
 * ║                    MEDINA — PROPRIETARY AND CONFIDENTIAL                        ║
 * ║  Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA          ║
 * ║  ALL RIGHTS RESERVED.                                                            ║
 * ╚══════════════════════════════════════════════════════════════════════════════════╝
 *
 * CognitiveLanguageParsers.ts — Frontend Parsers for Phase 2 Languages
 *
 * Implements parsers for CDL, OCL, ACL, RSL — the four parser/communication
 * languages in Phase 2 of the Cognitive Language Stack.
 *
 * Each parser:
 *   1. Tokenizes input into language primitives
 *   2. Validates against grammar rules
 *   3. Produces a typed AST node
 *   4. Computes SCC for all identifiers
 *
 * PROT-118 (CDL), PROT-119 (OCL), PROT-120 (ACL), PROT-121 (RSL)
 */

// ═══════════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════════

export const PHI = 1.6180339887;
export const PHI_SQUARED = PHI * PHI;

// ═══════════════════════════════════════════════════════════════════════════════
// TYPES
// ═══════════════════════════════════════════════════════════════════════════════

export type LanguageId = 'CDL' | 'OCL' | 'ACL' | 'RSL';

export interface Token {
  type: 'PRIMITIVE' | 'IDENTIFIER' | 'NUMBER' | 'STRING' | 'OPERATOR' | 'WHITESPACE' | 'UNKNOWN';
  value: string;
  position: number;
}

export interface ASTNode {
  language: LanguageId;
  primitive: string;
  arguments: ASTArgument[];
  scc?: number;
  phiOptimal?: boolean;
  raw: string;
}

export interface ASTArgument {
  type: 'identifier' | 'number' | 'string';
  value: string | number;
  scc?: number;
}

export interface ParseResult {
  success: boolean;
  language: LanguageId;
  ast?: ASTNode;
  tokens?: Token[];
  error?: string;
}

export interface SCCResult {
  name: string;
  chars: number;
  semanticWeight: number;
  scc: number;
  phiOptimal: boolean;
  threshold: number;
}

// ═══════════════════════════════════════════════════════════════════════════════
// GRAMMAR DEFINITIONS
// ═══════════════════════════════════════════════════════════════════════════════

const GRAMMARS: Record<LanguageId, Record<string, string>> = {
  CDL: {
    DEFINE: 'Create new typed schema with SCC annotation',
    CONSTRAIN: 'Attach logical predicate to field',
    EVOLVE: 'Specify schema version migration',
    VALIDATE: 'Verify instance against schema + SCC',
    COMPOSE: 'Combine schemas into composite structure',
  },
  OCL: {
    MESSAGE: 'Compose typed inter-organism message',
    BROADCAST: 'Send to multiple organisms with coherence floor',
    ROUTE: 'Direct message via taxonomy-aware pathways',
    SUBSCRIBE: 'Register for organism event stream',
    COHERE: 'Assert minimum resonance for communication',
  },
  ACL: {
    INFORM: 'Share knowledge with target agent',
    REQUEST: 'Ask agent to perform action',
    PROPOSE: 'Offer terms for negotiation',
    DELEGATE: 'Assign task to subordinate house agent',
    NEGOTIATE: 'Multi-turn structured dialogue sequence',
  },
  RSL: {
    FREQUENCY: 'Define operating frequency with tolerance',
    RESONATE: 'Specify phase coupling between entities',
    HARMONIZE: 'Align multiple frequencies to harmonic series',
    PULSE: 'Define rhythmic timing pattern',
    SPECTRUM: 'Declare full frequency band allocation',
  },
};

// ═══════════════════════════════════════════════════════════════════════════════
// TOKENIZER
// ═══════════════════════════════════════════════════════════════════════════════

export function tokenize(input: string, language: LanguageId): Token[] {
  const tokens: Token[] = [];
  const primitiveNames = Object.keys(GRAMMARS[language]);
  let pos = 0;
  const src = input.trim();

  while (pos < src.length) {
    // Skip whitespace
    if (/\s/.test(src[pos])) {
      const start = pos;
      while (pos < src.length && /\s/.test(src[pos])) pos++;
      tokens.push({ type: 'WHITESPACE', value: src.slice(start, pos), position: start });
      continue;
    }

    // String literal
    if (src[pos] === '"' || src[pos] === "'") {
      const quote = src[pos];
      const start = pos;
      pos++;
      while (pos < src.length && src[pos] !== quote) pos++;
      if (pos < src.length) pos++; // closing quote
      tokens.push({ type: 'STRING', value: src.slice(start, pos), position: start });
      continue;
    }

    // Number
    if (/[0-9]/.test(src[pos]) || (src[pos] === '-' && pos + 1 < src.length && /[0-9]/.test(src[pos + 1]))) {
      const start = pos;
      if (src[pos] === '-') pos++;
      while (pos < src.length && /[0-9.]/.test(src[pos])) pos++;
      tokens.push({ type: 'NUMBER', value: src.slice(start, pos), position: start });
      continue;
    }

    // Word (primitive or identifier)
    if (/[A-Za-z_]/.test(src[pos])) {
      const start = pos;
      while (pos < src.length && /[A-Za-z0-9_]/.test(src[pos])) pos++;
      const word = src.slice(start, pos);
      const isPrimitive = primitiveNames.includes(word);
      tokens.push({
        type: isPrimitive ? 'PRIMITIVE' : 'IDENTIFIER',
        value: word,
        position: start,
      });
      continue;
    }

    // Operator
    if (/[=<>!+\-*/&|^~%(){}[\],;:]/.test(src[pos])) {
      tokens.push({ type: 'OPERATOR', value: src[pos], position: pos });
      pos++;
      continue;
    }

    // Unknown
    tokens.push({ type: 'UNKNOWN', value: src[pos], position: pos });
    pos++;
  }

  return tokens;
}

// ═══════════════════════════════════════════════════════════════════════════════
// SCC VALIDATOR
// ═══════════════════════════════════════════════════════════════════════════════

export function computeSCC(name: string, semanticWeight: number): SCCResult {
  const chars = name.length;
  const scc = chars > 0 ? semanticWeight / chars : 0;
  return {
    name,
    chars,
    semanticWeight,
    scc,
    phiOptimal: scc >= PHI_SQUARED,
    threshold: PHI_SQUARED,
  };
}

// ═══════════════════════════════════════════════════════════════════════════════
// PARSERS
// ═══════════════════════════════════════════════════════════════════════════════

function parseExpression(language: LanguageId, input: string): ParseResult {
  const tokens = tokenize(input, language).filter(t => t.type !== 'WHITESPACE');

  if (tokens.length === 0) {
    return { success: false, language, error: 'Empty expression' };
  }

  const firstToken = tokens[0];
  if (firstToken.type !== 'PRIMITIVE') {
    return {
      success: false,
      language,
      tokens,
      error: `Expected primitive keyword, got '${firstToken.value}'. Valid primitives: ${Object.keys(GRAMMARS[language]).join(', ')}`,
    };
  }

  const args: ASTArgument[] = [];
  for (let i = 1; i < tokens.length; i++) {
    const t = tokens[i];
    switch (t.type) {
      case 'IDENTIFIER':
        args.push({ type: 'identifier', value: t.value });
        break;
      case 'NUMBER':
        args.push({ type: 'number', value: parseFloat(t.value) });
        break;
      case 'STRING':
        args.push({ type: 'string', value: t.value.slice(1, -1) });
        break;
      default:
        // Skip operators and other tokens for now
        break;
    }
  }

  const ast: ASTNode = {
    language,
    primitive: firstToken.value,
    arguments: args,
    raw: input,
  };

  return { success: true, language, ast, tokens };
}

// ═══════════════════════════════════════════════════════════════════════════════
// CDL PARSER — Cognitive Definition Language (PROT-118)
// ═══════════════════════════════════════════════════════════════════════════════

export class CDLParser {
  readonly language: LanguageId = 'CDL';
  readonly protocolId = 'PROT-118';
  readonly sovereignId = 'SOVEREIGN::LANG::CDL';

  parse(input: string): ParseResult {
    return parseExpression('CDL', input);
  }

  tokenize(input: string): Token[] {
    return tokenize(input, 'CDL');
  }

  getPrimitives(): Record<string, string> {
    return { ...GRAMMARS.CDL };
  }

  validateSCC(name: string, weight: number): SCCResult {
    return computeSCC(name, weight);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// OCL PARSER — Organism Communication Language (PROT-119)
// ═══════════════════════════════════════════════════════════════════════════════

export class OCLParser {
  readonly language: LanguageId = 'OCL';
  readonly protocolId = 'PROT-119';
  readonly sovereignId = 'SOVEREIGN::LANG::OCL';

  parse(input: string): ParseResult {
    return parseExpression('OCL', input);
  }

  tokenize(input: string): Token[] {
    return tokenize(input, 'OCL');
  }

  getPrimitives(): Record<string, string> {
    return { ...GRAMMARS.OCL };
  }

  /** Validate resonance coherence threshold */
  validateCoherence(resonance: number): boolean {
    return resonance >= (1 / PHI); // r ≥ φ⁻¹ ≈ 0.618
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACL PARSER — Agent Communication Language (PROT-120)
// ═══════════════════════════════════════════════════════════════════════════════

export class ACLParser {
  readonly language: LanguageId = 'ACL';
  readonly protocolId = 'PROT-120';
  readonly sovereignId = 'SOVEREIGN::LANG::ACL';

  parse(input: string): ParseResult {
    return parseExpression('ACL', input);
  }

  tokenize(input: string): Token[] {
    return tokenize(input, 'ACL');
  }

  getPrimitives(): Record<string, string> {
    return { ...GRAMMARS.ACL };
  }

  /** Check if a performative is valid */
  isValidPerformative(name: string): boolean {
    return name in GRAMMARS.ACL;
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// RSL PARSER — Resonance Specification Language (PROT-121)
// ═══════════════════════════════════════════════════════════════════════════════

export class RSLParser {
  readonly language: LanguageId = 'RSL';
  readonly protocolId = 'PROT-121';
  readonly sovereignId = 'SOVEREIGN::LANG::RSL';

  /** Solfeggio frequencies */
  static readonly SOLFEGGIO = [174, 285, 396, 417, 528, 639, 741, 852, 963];

  /** Schumann resonance */
  static readonly SCHUMANN = 7.83;

  parse(input: string): ParseResult {
    return parseExpression('RSL', input);
  }

  tokenize(input: string): Token[] {
    return tokenize(input, 'RSL');
  }

  getPrimitives(): Record<string, string> {
    return { ...GRAMMARS.RSL };
  }

  /** Check if frequency is in valid organism range (0.01-900Hz) */
  isValidFrequency(hz: number): boolean {
    return hz >= 0.01 && hz <= 900;
  }

  /** Find nearest Solfeggio frequency */
  nearestSolfeggio(hz: number): number {
    let nearest = RSLParser.SOLFEGGIO[0];
    let minDist = Math.abs(hz - nearest);
    for (const s of RSLParser.SOLFEGGIO) {
      const dist = Math.abs(hz - s);
      if (dist < minDist) {
        minDist = dist;
        nearest = s;
      }
    }
    return nearest;
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// UNIFIED PARSER INTERFACE
// ═══════════════════════════════════════════════════════════════════════════════

export class CognitiveLanguageParser {
  private cdl = new CDLParser();
  private ocl = new OCLParser();
  private acl = new ACLParser();
  private rsl = new RSLParser();

  parse(language: LanguageId, input: string): ParseResult {
    switch (language) {
      case 'CDL': return this.cdl.parse(input);
      case 'OCL': return this.ocl.parse(input);
      case 'ACL': return this.acl.parse(input);
      case 'RSL': return this.rsl.parse(input);
    }
  }

  getParser(language: LanguageId): CDLParser | OCLParser | ACLParser | RSLParser {
    switch (language) {
      case 'CDL': return this.cdl;
      case 'OCL': return this.ocl;
      case 'ACL': return this.acl;
      case 'RSL': return this.rsl;
    }
  }

  getAllLanguages(): LanguageId[] {
    return ['CDL', 'OCL', 'ACL', 'RSL'];
  }

  validateSCC(name: string, weight: number): SCCResult {
    return computeSCC(name, weight);
  }
}
