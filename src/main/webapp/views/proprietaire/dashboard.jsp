<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><title>Mon espace — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">&#9776;</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="dashboard"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Tableau de bord</h1>
      <div class="topbar-actions">
        <span class="topbar-date"><%=new java.text.SimpleDateFormat("EEEE d MMMM yyyy",java.util.Locale.FRENCH).format(new java.util.Date())%></span>
        <button class="btn-logout-topbar" onclick="openLogoutModal()">Déconnexion</button>
      </div>
    </div>
    <div class="page-content">

      <div class="welcome-banner">
        <div class="welcome-title">Bonjour, <span class="welcome-gold">${sessionScope.utilisateur.prenom}</span></div>
        <div class="welcome-sub">Vue d'ensemble de votre patrimoine immobilier.</div>
      </div>

      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon navy">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="4" y="2" width="16" height="20" rx="2"/><path d="M9 22v-4h6v4M8 6h.01M16 6h.01M8 10h.01M16 10h.01"/></svg>
          </div>
          <div class="stat-value">${totalImmeubles}</div>
          <div class="stat-label">Immeubles</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon gold">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
          </div>
          <div class="stat-value">${totalUnites}</div>
          <div class="stat-label">Unités</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon green">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
          </div>
          <div class="stat-value">${contratsActifs}</div>
          <div class="stat-label">Contrats actifs</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon green">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
          </div>
          <div class="stat-value"><fmt:formatNumber value="${totalRevenu}" maxFractionDigits="0"/>€</div>
          <div class="stat-label">Revenus encaissés</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon red">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
          </div>
          <div class="stat-value">${paiementsEnRetard}</div>
          <div class="stat-label">Paiements en retard</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon blue">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/></svg>
          </div>
          <div class="stat-value">${totalLocataires}</div>
          <div class="stat-label">Locataires</div>
        </div>
      </div>

      <%-- Taux occupation --%>
      <%
        Long occ = (Long)request.getAttribute("unitesOccupees");
        Long dis = (Long)request.getAttribute("unitesDisponibles");
        if(occ==null)occ=0L; if(dis==null)dis=0L;
        long tot = occ + dis; int pct = tot>0?(int)(occ*100/tot):0;
      %>
      <div class="card" style="margin-bottom:20px">
        <div class="card-header">
          <span class="card-title">Taux d'occupation</span>
          <span style="font-size:22px;font-weight:700;color:var(--navy)"><%=pct%>%</span>
        </div>
        <div class="card-body">
          <div class="progress-bar-wrap"><div class="progress-bar" style="width:<%=pct%>%"></div></div>
          <div style="display:flex;gap:24px;margin-top:12px;font-size:12.5px;color:var(--text-muted)">
            <span>Occupées <strong style="color:var(--text-primary)"><%=occ%></strong></span>
            <span>Disponibles <strong style="color:var(--text-primary)"><%=dis%></strong></span>
          </div>
        </div>
      </div>

      <!-- Accès rapides -->
      <div class="card">
        <div class="card-header"><span class="card-title">Accès rapides</span></div>
        <div class="card-body" style="display:flex;flex-wrap:wrap;gap:10px">
          <a href="${pageContext.request.contextPath}/proprietaire/immeubles"          class="btn btn-primary">Mes immeubles</a>
          <a href="${pageContext.request.contextPath}/proprietaire/immeuble-form"      class="btn btn-primary">Ajouter un immeuble</a>
          <a href="${pageContext.request.contextPath}/proprietaire/unites"             class="btn btn-outline">Mes unités</a>
          <a href="${pageContext.request.contextPath}/proprietaire/contrats"           class="btn btn-outline">Mes contrats</a>
          <a href="${pageContext.request.contextPath}/proprietaire/paiements"          class="btn btn-outline">Paiements reçus</a>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
