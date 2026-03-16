/* ImmoGest — main.js */

/* Sidebar */
function toggleSidebar() {
  document.getElementById('sidebar')?.classList.toggle('open');
  document.getElementById('sidebarOverlay')?.classList.toggle('active');
}

/* Tabs */
function switchTab(tabId, btn) {
  document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
  document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
  document.getElementById(tabId)?.classList.add('active');
  btn?.classList.add('active');
}

/* Modale déconnexion */
function openLogoutModal() {
  document.getElementById('logoutModal')?.classList.add('active');
}
function closeLogoutModal(e) {
  if (e && e.target !== document.getElementById('logoutModal')) return;
  document.getElementById('logoutModal')?.classList.remove('active');
}
document.addEventListener('keydown', e => {
  if (e.key === 'Escape') document.getElementById('logoutModal')?.classList.remove('active');
});

/* Modal générique */
function openModal(id)  { document.getElementById(id)?.classList.add('active'); }
function closeModal(id) { document.getElementById(id)?.classList.remove('active'); }

/* Auto-dismiss alerts */
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('[data-dismiss]').forEach(el => {
    setTimeout(() => { el.style.opacity = '0'; el.style.transition = 'opacity .4s'; }, 3500);
    setTimeout(() => el.remove(), 4000);
  });

  /* Nav active state */
  const path = window.location.pathname;
  document.querySelectorAll('.nav-link[href]').forEach(l => {
    if (path.includes(l.getAttribute('href'))) l.classList.add('active');
  });
});

/* Confirmation suppression */
function confirmDelete(msg) { return confirm(msg || 'Supprimer cet élément ?'); }

/* Remplissage formulaire login (démo) */
function fillLogin(email, pwd) {
  const e = document.getElementById('email');
  const p = document.getElementById('password');
  if (e) e.value = email;
  if (p) p.value = pwd;
}
