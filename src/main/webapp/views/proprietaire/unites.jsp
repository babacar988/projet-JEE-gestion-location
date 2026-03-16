<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><title>Mes unités — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">&#9776;</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="unites"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Mes unités</h1>
      <div class="topbar-actions">
        <a href="${pageContext.request.contextPath}/proprietaire/unite-form" class="btn btn-primary">+ Nouvelle unité</a>
        <button class="btn-logout-topbar" onclick="openLogoutModal()">Déconnexion</button>
      </div>
    </div>
    <div class="page-content">

      <!-- Stats rapides -->
      <div class="stats-grid" style="margin-bottom:20px">
        <div class="stat-card">
          <div class="stat-icon navy">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
          </div>
          <div class="stat-value">${unites.size()}</div>
          <div class="stat-label">Total unités</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon green">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
          </div>
          <c:set var="nbD" value="0"/>
          <c:forEach var="u" items="${unites}"><c:if test="${u.statut == 'DISPONIBLE'}"><c:set var="nbD" value="${nbD+1}"/></c:if></c:forEach>
          <div class="stat-value">${nbD}</div>
          <div class="stat-label">Disponibles</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon red">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
          </div>
          <c:set var="nbO" value="0"/>
          <c:forEach var="u" items="${unites}"><c:if test="${u.statut == 'OCCUPEE'}"><c:set var="nbO" value="${nbO+1}"/></c:if></c:forEach>
          <div class="stat-value">${nbO}</div>
          <div class="stat-label">Occupées</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon gold">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="4" y="2" width="16" height="20" rx="2"/><path d="M9 22v-4h6v4M8 6h.01M16 6h.01"/></svg>
          </div>
          <div class="stat-value">${immeubles.size()}</div>
          <div class="stat-label">Immeubles</div>
        </div>
      </div>

      <!-- Filtre par immeuble -->
      <div style="margin-bottom:16px;display:flex;align-items:center;gap:12px">
        <label class="form-label" style="margin:0;white-space:nowrap">Filtrer par immeuble :</label>
        <select id="filterImm" class="form-control" style="max-width:260px" onchange="filterByImm(this.value)">
          <option value="">Tous les immeubles</option>
          <c:forEach var="imm" items="${immeubles}">
            <option value="${imm.id}">${imm.nom} — ${imm.ville}</option>
          </c:forEach>
        </select>
      </div>

      <div class="card">
        <c:choose>
          <c:when test="${empty unites}">
            <div class="empty-state">
              <div class="empty-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg></div>
              <div class="empty-title">Aucune unité</div>
              <div class="empty-sub">Aucune unité enregistrée dans vos immeubles.</div>
              <a href="${pageContext.request.contextPath}/proprietaire/unite-form" class="btn btn-primary">Ajouter une unité</a>
            </div>
          </c:when>
          <c:otherwise>
            <div class="table-wrap">
              <table id="unitesTable">
                <thead><tr>
                  <th>N° / Étage</th><th>Immeuble</th><th>Type</th>
                  <th>Pièces</th><th>Surface</th><th>Loyer</th><th>Statut</th><th>Actions</th>
                </tr></thead>
                <tbody>
                <c:forEach var="u" items="${unites}">
                  <tr data-imm="${u.immeuble.id}">
                    <td><strong>N° ${u.numero}</strong>
                      <div style="font-size:11px;color:var(--text-muted)">
                        <c:choose><c:when test="${u.etage != null}">Étage ${u.etage}</c:when><c:otherwise>RDC</c:otherwise></c:choose>
                      </div>
                    </td>
                    <td>
                      <div style="font-weight:500">${u.immeuble.nom}</div>
                      <div style="font-size:11px;color:var(--text-muted)">${u.immeuble.ville}</div>
                    </td>
                    <td><span class="badge badge-navy">${u.type}</span></td>
                    <td><c:choose><c:when test="${u.nombrePieces != null}">${u.nombrePieces} p.</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                    <td><c:choose><c:when test="${u.superficie != null}">${u.superficie} m²</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                    <td style="font-weight:600"><fmt:formatNumber value="${u.loyerMensuel}" maxFractionDigits="0"/>€</td>
                    <td>
                      <c:choose>
                        <c:when test="${u.statut == 'DISPONIBLE'}"><span class="badge badge-success"><span class="badge-dot"></span>Disponible</span></c:when>
                        <c:when test="${u.statut == 'OCCUPEE'}">   <span class="badge badge-danger"> <span class="badge-dot"></span>Occupée</span></c:when>
                        <c:when test="${u.statut == 'EN_TRAVAUX'}"><span class="badge badge-warning"><span class="badge-dot"></span>Travaux</span></c:when>
                        <c:otherwise>                              <span class="badge badge-navy">${u.statut}</span></c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <a href="${pageContext.request.contextPath}/proprietaire/unite-form?id=${u.id}"
                         class="btn btn-outline btn-sm">Modifier</a>
                    </td>
                  </tr>
                </c:forEach>
                </tbody>
              </table>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<script>
function filterByImm(immId) {
  document.querySelectorAll('#unitesTable tbody tr').forEach(tr => {
    tr.style.display = (!immId || tr.dataset.imm === immId) ? '' : 'none';
  });
}
</script>
</body>
</html>
