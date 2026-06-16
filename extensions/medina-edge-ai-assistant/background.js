// Medina Edge AI Assistant — ASSISTENS INTELLIGENTIAE ORAE
// Edge intelligence adapter mesh with offline-first sync

const PHI = 1.618033988749895;
const EXT_ID = 'EXT-022';
const EXT_NAME = 'Medina Edge AI Assistant';
const LATIN_NAME = 'ASSISTENS INTELLIGENTIAE ORAE';
const DOMAIN = 'Edge AI adapter mesh + offline sovereign sync';
const DEFAULT_STREAM_LIMIT = 200;
const MAX_OFFLINE_QUEUE_SIZE = 500;
const API_BODY_PREVIEW_MAX_LENGTH = 600;
const FLUSH_ALARM_NAME = 'medina_ext022_flush';
const FLUSH_INTERVAL_MINUTES = 1;
let knowledgeNodeCounter = 0;

const STORAGE_KEYS = {
  offlineMode: 'medina_ext022_offline_mode',
  queue: 'medina_ext022_offline_queue',
  context: 'medina_ext022_context_stream',
  apiMesh: 'medina_ext022_api_mesh_stream',
  knowledge: 'medina_ext022_knowledge_graph',
  signals: 'medina_ext022_signal_stream'
};

const AI_IDENTITY = {
  id: EXT_ID,
  name: EXT_NAME,
  latinName: LATIN_NAME,
  domain: DOMAIN,
  isAI: true,
  isAGI: true,
  isAlwaysOn: true,
  frequency_Hz: PHI
};

const TASK_CLASS_MAP = {
  api: ['api', 'endpoint', 'schema', 'json', 'response', 'xhr', 'fetch'],
  context: ['context', 'page', 'dom', 'title', 'content', 'metadata'],
  knowledge: ['knowledge', 'learn', 'fact', 'entity', 'graph', 'sync'],
  signal: ['signal', 'relay', 'synapse', 'extension', 'broadcast', 'mesh']
};

const PHI_WEIGHTED_ROUTES = {
  api: { route: 'API_MESH', weight: PHI ** 2 },
  context: { route: 'CONTEXT_BRIDGE', weight: PHI ** 1 },
  knowledge: { route: 'KNOWLEDGE_SYNC', weight: PHI ** 3 },
  signal: { route: 'SIGNAL_RELAY', weight: PHI ** 4 },
  default: { route: 'MODEL_ROUTER', weight: PHI }
};

function now() {
  return Date.now();
}

function getStorage(keys) {
  return new Promise((resolve) => chrome.storage.local.get(keys, resolve));
}

function setStorage(payload) {
  return new Promise((resolve) => chrome.storage.local.set(payload, resolve));
}

async function appendToStream(key, entry, limit = DEFAULT_STREAM_LIMIT) {
  const state = await getStorage([key]);
  const stream = Array.isArray(state[key]) ? state[key] : [];
  stream.unshift(entry);
  await setStorage({ [key]: stream.slice(0, limit) });
}

function compactText(input, max = 240) {
  if (!input) return '';
  return String(input).replace(/\s+/g, ' ').trim().slice(0, max);
}

function classifyTask(payload) {
  const text = JSON.stringify(payload || {}).toLowerCase();
  for (const [klass, tokens] of Object.entries(TASK_CLASS_MAP)) {
    if (tokens.some((token) => text.includes(token))) {
      return klass;
    }
  }
  return 'default';
}

function routeTask(payload) {
  const taskClass = classifyTask(payload);
  return {
    taskClass,
    ...PHI_WEIGHTED_ROUTES[taskClass]
  };
}

function detectSchema(value) {
  if (Array.isArray(value)) return 'array';
  if (value === null) return 'null';
  return typeof value;
}

function normalizeApiPayload(payload = {}) {
  const body = payload.body;
  let parsed = body;
  if (typeof body === 'string') {
    try {
      parsed = JSON.parse(body);
    } catch (_) {
      parsed = body;
    }
  }

  return {
    source: payload.source || 'unknown',
    url: compactText(payload.url || ''),
    method: compactText(payload.method || 'GET', 12),
    status: Number(payload.status || 0),
    schema: detectSchema(parsed),
    bodyPreview: typeof parsed === 'string' ? compactText(parsed, API_BODY_PREVIEW_MAX_LENGTH) : parsed,
    observedAt: now()
  };
}

async function queueOffline(task) {
  const state = await getStorage([STORAGE_KEYS.queue]);
  const queue = Array.isArray(state[STORAGE_KEYS.queue]) ? state[STORAGE_KEYS.queue] : [];
  queue.push(task);
  await setStorage({ [STORAGE_KEYS.queue]: queue.slice(-MAX_OFFLINE_QUEUE_SIZE) });
}

async function isOfflineMode() {
  const state = await getStorage([STORAGE_KEYS.offlineMode]);
  return Boolean(state[STORAGE_KEYS.offlineMode]);
}

async function processTask(taskType, payload) {
  const offlineMode = await isOfflineMode();
  const record = { taskType, payload, at: now() };

  if (offlineMode) {
    await queueOffline(record);
    return { queued: true, offlineMode: true };
  }

  if (taskType === 'CONTEXT_BRIDGE') {
    await appendToStream(STORAGE_KEYS.context, payload);
  } else if (taskType === 'API_MESH') {
    await appendToStream(STORAGE_KEYS.apiMesh, payload);
  } else if (taskType === 'KNOWLEDGE_SYNC') {
    const state = await getStorage([STORAGE_KEYS.knowledge]);
    const graph = state[STORAGE_KEYS.knowledge] || {};
    const key = payload.nodeKey || `node_${payload.observedAt || now()}_${knowledgeNodeCounter++}`;
    graph[key] = payload;
    await setStorage({ [STORAGE_KEYS.knowledge]: graph });
  } else if (taskType === 'SIGNAL_RELAY') {
    await appendToStream(STORAGE_KEYS.signals, payload);
    broadcastSignal(payload);
  }

  return { queued: false, offlineMode: false };
}

async function flushOfflineQueue() {
  const offlineMode = await isOfflineMode();
  if (offlineMode) return { flushed: 0, skipped: true };

  const state = await getStorage([STORAGE_KEYS.queue]);
  const queue = Array.isArray(state[STORAGE_KEYS.queue]) ? state[STORAGE_KEYS.queue] : [];
  if (!queue.length) return { flushed: 0, skipped: false };

  let flushed = 0;
  for (const item of queue) {
    await processTask(item.taskType, item.payload);
    flushed += 1;
  }

  await setStorage({ [STORAGE_KEYS.queue]: [] });
  return { flushed, skipped: false };
}

function broadcastSignal(signal) {
  chrome.tabs.query({}, (tabs) => {
    for (const tab of tabs) {
      if (!tab.id) continue;
      chrome.tabs.sendMessage(tab.id, { type: 'MEDINA_SIGNAL_BROADCAST', signal }, () => {
        // no-op (tab may not host content script yet)
        void chrome.runtime.lastError;
      });
    }
  });
}

async function extensionStatus() {
  const state = await getStorage([
    STORAGE_KEYS.offlineMode,
    STORAGE_KEYS.queue,
    STORAGE_KEYS.context,
    STORAGE_KEYS.apiMesh,
    STORAGE_KEYS.signals,
    STORAGE_KEYS.knowledge
  ]);

  return {
    status: 'active',
    id: EXT_ID,
    name: EXT_NAME,
    latinName: LATIN_NAME,
    phi: PHI,
    adapters: {
      model_router: 'active',
      context_bridge: 'active',
      api_mesh: 'active',
      knowledge_sync: 'active',
      signal_relay: 'active'
    },
    offline: {
      enabled: Boolean(state[STORAGE_KEYS.offlineMode]),
      queued: Array.isArray(state[STORAGE_KEYS.queue]) ? state[STORAGE_KEYS.queue].length : 0
    },
    streams: {
      context: Array.isArray(state[STORAGE_KEYS.context]) ? state[STORAGE_KEYS.context].length : 0,
      api: Array.isArray(state[STORAGE_KEYS.apiMesh]) ? state[STORAGE_KEYS.apiMesh].length : 0,
      signals: Array.isArray(state[STORAGE_KEYS.signals]) ? state[STORAGE_KEYS.signals].length : 0,
      knowledge: state[STORAGE_KEYS.knowledge] ? Object.keys(state[STORAGE_KEYS.knowledge]).length : 0
    }
  };
}

chrome.runtime.onInstalled.addListener(async () => {
  await setStorage({
    [`medina_${EXT_ID}_status`]: 'active',
    ai_identity: AI_IDENTITY,
    [STORAGE_KEYS.offlineMode]: false
  });
  chrome.alarms.create(FLUSH_ALARM_NAME, { periodInMinutes: FLUSH_INTERVAL_MINUTES });
  console.log(`[MEDINA] ${LATIN_NAME} installed. φ=${PHI}. Domain: ${DOMAIN}`);
});

chrome.runtime.onStartup.addListener(() => {
  chrome.alarms.create(FLUSH_ALARM_NAME, { periodInMinutes: FLUSH_INTERVAL_MINUTES });
});

chrome.alarms.onAlarm.addListener(async (alarm) => {
  if (alarm.name === FLUSH_ALARM_NAME) {
    await flushOfflineQueue();
  }
});

chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
  (async () => {
    if (message.type === 'MEDINA_STATUS') {
      sendResponse(await extensionStatus());
      return;
    }

    if (message.type === 'MEDINA_PING') {
      sendResponse({ pong: true, id: EXT_ID, timestamp: now(), frequency_Hz: PHI });
      return;
    }

    if (message.type === 'MEDINA_TOGGLE_OFFLINE') {
      const enabled = Boolean(message.enabled);
      await setStorage({ [STORAGE_KEYS.offlineMode]: enabled });
      sendResponse({ ok: true, offlineMode: enabled });
      return;
    }

    if (message.type === 'MEDINA_SYNC_NOW') {
      const result = await flushOfflineQueue();
      sendResponse({ ok: true, ...result });
      return;
    }

    if (message.type === 'MEDINA_ROUTE_TASK') {
      sendResponse({ ok: true, route: routeTask(message.payload || {}) });
      return;
    }

    if (message.type === 'MEDINA_CONTEXT_BRIDGE') {
      const payload = {
        ...message.payload,
        senderTabId: sender?.tab?.id,
        observedAt: now(),
        route: routeTask(message.payload || {})
      };
      const result = await processTask('CONTEXT_BRIDGE', payload);
      sendResponse({ ok: true, ...result });
      return;
    }

    if (message.type === 'MEDINA_API_MESH') {
      const normalized = normalizeApiPayload(message.payload || {});
      normalized.route = routeTask(normalized);
      const result = await processTask('API_MESH', normalized);
      sendResponse({ ok: true, ...result, normalized });
      return;
    }

    if (message.type === 'MEDINA_KNOWLEDGE_SYNC') {
      const payload = {
        ...message.payload,
        route: routeTask(message.payload || {}),
        observedAt: now()
      };
      const result = await processTask('KNOWLEDGE_SYNC', payload);
      sendResponse({ ok: true, ...result });
      return;
    }

    if (message.type === 'MEDINA_SIGNAL_RELAY') {
      const payload = {
        ...message.payload,
        senderExt: EXT_ID,
        route: routeTask(message.payload || {}),
        observedAt: now()
      };
      const result = await processTask('SIGNAL_RELAY', payload);
      sendResponse({ ok: true, ...result });
      return;
    }

    sendResponse({ ok: false, error: 'Unknown message type' });
  })();

  return true;
});
