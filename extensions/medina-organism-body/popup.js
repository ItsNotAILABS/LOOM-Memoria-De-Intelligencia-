// Medina Organism Body — Popup Script
document.addEventListener('DOMContentLoaded', () => {
    chrome.runtime.sendMessage({ type: 'MEDINA_STATUS' }, (response) => {
        const el = document.getElementById('status');
        if (response && response.status === 'active') {
            el.textContent = 'Active — ' + response.latinName;
            el.style.color = '#00ff88';
        } else {
            el.textContent = 'Inactive';
            el.style.color = '#ff4444';
        }
    });
});
