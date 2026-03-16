<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>Mes contrats — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="mes-contrats"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Mes Contrats</h1>
      <a href="${pageContext.request.contextPath}/logout" class="topbar-logout" onclick="return confirm('Déconnecter ?')">⏻ Déconnexion</a>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/locataire/dashboard">Dashboard</a>
        <span class="breadcrumb-sep">›</span><span>Mes contrats</span>
      </div>
      <c:choose>
        <c:when test="${not empty contrats}">
          <div style="display:flex;flex-direction:column;gap:20px">
            <c:forEach var="c" items="${contrats}">
              <div class="card">
                <div class="card-header">
                  <div>
                    <h2 class="card-title" style="font-size:15px">${c.reference}</h2>
                    <div style="font-size:12px;color:var(--text-muted)">Depuis le ${c.dateDebut}</div>
                  </div>
                  <c:choose>
                    <c:when test="${c.statut=='ACTIF'}"><span class="badge badge-success">✅ Actif</span></c:when>
                    <c:when test="${c.statut=='EN_ATTENTE'}"><span class="badge badge-warning">⏳ En attente</span></c:when>
                    <c:when test="${c.statut=='RESILIE'}"><span class="badge badge-danger">❌ Résilié</span></c:when>
                    <c:otherwise><span class="badge badge-navy">🏁 Terminé</span></c:otherwise>
                  </c:choose>
                </div>
                <div class="card-body">
                  <div class="detail-grid">
                    <div class="detail-item"><div class="detail-label">Logement</div>
                      <div class="detail-value">N° ${c.unite.numero} — ${c.unite.immeuble.nom}</div></div>
                    <div class="detail-item"><div class="detail-label">Adresse</div>
                      <div class="detail-value">${c.unite.immeuble.adresse}, ${c.unite.immeuble.ville}</div></div>
                    <div class="detail-item"><div class="detail-label">Loyer mensuel</div>
                      <div class="detail-value" style="color:var(--gold);font-size:20px;font-family:'Playfair Display',serif">
                        <fmt:formatNumber value="${c.loyerMensuel}" maxFractionDigits="0"/>€</div></div>
                    <div class="detail-item"><div class="detail-label">Charges</div>
                      <div class="detail-value">${c.chargesMensuelles!=null?c.chargesMensuelles:0}€/mois</div></div>
                    <div class="detail-item"><div class="detail-label">Dépôt de garantie</div>
                      <div class="detail-value">${c.depotGarantie!=null?c.depotGarantie:0}€</div></div>
                    <div class="detail-item"><div class="detail-label">Date de fin</div>
                      <div class="detail-value">${c.dateFin!=null?c.dateFin:'Non définie'}</div></div>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:when>
        <c:otherwise>
          <div class="card">
            <div class="empty-state">
              <div class="empty-icon">📝</div>
              <div class="empty-title">Aucun contrat</div>
              <div class="empty-text">Vous n'avez pas encore de contrat de location</div>
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
