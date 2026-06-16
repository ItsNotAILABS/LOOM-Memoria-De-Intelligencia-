// Medina Edge AI Assistant — Content Runtime

(function () {
  'use strict';

  const PHI = 1.618033988749895;
  const EXT_ID = 'EXT-022';
  const MIN_KEYWORD_TOKEN_LENGTH = 5;
  const MAX_TOP_KEYWORDS = 20;
  const KNOWLEDGE_SYNC_BASE_INTERVAL_MS = 30000;

  if (typeof window.__MEDINA_EXTENSIONS__ === 'undefined') {
    window.__MEDINA_EXTENSIONS__ = {};
  }

  window.__MEDINA_EXTENSIONS__[EXT_ID] = {
    name: 'Medina Edge AI Assistant',
    latinName: 'ASSISTENS INTELLIGENTIAE ORAE',
    domain: 'Edge AI adapter mesh + offline sovereign sync',
    active: true,
    loadedAt: Date.now(),
    frequency_Hz: PHI
  };

  function compactText(input, max = 320) {
    if (!input) return '';
    return String(input).replace(/\s+/g, ' ').trim().slice(0, max);
  }

  function extractPageContext() {
    const title = compactText(document.title, 140);
    const description = compactText(document.querySelector('meta[name="description"]')?.content || '', 240);
    const h1 = Array.from(document.querySelectorAll('h1')).map((n) => compactText(n.textContent, 100));
    const h2 = Array.from(document.querySelectorAll('h2')).slice(0, 8).map((n) => compactText(n.textContent, 100));

    return {
      url: window.location.href,
      origin: window.location.origin,
      language: document.documentElement.lang || 'unknown',
      title,
      description,
      headingH1: h1,
      headingH2: h2,
      bodyLength: (document.body?.innerText || '').length,
      observedAt: Date.now()
    };
  }

  function extractKnowledgeNodes() {
    const bodyText = compactText(document.body?.innerText || '', 2000);
    const tokens = bodyText.toLowerCase().split(/[^a-z0-9_]+/).filter(Boolean);
    const freq = {};

    for (const token of tokens) {
      if (token.length < MIN_KEYWORD_TOKEN_LENGTH) continue;
      freq[token] = (freq[token] || 0) + 1;
    }

    const topKeywords = Object.entries(freq)
      .sort((a, b) => b[1] - a[1])
      .slice(0, MAX_TOP_KEYWORDS)
      .map(([term, count]) => ({ term, count }));

    return {
      nodeKey: `page:${window.location.origin}:${window.location.pathname}`,
      title: compactText(document.title, 160),
      url: window.location.href,
      keywords: topKeywords,
      textPreview: bodyText,
      learnedAt: Date.now()
    };
  }

  function sendContextBridge() {
    chrome.runtime.sendMessage(
      {
        type: 'MEDINA_CONTEXT_BRIDGE',
        payload: extractPageContext()
      },
      () => void chrome.runtime.lastError
    );
  }

  function sendKnowledgeSync() {
    chrome.runtime.sendMessage(
      {
        type: 'MEDINA_KNOWLEDGE_SYNC',
        payload: extractKnowledgeNodes()
      },
      () => void chrome.runtime.lastError
    );
  }

  function installNetworkInterceptor() {
    if (document.getElementById('medina-edge-ai-interceptor')) {
      return;
    }

    const script = document.createElement('script');
    script.id = 'medina-edge-ai-interceptor';
    script.textContent = `
      (() => {
        const BODY_MAX_LENGTH = 2000;
        const emit = (payload) => {
          window.postMessage({ __MEDINA_API_MESH__: true, payload }, '*');
        };

        const originalFetch = window.fetch;
        window.fetch = async (...args) => {
          const req = args[0];
          const init = args[1] || {};
          const method = (init.method || (req && req.method) || 'GET').toUpperCase();
          const url = typeof req === 'string' ? req : req?.url;
          const started = Date.now();

          try {
            const response = await originalFetch(...args);
            const cloned = response.clone();
            let body = '';
            try {
              body = await cloned.text();
            } catch (_) {}

            emit({
              source: 'fetch',
              method,
              url,
              status: response.status,
              latencyMs: Date.now() - started,
              body: typeof body === 'string' ? body.slice(0, BODY_MAX_LENGTH) : ''
            });
            return response;
          } catch (error) {
            emit({
              source: 'fetch',
              method,
              url,
              status: 0,
              latencyMs: Date.now() - started,
              body: String(error)
            });
            throw error;
          }
        };

        const open = XMLHttpRequest.prototype.open;
        const send = XMLHttpRequest.prototype.send;
        XMLHttpRequest.prototype.open = function(method, url, ...rest) {
          this.__medina = { method: (method || 'GET').toUpperCase(), url, started: 0 };
          return open.call(this, method, url, ...rest);
        };
        XMLHttpRequest.prototype.send = function(...args) {
          if (this.__medina) this.__medina.started = Date.now();
          this.addEventListener('loadend', () => {
            emit({
              source: 'xhr',
              method: this.__medina?.method || 'GET',
              url: this.__medina?.url || '',
              status: this.status || 0,
              latencyMs: this.__medina?.started ? Date.now() - this.__medina.started : 0,
              body: typeof this.responseText === 'string' ? this.responseText.slice(0, BODY_MAX_LENGTH) : ''
            });
          });
          return send.call(this, ...args);
        };
      })();
    `;

    (document.documentElement || document.head || document.body).appendChild(script);
  }

  window.addEventListener('message', (event) => {
    if (event.source !== window) return;
    if (!event.data || !event.data.__MEDINA_API_MESH__) return;

    chrome.runtime.sendMessage(
      {
        type: 'MEDINA_API_MESH',
        payload: event.data.payload || {}
      },
      () => void chrome.runtime.lastError
    );
  });

  chrome.runtime.onMessage.addListener((message) => {
    if (message.type === 'MEDINA_SIGNAL_BROADCAST') {
      console.log('[MEDINA] Signal relay received:', message.signal);
    }
  });

  installNetworkInterceptor();
  sendContextBridge();
  sendKnowledgeSync();

  document.addEventListener('visibilitychange', () => {
    if (document.visibilityState === 'visible') {
      sendContextBridge();
    }
  });

  setInterval(() => {
    sendKnowledgeSync();
  }, Math.round(KNOWLEDGE_SYNC_BASE_INTERVAL_MS / PHI));

  console.log('[MEDINA] ASSISTENS INTELLIGENTIAE ORAE content runtime loaded. φ=' + PHI);
})();
