// Medina Edge AI Assistant — Popup Script

function paintStatus(response) {
  const statusEl = document.getElementById('status');
  const queueEl = document.getElementById('queue');
  const adaptersEl = document.getElementById('adapters');
  const toggleBtn = document.getElementById('toggleOffline');

  if (!response || response.status !== 'active') {
    statusEl.textContent = 'Inactive';
    statusEl.style.color = '#ff4444';
    return;
  }

  statusEl.textContent = `Active — ${response.latinName}`;
  statusEl.style.color = '#00ff88';

  queueEl.textContent = `${response.offline.queued} (${response.offline.enabled ? 'offline mode' : 'live'})`;
  toggleBtn.textContent = response.offline.enabled ? 'Disable Offline' : 'Enable Offline';

  adaptersEl.innerHTML = '';
  Object.entries(response.adapters || {}).forEach(([name, state]) => {
    const div = document.createElement('div');
    div.className = 'adapter';
    div.textContent = `${name}: ${state}`;
    adaptersEl.appendChild(div);
  });
}

function refreshStatus() {
  chrome.runtime.sendMessage({ type: 'MEDINA_STATUS' }, (response) => {
    paintStatus(response);
  });
}

document.addEventListener('DOMContentLoaded', () => {
  refreshStatus();

  document.getElementById('toggleOffline').addEventListener('click', () => {
    chrome.runtime.sendMessage({ type: 'MEDINA_STATUS' }, (status) => {
      const next = !status?.offline?.enabled;
      chrome.runtime.sendMessage({ type: 'MEDINA_TOGGLE_OFFLINE', enabled: next }, () => {
        refreshStatus();
      });
    });
  });

  document.getElementById('syncNow').addEventListener('click', () => {
    chrome.runtime.sendMessage({ type: 'MEDINA_SYNC_NOW' }, () => {
      refreshStatus();
    });
  });
});
