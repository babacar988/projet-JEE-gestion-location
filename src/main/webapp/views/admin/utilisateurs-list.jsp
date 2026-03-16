<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>Utilisateurs — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="utilisateurs"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Gestion des Utilisateurs</h1>
      <div class="topbar-actions">
        <a href="${pageContext.request.contextPath}/admin/utilisateurs?action=nouveau" class="btn btn-gold btn-sm">＋ Ajouter</a>
        <a href="${pageContext.request.contextPath}/logout" class="topbar-logout" onclick="return confirm('Déconnecter ?')">⏻ Déconnexion</a>
      </div>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <span class="breadcrumb-sep">›</span><span>Utilisateurs</span>
      </div>
      <c:if test="${not empty success}"><div class="alert alert-success" data-auto-dismiss>✅ ${success}</div></c:if>

      <div class="tabs">
        <button class="tab-btn active" onclick="filterUsers('tous',this)">Tous (${utilisateurs.size()})</button>
        <button class="tab-btn" onclick="filterUsers('ADMIN',this)">👔 Admins</button>
        <button class="tab-btn" onclick="filterUsers('PROPRIETAIRE',this)">🏗️ Propriétaires</button>
        <button class="tab-btn" onclick="filterUsers('LOCATAIRE',this)">🏠 Locataires</button>
      </div>

      <div class="card">
        <div class="card-header"><h2 class="card-title">👥 Tous les utilisateurs</h2></div>
        <c:choose>
          <c:when test="${not empty utilisateurs}">
            <div class="table-wrap">
              <table id="usersTable">
                <thead><tr>
                  <th>Utilisateur</th><th>Email</th><th>Téléphone</th>
                  <th>Rôle</th><th>Statut</th><th>Inscription</th><th>Actions</th>
                </tr></thead>
                <tbody>
                <c:forEach var="u" items="${utilisateurs}">
                  <tr data-role="${u.role}">
                    <td>
                      <div style="display:flex;align-items:center;gap:10px">
                        <div class="avatar">${u.prenom.charAt(0)}${u.nom.charAt(0)}</div>
                        <div>
                          <div style="font-weight:500">${u.nomComplet}</div>
                          <div style="font-size:11px;color:var(--text-muted)">ID #${u.id}</div>
                        </div>
                      </div>
                    </td>
                    <td>${u.email}</td>
                    <td>${u.telephone!=null?u.telephone:'—'}</td>
                    <td>
                      <c:choose>
                        <c:when test="${u.role=='ADMIN'}"><span class="badge badge-navy">👔 Admin</span></c:when>
                        <c:when test="${u.role=='PROPRIETAIRE'}"><span class="badge badge-gold">🏗️ Propriétaire</span></c:when>
                        <c:otherwise><span class="badge badge-info">🏠 Locataire</span></c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${u.actif}"><span class="badge badge-success">● Actif</span></c:when>
                        <c:otherwise><span class="badge badge-danger">● Inactif</span></c:otherwise>
                      </c:choose>
                    </td>
                    <td style="font-size:12px;color:var(--text-muted)">${u.dateCreation}</td>
                    <td>
                      <div style="display:flex;gap:6px">
                        <a href="${pageContext.request.contextPath}/admin/utilisateurs?action=modifier&id=${u.id}" class="btn btn-outline btn-sm">✏️</a>
                        <c:if test="${u.actif}">
                          <a href="${pageContext.request.contextPath}/admin/utilisateurs?action=desactiver&id=${u.id}"
                             class="btn btn-danger btn-sm" onclick="return confirm('Désactiver ?')">🚫</a>
                        </c:if>
                        <c:if test="${!u.actif}">
                          <a href="${pageContext.request.contextPath}/admin/utilisateurs?action=activer&id=${u.id}"
                             class="btn btn-outline btn-sm" onclick="return confirm('Réactiver ?')">✅</a>
                        </c:if>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
                </tbody>
              </table>
            </div>
          </c:when>
          <c:otherwise>
            <div class="empty-state">
              <div class="empty-icon">👥</div>
              <div class="empty-title">Aucun utilisateur</div>
              <a href="${pageContext.request.contextPath}/admin/utilisateurs?action=nouveau" class="btn btn-gold">＋ Ajouter</a>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</div>
<!-- MODALE DÉCO (incluse via navbar.jsp) -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<script>
function filterUsers(role,btn){
  document.querySelectorAll('.tab-btn').forEach(b=>b.classList.remove('active'));
  btn.classList.add('active');
  document.querySelectorAll('#usersTable tbody tr').forEach(r=>{
    r.style.display=(role==='tous'||r.dataset.role===role)?'':'none';
  });
}
</script>
</body></html>
