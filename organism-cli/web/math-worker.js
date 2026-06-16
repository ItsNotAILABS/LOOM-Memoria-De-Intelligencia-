/**
 * NUMERUS OPERANS — Operating Math Worker
 * Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
 *
 * Permanent, always-on Web Worker for mathematical computation:
 * Matrix algebra, statistics, phi/golden ratio, DFT, probability,
 * optimization, linear regression, number theory, Fibonacci, primes.
 * 873ms heartbeat cycle. Pure vanilla JS, no imports.
 */

var NAME = 'NUMERUS OPERANS';
var BOOT_TIME = Date.now();
var beat = 0;
var computations = 0;

var PHI = (1 + Math.sqrt(5)) / 2;
var PSI = (1 - Math.sqrt(5)) / 2;

function r8(v) { return Math.round(v * 1e8) / 1e8; }

// ── Fibonacci & Phi ──────────────────────────────────────────────────

function fibonacci(n) {
  n = Math.min(Math.max(Math.floor(Number(n)) || 0, 0), 1000);
  if (n <= 1) return { n: n, value: n, method: 'direct' };
  var a = 0, b = 1;
  for (var i = 2; i <= n; i++) { var t = a + b; a = b; b = t; }
  computations++;
  var binet = r8((Math.pow(PHI, n) - Math.pow(PSI, n)) / Math.sqrt(5));
  return { n: n, value: b, digits: String(b).length, method: 'iterative', binet: binet };
}

function goldenRatio(input) {
  var x = Number(input);
  if (isNaN(x)) return { error: 'Invalid number' };
  computations++;
  var phiMultiple = x / PHI;
  var remainder = x - Math.round(phiMultiple) * PHI;
  var closestFibA = 0, closestFibB = 1;
  while (closestFibB < Math.abs(x)) {
    var t = closestFibA + closestFibB; closestFibA = closestFibB; closestFibB = t;
  }
  var ratioToFib = closestFibA > 0 ? closestFibB / closestFibA : Infinity;

  // Golden-angle spiral coordinates for first 60 points
  var spiral = [];
  var count = Math.min(Math.abs(Math.floor(x)) || 20, 60);
  var goldenAngle = Math.PI * (3 - Math.sqrt(5));
  for (var i = 0; i < count; i++) {
    var r = Math.sqrt(i + 1);
    var theta = i * goldenAngle;
    spiral.push([r8(r * Math.cos(theta)), r8(r * Math.sin(theta))]);
  }

  // Phi powers
  var phiPowers = [];
  for (var p = 0; p <= 10; p++) phiPowers.push(r8(Math.pow(PHI, p)));

  return {
    input: x,
    phi: r8(PHI),
    phiMultiple: r8(phiMultiple),
    remainder: r8(remainder),
    nearestFibPair: [closestFibA, closestFibB],
    fibRatio: ratioToFib === Infinity ? 'Infinity' : r8(ratioToFib),
    phiDeviation: ratioToFib === Infinity ? 'N/A' : r8(Math.abs(ratioToFib - PHI)),
    isGolden: Math.abs(remainder) < 0.001,
    spiral: spiral,
    phiPowers: phiPowers
  };
}

// ── Primality & Prime Handler ────────────────────────────────────────

function isPrime(n) {
  n = Math.floor(Number(n));
  if (n < 2) return false;
  if (n < 4) return true;
  if (n % 2 === 0 || n % 3 === 0) return false;
  for (var i = 5; i * i <= n; i += 6) {
    if (n % i === 0 || n % (i + 2) === 0) return false;
  }
  return true;
}

function nthPrime(n) {
  n = Math.min(Math.max(Math.floor(Number(n)) || 1, 1), 10000);
  var count = 0, candidate = 1;
  while (count < n) { candidate++; if (isPrime(candidate)) count++; }
  return candidate;
}

function primeHandler(n) {
  n = Math.floor(Number(n));
  computations++;
  if (n <= 0) return { error: 'n must be positive' };
  if (n <= 10000) {
    var p = nthPrime(n);
    return { mode: 'nthPrime', n: n, prime: p, isPrime: true };
  }
  return { mode: 'primalityTest', n: n, isPrime: isPrime(n) };
}

// ── Statistics ───────────────────────────────────────────────────────

function percentile(sorted, p) {
  if (sorted.length === 1) return sorted[0];
  var idx = (p / 100) * (sorted.length - 1);
  var lo = Math.floor(idx), hi = Math.ceil(idx);
  if (lo === hi) return sorted[lo];
  return sorted[lo] + (sorted[hi] - sorted[lo]) * (idx - lo);
}

function stats(data) {
  if (!Array.isArray(data) || data.length === 0) return { error: 'Provide a non-empty numeric array' };
  var nums = data.map(Number).filter(function (x) { return !isNaN(x); });
  if (nums.length === 0) return { error: 'No valid numbers in array' };
  computations++;

  var n = nums.length;
  var sum = 0, min = nums[0], max = nums[0];
  for (var i = 0; i < n; i++) {
    sum += nums[i];
    if (nums[i] < min) min = nums[i];
    if (nums[i] > max) max = nums[i];
  }
  var mean = sum / n;

  var sorted = nums.slice().sort(function (a, b) { return a - b; });
  var mid = Math.floor(n / 2);
  var median = n % 2 !== 0 ? sorted[mid] : (sorted[mid - 1] + sorted[mid]) / 2;

  var m2 = 0, m3 = 0, m4 = 0;
  for (var j = 0; j < n; j++) {
    var d = nums[j] - mean;
    m2 += d * d;
    m3 += d * d * d;
    m4 += d * d * d * d;
  }
  var variance = m2 / n;
  var stddev = Math.sqrt(variance);

  var skewness = stddev > 0 ? (m3 / n) / (stddev * stddev * stddev) : 0;
  var kurtosis = stddev > 0 ? (m4 / n) / (variance * variance) - 3 : 0;

  var q1 = percentile(sorted, 25);
  var q3 = percentile(sorted, 75);

  return {
    count: n,
    sum: r8(sum),
    mean: r8(mean),
    median: r8(median),
    min: min,
    max: max,
    range: max - min,
    variance: r8(variance),
    stddev: r8(stddev),
    skewness: r8(skewness),
    kurtosis: r8(kurtosis),
    q1: r8(q1),
    q3: r8(q3),
    iqr: r8(q3 - q1),
    p10: r8(percentile(sorted, 10)),
    p90: r8(percentile(sorted, 90))
  };
}

// ── Matrix Algebra ───────────────────────────────────────────────────

function matrixOp(op, a, b) {
  computations++;
  switch (op) {
    case 'multiply':   return matrixMultiply(a, b);
    case 'transpose':  return matrixTranspose(a);
    case 'determinant': return matrixDeterminant(a);
    case 'trace':      return matrixTrace(a);
    case 'identity':   return matrixIdentity(a);
    default: return { error: 'Unknown matrix op: ' + op };
  }
}

function matrixMultiply(a, b) {
  if (!Array.isArray(a) || !Array.isArray(b)) return { error: 'Provide two 2D arrays' };
  if (!Array.isArray(a[0]) || !Array.isArray(b[0])) return { error: 'Matrices must be 2D arrays' };
  var rowsA = a.length, colsA = a[0].length;
  var rowsB = b.length, colsB = b[0].length;
  if (colsA !== rowsB) return { error: 'Incompatible dimensions: ' + colsA + ' vs ' + rowsB };
  if (rowsA > 100 || colsB > 100) return { error: 'Matrix too large (max 100x100)' };

  var result = [];
  for (var i = 0; i < rowsA; i++) {
    result[i] = [];
    for (var j = 0; j < colsB; j++) {
      var s = 0;
      for (var k = 0; k < colsA; k++) s += (Number(a[i][k]) || 0) * (Number(b[k][j]) || 0);
      result[i][j] = r8(s);
    }
  }
  return { op: 'multiply', dimensions: [rowsA, colsB], result: result, operations: rowsA * colsB * colsA };
}

function matrixTranspose(a) {
  if (!Array.isArray(a) || !Array.isArray(a[0])) return { error: 'Provide a 2D array' };
  var rows = a.length, cols = a[0].length;
  var result = [];
  for (var j = 0; j < cols; j++) {
    result[j] = [];
    for (var i = 0; i < rows; i++) result[j][i] = Number(a[i][j]) || 0;
  }
  return { op: 'transpose', dimensions: [cols, rows], result: result };
}

function matrixDeterminant(a) {
  if (!Array.isArray(a) || !Array.isArray(a[0])) return { error: 'Provide a 2D array' };
  var n = a.length;
  if (n !== a[0].length) return { error: 'Matrix must be square' };
  if (n > 10) return { error: 'Max 10x10 for determinant' };

  function det(m) {
    var sz = m.length;
    if (sz === 1) return m[0][0];
    if (sz === 2) return m[0][0] * m[1][1] - m[0][1] * m[1][0];
    var d = 0;
    for (var c = 0; c < sz; c++) {
      var sub = [];
      for (var i = 1; i < sz; i++) {
        var row = [];
        for (var j = 0; j < sz; j++) { if (j !== c) row.push(m[i][j]); }
        sub.push(row);
      }
      d += (c % 2 === 0 ? 1 : -1) * m[0][c] * det(sub);
    }
    return d;
  }

  var numA = a.map(function (row) { return row.map(function (v) { return Number(v) || 0; }); });
  return { op: 'determinant', size: n, determinant: r8(det(numA)) };
}

function matrixTrace(a) {
  if (!Array.isArray(a) || !Array.isArray(a[0])) return { error: 'Provide a 2D array' };
  var n = Math.min(a.length, a[0].length);
  var t = 0;
  for (var i = 0; i < n; i++) t += Number(a[i][i]) || 0;
  return { op: 'trace', size: n, trace: r8(t) };
}

function matrixIdentity(size) {
  var n = Math.min(Math.max(Math.floor(Number(size)) || 1, 1), 100);
  var result = [];
  for (var i = 0; i < n; i++) {
    result[i] = [];
    for (var j = 0; j < n; j++) result[i][j] = i === j ? 1 : 0;
  }
  return { op: 'identity', size: n, result: result };
}

// ── Discrete Fourier Transform ───────────────────────────────────────

function dft(signal) {
  if (!Array.isArray(signal) || signal.length === 0) return { error: 'Provide a non-empty numeric array' };
  var N = signal.length;
  if (N > 4096) return { error: 'Signal too long (max 4096 samples)' };
  computations++;

  var real = [], imag = [], magnitude = [];
  for (var k = 0; k < N; k++) {
    var re = 0, im = 0;
    for (var n = 0; n < N; n++) {
      var angle = (2 * Math.PI * k * n) / N;
      re += (Number(signal[n]) || 0) * Math.cos(angle);
      im -= (Number(signal[n]) || 0) * Math.sin(angle);
    }
    real.push(r8(re));
    imag.push(r8(im));
    magnitude.push(r8(Math.sqrt(re * re + im * im)));
  }

  // Find dominant frequency (skip DC at k=0)
  var domIdx = 1, domMag = magnitude[1] || 0;
  for (var d = 2; d < Math.floor(N / 2); d++) {
    if (magnitude[d] > domMag) { domMag = magnitude[d]; domIdx = d; }
  }

  return {
    N: N,
    real: real,
    imag: imag,
    magnitude: magnitude,
    dominantBin: domIdx,
    dominantMagnitude: r8(domMag),
    normalizedFrequency: r8(domIdx / N)
  };
}

// ── Probability ──────────────────────────────────────────────────────

// Standard normal PDF
function normalPDF(x, mu, sigma) {
  if (sigma <= 0) return 0;
  var z = (x - mu) / sigma;
  return (1 / (sigma * Math.sqrt(2 * Math.PI))) * Math.exp(-0.5 * z * z);
}

// Standard normal CDF — Abramowitz & Stegun rational approximation
function normalCDF(x, mu, sigma) {
  if (sigma <= 0) return x >= mu ? 1 : 0;
  var z = (x - mu) / sigma;
  if (z < -8) return 0;
  if (z > 8) return 1;
  var neg = z < 0;
  if (neg) z = -z;
  var t = 1 / (1 + 0.2316419 * z);
  var p = 0.3989422804014327 * Math.exp(-0.5 * z * z);
  var poly = t * (0.319381530 + t * (-0.356563782 + t * (1.781477937 + t * (-1.821255978 + t * 1.330274429))));
  var cdf = 1 - p * poly;
  return neg ? 1 - cdf : cdf;
}

// Poisson PMF
function poissonPMF(k, lambda) {
  if (lambda <= 0 || k < 0) return 0;
  k = Math.floor(k);
  var logP = k * Math.log(lambda) - lambda;
  for (var i = 2; i <= k; i++) logP -= Math.log(i);
  return Math.exp(logP);
}

// Bayesian posterior update: Beta-Binomial conjugate
function bayesianUpdate(priorAlpha, priorBeta, successes, failures) {
  var a = (Number(priorAlpha) || 1) + (Number(successes) || 0);
  var b = (Number(priorBeta) || 1) + (Number(failures) || 0);
  var mean = a / (a + b);
  var variance = (a * b) / ((a + b) * (a + b) * (a + b + 1));
  return {
    posteriorAlpha: a,
    posteriorBeta: b,
    posteriorMean: r8(mean),
    posteriorVariance: r8(variance),
    credibleInterval95: [r8(betaQuantile(0.025, a, b)), r8(betaQuantile(0.975, a, b))]
  };
}

// Beta quantile via bisection on the regularized incomplete beta
function betaQuantile(p, a, b) {
  var lo = 0, hi = 1;
  for (var iter = 0; iter < 80; iter++) {
    var mid = (lo + hi) / 2;
    if (regIncBeta(mid, a, b) < p) lo = mid; else hi = mid;
    if (hi - lo < 1e-9) break;
  }
  return (lo + hi) / 2;
}

function betaPDF(x, a, b) {
  if (x <= 0 || x >= 1) return 0;
  return Math.exp((a - 1) * Math.log(x) + (b - 1) * Math.log(1 - x) - logBeta(a, b));
}

function logBeta(a, b) { return logGamma(a) + logGamma(b) - logGamma(a + b); }

// Stirling/Lanczos log-gamma approximation
function logGamma(x) {
  var c = [76.18009172947146, -86.50532032941677, 24.01409824083091,
    -1.231739572450155, 0.001208650973866179, -0.000005395239384953];
  var y = x, tmp = x + 5.5;
  tmp -= (x + 0.5) * Math.log(tmp);
  var ser = 1.000000000190015;
  for (var j = 0; j < 6; j++) ser += c[j] / ++y;
  return -tmp + Math.log(2.5066282746310005 * ser / x);
}

// Regularized incomplete beta via continued fraction
function regIncBeta(x, a, b) {
  if (x <= 0) return 0;
  if (x >= 1) return 1;
  if (x > (a + 1) / (a + b + 2)) return 1 - regIncBeta(1 - x, b, a);
  var lnPre = a * Math.log(x) + b * Math.log(1 - x) - Math.log(a) - logBeta(a, b);
  var pre = Math.exp(lnPre);
  // Lentz continued fraction
  var f = 1, c = 1, d = 1 - (a + b) * x / (a + 1);
  if (Math.abs(d) < 1e-30) d = 1e-30;
  d = 1 / d; f = d;
  for (var m = 1; m <= 100; m++) {
    var m2 = 2 * m;
    var an = m * (b - m) * x / ((a + m2 - 1) * (a + m2));
    d = 1 + an * d; if (Math.abs(d) < 1e-30) d = 1e-30; d = 1 / d;
    c = 1 + an / c; if (Math.abs(c) < 1e-30) c = 1e-30;
    f *= d * c;
    an = -(a + m) * (a + b + m) * x / ((a + m2) * (a + m2 + 1));
    d = 1 + an * d; if (Math.abs(d) < 1e-30) d = 1e-30; d = 1 / d;
    c = 1 + an / c; if (Math.abs(c) < 1e-30) c = 1e-30;
    var delta = d * c; f *= delta;
    if (Math.abs(delta - 1) < 1e-10) break;
  }
  return pre * a * f;
}

function probability(dist, params) {
  computations++;
  params = params || {};
  switch (dist) {
    case 'normal': {
      var mu = Number(params.mu) || 0, sigma = Number(params.sigma) || 1;
      var x = Number(params.x) || 0;
      return { dist: 'normal', x: x, mu: mu, sigma: sigma, pdf: r8(normalPDF(x, mu, sigma)), cdf: r8(normalCDF(x, mu, sigma)) };
    }
    case 'poisson': {
      var k = Math.floor(Number(params.k)) || 0;
      var lambda = Number(params.lambda) || 1;
      var pmfVals = [];
      for (var i = 0; i <= Math.min(k + 10, 50); i++) pmfVals.push(r8(poissonPMF(i, lambda)));
      return { dist: 'poisson', k: k, lambda: lambda, pmf: r8(poissonPMF(k, lambda)), pmfTable: pmfVals };
    }
    case 'bayesian':
      return { dist: 'bayesian', result: bayesianUpdate(params.priorAlpha, params.priorBeta, params.successes, params.failures) };
    default:
      return { error: 'Unknown distribution: ' + dist + '. Use normal, poisson, or bayesian' };
  }
}

// ── Optimization — Golden-Section Search ─────────────────────────────

function goldenSectionSearch(aVal, bVal, tol) {
  computations++;
  var a = Number(aVal), b = Number(bVal);
  if (isNaN(a) || isNaN(b)) return { error: 'Provide numeric interval [a, b]' };
  tol = Number(tol) || 1e-8;
  if (a > b) { var swap = a; a = b; b = swap; }
  var gr = (Math.sqrt(5) - 1) / 2;
  var c = b - gr * (b - a);
  var d = a + gr * (b - a);
  var evals = 0, maxIter = 200;

  // Minimize f(x) = (x - PHI)^2 * sin(x) — a demo function with PHI connection
  function f(x) { evals++; return (x - PHI) * (x - PHI) * Math.sin(x); }

  while (Math.abs(b - a) > tol && evals < maxIter) {
    if (f(c) < f(d)) { b = d; } else { a = c; }
    c = b - gr * (b - a);
    d = a + gr * (b - a);
  }
  var xMin = (a + b) / 2;
  return {
    method: 'golden-section',
    xMin: r8(xMin),
    fMin: r8(f(xMin)),
    interval: [r8(a), r8(b)],
    evaluations: evals,
    tolerance: tol,
    functionDescription: '(x - phi)^2 * sin(x)'
  };
}

// ── Linear Regression ────────────────────────────────────────────────

function linearRegression(xArr, yArr) {
  if (!Array.isArray(xArr) || !Array.isArray(yArr)) return { error: 'Provide x and y arrays' };
  var n = Math.min(xArr.length, yArr.length);
  if (n < 2) return { error: 'Need at least 2 data points' };
  computations++;

  var sx = 0, sy = 0, sxy = 0, sx2 = 0, sy2 = 0;
  for (var i = 0; i < n; i++) {
    var xi = Number(xArr[i]) || 0, yi = Number(yArr[i]) || 0;
    sx += xi; sy += yi; sxy += xi * yi; sx2 += xi * xi; sy2 += yi * yi;
  }
  var denom = n * sx2 - sx * sx;
  if (Math.abs(denom) < 1e-15) return { error: 'Cannot fit — x values are constant' };

  var slope = (n * sxy - sx * sy) / denom;
  var intercept = (sy - slope * sx) / n;
  var meanY = sy / n;

  var ssTot = 0, ssRes = 0;
  var residuals = [];
  for (var j = 0; j < n; j++) {
    var xj = Number(xArr[j]) || 0, yj = Number(yArr[j]) || 0;
    var pred = slope * xj + intercept;
    var res = yj - pred;
    residuals.push(r8(res));
    ssTot += (yj - meanY) * (yj - meanY);
    ssRes += res * res;
  }
  var rSquared = ssTot > 0 ? 1 - ssRes / ssTot : 0;
  var see = n > 2 ? Math.sqrt(ssRes / (n - 2)) : 0;

  return {
    slope: r8(slope),
    intercept: r8(intercept),
    rSquared: r8(rSquared),
    standardError: r8(see),
    n: n,
    residuals: residuals,
    equation: 'y = ' + r8(slope) + 'x + ' + r8(intercept)
  };
}

// ── Number Theory ────────────────────────────────────────────────────

function primeFactorization(n) {
  n = Math.abs(Math.floor(Number(n)));
  if (n < 2) return { n: n, factors: [], error: n < 2 ? 'n must be >= 2' : undefined };
  var factors = [], orig = n;
  while (n % 2 === 0) { factors.push(2); n /= 2; }
  for (var i = 3; i * i <= n; i += 2) {
    while (n % i === 0) { factors.push(i); n /= i; }
  }
  if (n > 1) factors.push(n);
  return { n: orig, factors: factors, distinct: factors.filter(function (v, i, a) { return a.indexOf(v) === i; }) };
}

function gcd(a, b) {
  a = Math.abs(Math.floor(Number(a)));
  b = Math.abs(Math.floor(Number(b)));
  while (b) { var t = b; b = a % b; a = t; }
  return a;
}

function lcm(a, b) {
  a = Math.abs(Math.floor(Number(a)));
  b = Math.abs(Math.floor(Number(b)));
  return a && b ? (a / gcd(a, b)) * b : 0;
}

function eulerTotient(n) {
  n = Math.abs(Math.floor(Number(n)));
  if (n <= 1) return { n: n, totient: n === 1 ? 1 : 0 };
  var result = n, p = 2;
  var temp = n;
  while (p * p <= temp) {
    if (temp % p === 0) {
      while (temp % p === 0) temp /= p;
      result -= result / p;
    }
    p++;
  }
  if (temp > 1) result -= result / temp;
  return { n: n, totient: Math.round(result) };
}

function isFibonacci(n) {
  n = Math.abs(Math.floor(Number(n)));
  function isPerfectSquare(x) { var s = Math.round(Math.sqrt(x)); return s * s === x; }
  return isPerfectSquare(5 * n * n + 4) || isPerfectSquare(5 * n * n - 4);
}

function zeckendorf(n) {
  n = Math.abs(Math.floor(Number(n)));
  if (n === 0) return { n: 0, representation: [0] };
  // Generate Fibonacci numbers up to n
  var fibs = [1, 2];
  while (fibs[fibs.length - 1] < n) {
    fibs.push(fibs[fibs.length - 1] + fibs[fibs.length - 2]);
  }
  var rep = [], rem = n;
  for (var i = fibs.length - 1; i >= 0 && rem > 0; i--) {
    if (fibs[i] <= rem) { rep.push(fibs[i]); rem -= fibs[i]; }
  }
  return { n: n, representation: rep, sum: rep.reduce(function (a, b) { return a + b; }, 0), terms: rep.length };
}

function numberTheory(op, n, m) {
  computations++;
  switch (op) {
    case 'factor':      return primeFactorization(n);
    case 'gcd':         return { a: Math.floor(Number(n)), b: Math.floor(Number(m)), gcd: gcd(n, m) };
    case 'lcm':         return { a: Math.floor(Number(n)), b: Math.floor(Number(m)), lcm: lcm(n, m) };
    case 'totient':     return eulerTotient(n);
    case 'zeckendorf':  return zeckendorf(n);
    case 'isFibonacci': return { n: Math.floor(Number(n)), isFibonacci: isFibonacci(n) };
    default: return { error: 'Unknown numberTheory op: ' + op };
  }
}

// ── Message Handler ──────────────────────────────────────────────────

self.onmessage = function (e) {
  var msg = e.data;
  switch (msg.type) {
    case 'fibonacci':
      self.postMessage({ type: 'result', action: 'fibonacci', data: fibonacci(msg.n) });
      break;
    case 'golden':
      self.postMessage({ type: 'result', action: 'golden', data: goldenRatio(msg.input) });
      break;
    case 'prime':
      self.postMessage({ type: 'result', action: 'prime', data: primeHandler(msg.n) });
      break;
    case 'stats':
      self.postMessage({ type: 'result', action: 'stats', data: stats(msg.data) });
      break;
    case 'matrix':
      self.postMessage({ type: 'result', action: 'matrix', data: matrixOp(msg.op, msg.a, msg.b) });
      break;
    case 'dft':
      self.postMessage({ type: 'result', action: 'dft', data: dft(msg.signal) });
      break;
    case 'probability':
      self.postMessage({ type: 'result', action: 'probability', data: probability(msg.dist, msg.params) });
      break;
    case 'optimize':
      self.postMessage({ type: 'result', action: 'optimize', data: goldenSectionSearch(msg.a, msg.b, msg.tolerance) });
      break;
    case 'regression':
      self.postMessage({ type: 'result', action: 'regression', data: linearRegression(msg.x, msg.y) });
      break;
    case 'numberTheory':
      self.postMessage({ type: 'result', action: 'numberTheory', data: numberTheory(msg.op, msg.n, msg.m) });
      break;
    case 'status':
      self.postMessage({
        type: 'status',
        name: NAME,
        uptime: Date.now() - BOOT_TIME,
        beat: beat,
        computationsRun: computations,
        constants: { phi: PHI, psi: PSI, e: Math.E, pi: Math.PI }
      });
      break;
  }
};

// ── Heartbeat & Boot ─────────────────────────────────────────────────

setInterval(function () {
  beat++;
  self.postMessage({ type: 'heartbeat', name: NAME, beat: beat, uptime: Date.now() - BOOT_TIME });
}, 873);

self.postMessage({
  type: 'booted',
  name: NAME,
  engines: [
    'fibonacci-iterative', 'binet-formula', 'prime-sieve', 'golden-ratio',
    'golden-spiral', 'statistics-full', 'matrix-algebra', 'cofactor-determinant',
    'discrete-fourier', 'normal-distribution', 'poisson-distribution',
    'bayesian-conjugate', 'golden-section-optimizer', 'linear-regression',
    'prime-factorization', 'euler-totient', 'zeckendorf-decomposition'
  ],
  capabilities: [
    'fibonacci', 'golden', 'prime', 'stats', 'matrix', 'dft',
    'probability', 'optimize', 'regression', 'numberTheory', 'status'
  ]
});
