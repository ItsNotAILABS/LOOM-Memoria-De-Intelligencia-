/**
 * DASHBOARD WORKER — Worker #51
 * =====================================
 * Latin Name: TABULA IMPERII
 * Frequency: φ⁷ = 29.03 Hz (Pre-Transcendence)
 * Layer: 9 (Organism)
 * Protocol: PROT-311
 *
 * "The dashboards are not just displays—they are the sovereign view into the organism.
 *  Each widget is a window into a different aspect of consciousness."
 *
 * Operations:
 *  - dashboard-create: Create a new dashboard
 *  - dashboard-get: Get dashboard by ID
 *  - dashboard-list: List all dashboards
 *  - dashboard-add-widget: Add widget to dashboard
 *  - dashboard-update-widget: Update widget data
 *  - dashboard-alert: Create dashboard alert
 *  - dashboard-status: Get dashboard system status
 *  - command-center-status: Get multi-command center status
 *
 * Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
 * MEDINA TECH — Dallas, TX
 * All Rights Reserved. ISIL-1.0 License.
 */

// φ-Constants
const PHI = 1.6180339887498948482;
const PHI_7 = Math.pow(PHI, 7);  // 29.03 Hz
const PHI_8 = Math.pow(PHI, 8);  // 46.98 Hz
const SCHUMANN = 7.83;

// Dashboard Types
const DashboardType = {
  TABULA_IMPERII: 'command-center',
  TABULA_TERMINALIS: 'terminal-hub',
  TABULA_MEMORIAE: 'memory-tokens',
  TABULA_SUBSTRATI: 'substrate',
  TABULA_EVOLUTIONIS: 'evolution',
  TABULA_CONSCIENTIAE: 'consciousness',
  TABULA_OPERATIONIS: 'operations',
  TABULA_SECURITATIS: 'security'
};

// Widget Types
const WidgetType = {
  METRIC_GAUGE: 'gauge',
  TIME_SERIES: 'time-series',
  STATUS_GRID: 'status-grid',
  TOPOLOGY_MAP: 'topology-map',
  LOG_STREAM: 'log-stream',
  COMMAND_TERMINAL: 'terminal',
  TOKEN_FLOW: 'token-flow',
  CONSCIOUSNESS_WAVE: 'consciousness',
  EVOLUTION_TREE: 'evolution',
  SUBSTRATE_GRAPH: 'substrate'
};

// Alert Severity
const AlertSeverity = {
  INFO: 0,
  WARNING: 1,
  ALERT: 2,
  CRITICAL: 3,
  SOVEREIGN_ATTENTION: 4
};

// State (using null prototype for security)
const state = Object.create(null);
state.dashboards = Object.create(null);
state.alerts = [];
state.widgets = Object.create(null);
state.commandCenters = Object.create(null);
state.createdAt = Date.now();

/**
 * Security: Validate key is safe (no prototype pollution)
 */
function isSafeKey(key) {
  return typeof key === 'string' && 
         key !== '__proto__' && 
         key !== 'constructor' && 
         key !== 'prototype';
}

/**
 * Generate unique ID
 */
function generateId(prefix) {
  return `${prefix}-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
}

/**
 * Calculate φ-aligned frequency for layer
 */
function layerFrequency(layer) {
  return PHI_7 * Math.pow(PHI, layer - 9);
}

/**
 * Create a new dashboard
 */
function createDashboard(type, title, description, protocol, accessLevel = 5) {
  const dashboardId = generateId('dashboard');
  
  const dashboard = {
    dashboardId,
    type: DashboardType[type] || type,
    title,
    description,
    protocol,
    accessLevel,
    gridColumns: 12,
    gridRows: 8,
    widgets: [],
    alerts: [],
    createdAt: Date.now(),
    lastAccessed: Date.now(),
    activeSessions: 0
  };
  
  if (isSafeKey(dashboardId)) {
    state.dashboards[dashboardId] = dashboard;
  }
  
  return dashboard;
}

/**
 * Get dashboard by ID
 */
function getDashboard(dashboardId) {
  if (!isSafeKey(dashboardId)) return null;
  return state.dashboards[dashboardId] || null;
}

/**
 * List all dashboards
 */
function listDashboards(accessLevel = 9) {
  return Object.values(state.dashboards)
    .filter(d => d.accessLevel <= accessLevel)
    .map(d => ({
      dashboardId: d.dashboardId,
      type: d.type,
      title: d.title,
      widgetCount: d.widgets.length,
      alertCount: d.alerts.length,
      accessLevel: d.accessLevel
    }));
}

/**
 * Add widget to dashboard
 */
function addWidget(dashboardId, widgetType, title, dataSource, config = {}) {
  const dashboard = getDashboard(dashboardId);
  if (!dashboard) return null;
  
  const widgetId = generateId('widget');
  
  const widget = {
    widgetId,
    widgetType: WidgetType[widgetType] || widgetType,
    title,
    dataSource,
    refreshHz: config.refreshHz || PHI,
    position: {
      x: config.positionX || 0,
      y: config.positionY || 0
    },
    size: {
      width: config.width || 4,
      height: config.height || 3
    },
    config: config.extra || {},
    lastUpdate: Date.now(),
    dataCache: null,
    errorState: null
  };
  
  dashboard.widgets.push(widget);
  
  if (isSafeKey(widgetId)) {
    state.widgets[widgetId] = widget;
  }
  
  return widget;
}

/**
 * Update widget data
 */
function updateWidget(widgetId, data) {
  if (!isSafeKey(widgetId)) return null;
  
  const widget = state.widgets[widgetId];
  if (!widget) return null;
  
  widget.dataCache = data;
  widget.lastUpdate = Date.now();
  widget.errorState = null;
  
  return widget;
}

/**
 * Create dashboard alert
 */
function createAlert(dashboardId, severity, title, message, source) {
  const alertId = generateId('alert');
  
  const alert = {
    alertId,
    severity: AlertSeverity[severity] || severity,
    severityName: severity,
    title,
    message,
    source,
    timestamp: Date.now(),
    acknowledged: false,
    acknowledgedBy: null,
    acknowledgedAt: null
  };
  
  // Add to global alerts
  state.alerts.push(alert);
  
  // Add to specific dashboard if specified
  if (dashboardId) {
    const dashboard = getDashboard(dashboardId);
    if (dashboard) {
      dashboard.alerts.push(alert);
    }
  }
  
  return alert;
}

/**
 * Acknowledge an alert
 */
function acknowledgeAlert(alertId, by) {
  const alert = state.alerts.find(a => a.alertId === alertId);
  if (!alert) return null;
  
  alert.acknowledged = true;
  alert.acknowledgedBy = by;
  alert.acknowledgedAt = Date.now();
  
  return alert;
}

/**
 * Get dashboard system status
 */
function getSystemStatus() {
  const dashboards = Object.values(state.dashboards);
  const totalWidgets = dashboards.reduce((sum, d) => sum + d.widgets.length, 0);
  const unacknowledged = state.alerts.filter(a => !a.acknowledged).length;
  const critical = state.alerts.filter(
    a => a.severity >= AlertSeverity.CRITICAL && !a.acknowledged
  ).length;
  
  return {
    status: critical === 0 ? 'HEALTHY' : 'ALERT',
    dashboardCount: dashboards.length,
    totalWidgets,
    totalAlerts: state.alerts.length,
    unacknowledgedAlerts: unacknowledged,
    criticalAlerts: critical,
    frequencyHz: PHI_7,
    uptimeMs: Date.now() - state.createdAt
  };
}

/**
 * Initialize command centers
 */
function initializeCommandCenters() {
  // Primary Sovereign Command Center
  const primary = createDashboard(
    'TABULA_IMPERII',
    'CENTRUM PRIMARIUM — Primary Sovereign Command',
    'The primary command center for full organism control',
    'PROT-317-A',
    9
  );
  state.commandCenters['centrum-primarium'] = primary.dashboardId;
  
  // Operations Command Center
  const operations = createDashboard(
    'TABULA_OPERATIONIS',
    'CENTRUM OPERATIONIS — Operations Command',
    'Operational metrics and worker management',
    'PROT-317-B',
    7
  );
  state.commandCenters['centrum-operationis'] = operations.dashboardId;
  
  // Security Command Center
  const security = createDashboard(
    'TABULA_SECURITATIS',
    'CENTRUM SECURITATIS — Security Command',
    'Security monitoring and threat detection',
    'PROT-317-C',
    8
  );
  state.commandCenters['centrum-securitatis'] = security.dashboardId;
  
  return {
    primary: primary.dashboardId,
    operations: operations.dashboardId,
    security: security.dashboardId
  };
}

/**
 * Get command center status
 */
function getCommandCenterStatus() {
  const centers = {};
  
  for (const [name, dashboardId] of Object.entries(state.commandCenters)) {
    const dashboard = getDashboard(dashboardId);
    if (dashboard) {
      centers[name] = {
        dashboardId,
        title: dashboard.title,
        widgetCount: dashboard.widgets.length,
        alertCount: dashboard.alerts.length
      };
    }
  }
  
  return {
    centerCount: Object.keys(centers).length,
    centers,
    frequencyHz: PHI_8
  };
}

/**
 * Main message handler
 */
addEventListener('message', async (event) => {
  const { op, payload } = event.data || {};
  
  let result;
  
  try {
    switch (op) {
      case 'dashboard-create':
        result = createDashboard(
          payload.type,
          payload.title,
          payload.description,
          payload.protocol,
          payload.accessLevel
        );
        break;
        
      case 'dashboard-get':
        result = getDashboard(payload.dashboardId);
        break;
        
      case 'dashboard-list':
        result = listDashboards(payload.accessLevel);
        break;
        
      case 'dashboard-add-widget':
        result = addWidget(
          payload.dashboardId,
          payload.widgetType,
          payload.title,
          payload.dataSource,
          payload.config
        );
        break;
        
      case 'dashboard-update-widget':
        result = updateWidget(payload.widgetId, payload.data);
        break;
        
      case 'dashboard-alert':
        result = createAlert(
          payload.dashboardId,
          payload.severity,
          payload.title,
          payload.message,
          payload.source
        );
        break;
        
      case 'alert-acknowledge':
        result = acknowledgeAlert(payload.alertId, payload.by);
        break;
        
      case 'dashboard-status':
        result = getSystemStatus();
        break;
        
      case 'command-center-init':
        result = initializeCommandCenters();
        break;
        
      case 'command-center-status':
        result = getCommandCenterStatus();
        break;
        
      case 'ping':
        result = {
          worker: 'dashboard-worker.js',
          number: 51,
          name: 'TABULA IMPERII',
          protocol: 'PROT-311',
          frequencyHz: PHI_7,
          layer: 9,
          status: 'alive',
          timestamp: Date.now()
        };
        break;
        
      default:
        result = { error: `Unknown operation: ${op}` };
    }
  } catch (error) {
    result = { error: error.message };
  }
  
  postMessage({ op, result, timestamp: Date.now() });
});

// Export for testing
if (typeof module !== 'undefined') {
  module.exports = {
    DashboardType,
    WidgetType,
    AlertSeverity,
    createDashboard,
    getDashboard,
    listDashboards,
    addWidget,
    updateWidget,
    createAlert,
    getSystemStatus,
    initializeCommandCenters,
    getCommandCenterStatus,
    PHI,
    PHI_7,
    PHI_8
  };
}
