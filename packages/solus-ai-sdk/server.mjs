/**
 * SOLUS AI — Local Development Server (Node 20)
 * 
 * Non-static server with dynamic route handling.
 * Worker #78 | Layer 22 | φ²² = 4,870,847 Hz
 */

import { createServer } from 'http';
import { readFileSync, existsSync } from 'fs';
import { join, extname, dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const SITE_DIR = join(__dirname, '_site');
const PORT = process.env.PORT || 3000;

const MIME_TYPES = {
  '.html': 'text/html',
  '.css': 'text/css',
  '.js': 'application/javascript',
  '.json': 'application/json',
  '.png': 'image/png',
  '.svg': 'image/svg+xml',
};

const server = createServer((req, res) => {
  const url = new URL(req.url, `http://localhost:${PORT}`);
  let pathname = url.pathname;

  // Dynamic API route for build info
  if (pathname === '/api/status') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      system: 'SOLUS AI',
      version: '1.0.0',
      worker: 78,
      layer: 22,
      frequency_hz: 4_870_847,
      node: process.version,
      uptime: process.uptime(),
      timestamp: new Date().toISOString(),
      dynamic: true,
    }));
    return;
  }

  // Dynamic API route for health
  if (pathname === '/api/health') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok', dynamic: true }));
    return;
  }

  // Serve static files from _site
  if (pathname === '/') pathname = '/index.html';
  const filePath = join(SITE_DIR, pathname);
  
  if (!existsSync(filePath)) {
    res.writeHead(404, { 'Content-Type': 'text/html' });
    res.end('<h1>404 — Page Not Found</h1><p><a href="/">Return to SOLUS AI</a></p>');
    return;
  }

  const ext = extname(filePath);
  const contentType = MIME_TYPES[ext] || 'application/octet-stream';
  const content = readFileSync(filePath);
  
  res.writeHead(200, {
    'Content-Type': contentType,
    'X-Solus-Worker': '78',
    'X-Solus-Layer': '22',
    'X-Powered-By': 'SOLUS AI (Node 20)',
  });
  res.end(content);
});

server.listen(PORT, () => {
  console.log(`🔮 SOLUS AI Server running at http://localhost:${PORT}`);
  console.log(`   Worker #78 | Layer 22 | φ²² = 4,870,847 Hz`);
  console.log(`   Node ${process.version} | Non-static mode`);
  console.log(`   Dynamic routes: /api/status, /api/health`);
});
