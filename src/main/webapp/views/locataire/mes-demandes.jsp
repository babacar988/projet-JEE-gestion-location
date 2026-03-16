<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>Mes demandes — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="mes-demandes"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Mes Demandes</h1>
      <div class="topbar-actions">
        <a href="${pageContext.request.contextPath}/locataire/offres" class="btn btn-gold btn-sm">＋ Nouvelle demande</a>
        <a href="${pageContext.request.contextPath}/logout" class="topbar-logout" onclick="return confirm('Déconnecter ?')">⏻ Déconnexion</a>
      </div>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/locataire/dashboard">Dashboard</a>
        <span class="breadcrumb-sep">›</span><span>Mes demandes</span>
      </div>
      <c:if test="${not empty success}"><div class="alert alert-success" data-auto-dismiss>✅ ${success}</div></c:if>
      <c:choose>
        <c:when test="${not empty demandes}">
          <div style="display:flex;flex-direction:column;gap:16px">
            <c:forEach var="d" items="${demandes}">
              <div class="card">
                <div class="card-header">
                  <div>
                    <h2 class="card-title" style="font-size:15px">N° ${d.unite.numero} — ${d.unite.immeuble.nom}</h2>
                    <div style="font-size:12px;color:var(--text-muted)">${d.unite.immeuble.ville} · ${d.dateDemande}</div>
                  </div>
                  <c:choose>
                    <c:when test="${d.statut=='EN_ATTENTE'}"><span class="badge badge-warning">⏳ En attente</span></c:when>
                    <c:when test="${d.statut=='ACCEPTEE'}"><span class="badge badge-success">✅ Acceptée</span></c:when>
                    <c:when test="${d.statut=='REFUSEE'}"><span class="badge badge-danger">❌ Refusée</span></c:when>
                    <c:otherwise><span class="badge badge-navy">Annulée</span></c:otherwise>
                  </c:choose>
                </div>
                <div class="card-body">
                  <c:if test="${not empty d.message}">
                    <div style="margin-bottom:12px">
                      <div class="detail-label">Votre message</div>
                      <p style="font-size:14px;color:var(--text-secondary);margin-top:4px">${d.message}</p>
                    </div>
                  </c:if>
                  <c:if test="${not empty d.reponse}">
                    <div style="padding:12px;background:${d.statut=='ACCEPTEE'?'var(--success-bg)':'var(--danger-bg)'};border-radius:var(--radius-sm)">
                      <div class="detail-label" style="color:${d.statut=='ACCEPTEE'?'var(--success)':'var(--danger)'}">Réponse du gestionnaire</div>
                      <p style="font-size:14px;margin-top:4px">${d.reponse}</p>
                    </div>
                  </c:if>
                  <c:if test="${d.statut=='EN_ATTENTE'}">
                    <a href="${pageContext.request.contextPath}/locataire/demande?action=annuler&id=${d.id}"
                       class="btn btn-danger btn-sm" style="margin-top:12px"
                       onclick="return confirm('Annuler cette demande ?')">🚫 Annuler</a>
                  </c:if>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:when>
        <c:otherwise>
          <div class="card">
            <div class="empty-state">
              <div class="empty-icon">📬</div>
              <div class="empty-title">Aucune demande</div>
              <div class="empty-text">Consultez les offres et envoyez votre première demande</div>
              <a href="${pageContext.request.contextPath}/locataire/offres" class="btn btn-gold">🔍 Voir les offres</a>
            </div>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>
<!-- MODALE DÉCO (incluse via navbar.jsp) -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body></html>
