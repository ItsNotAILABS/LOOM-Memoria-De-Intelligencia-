/**
 * EVOLUTIO OPERANS — Operating Evolution Worker
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 *
 * Permanent, always-on Web Worker for evolutionary / genetic algorithm
 * computation: mutation, fitness, crossover, selection, full evolution runs.
 * 873ms heartbeat cycle. Pure vanilla JS, no imports.
 */

const NAME = 'EVOLUTIO OPERANS';
const BOOT_TIME = Date.now();
let beat = 0;
let generations = 0;

var CHARSET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,!?-';

function randomChar() {
  return CHARSET[Math.floor(Math.random() * CHARSET.length)];
}

function randomGenome(length) {
  var g = '';
  for (var i = 0; i < length; i++) g += randomChar();
  return g;
}

function mutate(genome, rate) {
  var r = typeof rate === 'number' ? Math.max(0, Math.min(1, rate)) : 0.01;
  var result = '';
  var mutations = 0;
  for (var i = 0; i < genome.length; i++) {
    if (Math.random() < r) {
      result += randomChar();
      mutations++;
    } else {
      result += genome[i];
    }
  }
  return {
    original: genome,
    mutated: result,
    rate: r,
    mutationCount: mutations,
    length: genome.length,
    changeRatio: genome.length > 0 ? Math.round((mutations / genome.length) * 10000) / 10000 : 0
  };
}

function fitness(genome, target) {
  var g = String(genome);
  var t = String(target);
  var len = Math.max(g.length, t.length);
  if (len === 0) return { score: 1, matches: 0, length: 0 };
  var matches = 0;
  for (var i = 0; i < len; i++) {
    if (i < g.length && i < t.length && g[i] === t[i]) matches++;
  }
  var lengthPenalty = Math.abs(g.length - t.length) / len;
  var score = (matches / len) - (lengthPenalty * 0.5);
  return {
    score: Math.round(Math.max(0, score) * 10000) / 10000,
    matches: matches,
    length: len,
    genomeLength: g.length,
    targetLength: t.length,
    lengthPenalty: Math.round(lengthPenalty * 10000) / 10000
  };
}

function crossover(parent1, parent2) {
  var p1 = String(parent1);
  var p2 = String(parent2);
  var minLen = Math.min(p1.length, p2.length);
  if (minLen < 2) return { child1: p2, child2: p1, crossoverPoint: 0 };
  var point = Math.floor(Math.random() * (minLen - 1)) + 1;
  var child1 = p1.substring(0, point) + p2.substring(point);
  var child2 = p2.substring(0, point) + p1.substring(point);
  return {
    parent1: p1,
    parent2: p2,
    child1: child1,
    child2: child2,
    crossoverPoint: point,
    child1Length: child1.length,
    child2Length: child2.length
  };
}

function tournamentSelect(population, fitnesses, tournamentSize) {
  var size = tournamentSize || 3;
  var bestIdx = -1;
  var bestFit = -Infinity;
  for (var i = 0; i < size; i++) {
    var idx = Math.floor(Math.random() * population.length);
    if (fitnesses[idx] > bestFit) {
      bestFit = fitnesses[idx];
      bestIdx = idx;
    }
  }
  return { selected: population[bestIdx], index: bestIdx, fitness: bestFit };
}

function selectHandler(population, fitnesses) {
  if (!Array.isArray(population) || !Array.isArray(fitnesses)) {
    return { error: 'Provide population and fitnesses arrays' };
  }
  if (population.length !== fitnesses.length) {
    return { error: 'Population and fitnesses must be same length' };
  }
  var result = tournamentSelect(population, fitnesses, 3);
  return {
    selected: result.selected,
    index: result.index,
    fitness: result.fitness,
    populationSize: population.length,
    method: 'tournament-3'
  };
}

function evolve(population, target, numGenerations) {
  var tgt = String(target);
  var maxGens = Math.min(Math.max(Math.floor(Number(numGenerations)) || 50, 1), 500);
  var popSize = 0;
  var pop = [];

  if (Array.isArray(population) && population.length > 0) {
    pop = population.map(String);
    popSize = pop.length;
  } else {
    popSize = Math.min(Math.max(Math.floor(Number(population)) || 20, 4), 200);
    for (var i = 0; i < popSize; i++) {
      pop.push(randomGenome(tgt.length));
    }
  }

  var mutationRate = 0.02;
  var eliteCount = Math.max(1, Math.floor(popSize * 0.1));
  var history = [];

  for (var gen = 0; gen < maxGens; gen++) {
    generations++;
    var scored = pop.map(function (g) {
      var f = fitness(g, tgt);
      return { genome: g, score: f.score };
    });
    scored.sort(function (a, b) { return b.score - a.score; });

    var bestScore = scored[0].score;
    var avgScore = scored.reduce(function (s, x) { return s + x.score; }, 0) / scored.length;

    if (gen % Math.max(1, Math.floor(maxGens / 10)) === 0 || gen === maxGens - 1 || bestScore >= 1) {
      history.push({
        generation: gen,
        bestScore: Math.round(bestScore * 10000) / 10000,
        avgScore: Math.round(avgScore * 10000) / 10000,
        bestGenome: scored[0].genome
      });
    }

    if (bestScore >= 1) break;

    var newPop = [];
    for (var e = 0; e < eliteCount; e++) newPop.push(scored[e].genome);

    var fitnesses = scored.map(function (s) { return s.score; });
    var genomes = scored.map(function (s) { return s.genome; });

    while (newPop.length < popSize) {
      var p1 = tournamentSelect(genomes, fitnesses, 3);
      var p2 = tournamentSelect(genomes, fitnesses, 3);
      var children = crossover(p1.selected, p2.selected);
      var c1 = mutate(children.child1, mutationRate);
      newPop.push(c1.mutated);
      if (newPop.length < popSize) {
        var c2 = mutate(children.child2, mutationRate);
        newPop.push(c2.mutated);
      }
    }
    pop = newPop;
  }

  var finalScored = pop.map(function (g) {
    return { genome: g, score: fitness(g, tgt).score };
  });
  finalScored.sort(function (a, b) { return b.score - a.score; });

  return {
    target: tgt,
    populationSize: popSize,
    generationsRun: history.length > 0 ? history[history.length - 1].generation + 1 : 0,
    maxGenerations: maxGens,
    bestGenome: finalScored[0].genome,
    bestFitness: Math.round(finalScored[0].score * 10000) / 10000,
    converged: finalScored[0].score >= 1,
    mutationRate: mutationRate,
    eliteCount: eliteCount,
    history: history
  };
}

self.onmessage = function (e) {
  var msg = e.data;
  switch (msg.type) {
    case 'mutate':
      self.postMessage({ type: 'result', action: 'mutate', data: mutate(String(msg.genome || ''), msg.rate) });
      break;
    case 'fitness':
      self.postMessage({ type: 'result', action: 'fitness', data: fitness(msg.genome, msg.target) });
      break;
    case 'crossover':
      self.postMessage({ type: 'result', action: 'crossover', data: crossover(msg.parent1, msg.parent2) });
      break;
    case 'select':
      self.postMessage({ type: 'result', action: 'select', data: selectHandler(msg.population, msg.fitnesses) });
      break;
    case 'evolve':
      self.postMessage({ type: 'result', action: 'evolve', data: evolve(msg.population, msg.target, msg.generations) });
      break;
    case 'status':
      self.postMessage({
        type: 'status',
        name: NAME,
        uptime: Date.now() - BOOT_TIME,
        beat: beat,
        totalGenerations: generations,
        charsetSize: CHARSET.length
      });
      break;
  }
};

setInterval(function () {
  beat++;
  self.postMessage({ type: 'heartbeat', name: NAME, beat: beat, uptime: Date.now() - BOOT_TIME });
}, 873);

self.postMessage({
  type: 'booted',
  name: NAME,
  engines: ['mutation-operator', 'fitness-evaluator', 'crossover-recombinator', 'tournament-selector', 'evolution-engine'],
  capabilities: ['mutate', 'fitness', 'crossover', 'select', 'evolve', 'status']
});
