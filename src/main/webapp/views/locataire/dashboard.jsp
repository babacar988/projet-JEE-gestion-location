<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>Mon espace — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="dashboard"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Mon Espace Locataire</h1>
      <a href="${pageContext.request.contextPath}/logout" class="topbar-logout"
         onclick="return confirm('Voulez-vous vous déconnecter ?')">⏻ Déconnexion</a>
    </div>
    <div class="page-content">
      <div class="welcome-banner">
        <div class="welcome-title">Bienvenue, <span class="welcome-gold">${sessionScope.utilisateur.prenom}</span> 🏠</div>
        <div class="welcome-sub">Gérez vos locations et consultez vos paiements en un clin d'œil.</div>
      </div>
      <div class="stats-grid">
        <div class="stat-card gold"><div class="stat-icon-wrap">📝</div>
          <div class="stat-value">${contratsActifs}</div><div class="stat-label">Contrats actifs</div></div>
        <div class="stat-card success"><div class="stat-icon-wrap">✅</div>
          <div class="stat-value">${paiementsEffectues}</div><div class="stat-label">Paiements effectués</div></div>
        <div class="stat-card danger"><div class="stat-icon-wrap">⏰</div>
          <div class="stat-value">${paiementsEnAttente}</div><div class="stat-label">En attente</div></div>
        <div class="stat-card navy"><div class="stat-icon-wrap">📬</div>
          <div class="stat-value">${demandesEnCours}</div><div class="stat-label">Demandes en cours</div></div>
      </div>
      <div style="display:grid;grid-template-columns:1fr 1fr;gap:24px">
        <div class="card">
          <div class="card-header"><h2 class="card-title">🔍 Chercher un logement</h2></div>
          <div class="card-body">
            <p style="color:var(--text-muted);font-size:14px;margin-bottom:16px">Découvrez nos offres disponibles</p>
            <a href="${pageContext.request.contextPath}/locataire/offres" class="btn btn-gold" style="width:100%;justify-content:center">Voir les offres →</a>
          </div>
        </div>
        <div class="card">
          <div class="card-header"><h2 class="card-title">💳 Prochain paiement</h2></div>
          <div class="card-body">
            <c:choose>
              <c:when test="${prochain!=null}">
                <div style="text-align:center">
                  <div style="font-family:'Playfair Display',serif;font-size:36px;font-weight:700;color:var(--navy)">
                    <fmt:formatNumber value="${prochain.montant}" maxFractionDigits="2"/>€
                  </div>
                  <div style="color:var(--text-muted);font-size:13px;margin-top:6px">Échéance : ${prochain.dateEcheance}</div>
                  <span class="badge badge-warning" style="margin-top:12px">En attente</span>
                </div>
              </c:when>
              <c:otherwise>
                <div style="text-align:center;padding:20px">
                  <div style="font-size:32px">✅</div>
                  <div style="color:var(--text-muted);font-size:14px;margin-top:8px">Aucun paiement en attente</div>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- MODALE DÉCO (incluse via navbar.jsp) -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body></html>
