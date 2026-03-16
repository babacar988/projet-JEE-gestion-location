<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><title>Tableau de bord — ImmoGest</title>
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
        <button class="btn-logout-topbar" onclick="openLogoutModal()">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
          Déconnexion
        </button>
      </div>
    </div>

    <div class="page-content">
      <div class="welcome-banner">
        <div class="welcome-title">Bonjour, <span class="welcome-gold">${sessionScope.utilisateur.prenom}</span></div>
        <div class="welcome-sub">Voici un aperçu de votre activité aujourd'hui.</div>
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
          <div class="stat-label">Unités totales</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon green">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
          </div>
          <div class="stat-value">${unitesDisponibles}</div>
          <div class="stat-label">Disponibles</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon blue">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
          </div>
          <div class="stat-value">${contratsActifs}</div>
          <div class="stat-label">Contrats actifs</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon red">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
          </div>
          <div class="stat-value">${paiementsEnRetard}</div>
          <div class="stat-label">Paiements en retard</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon gold">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
          </div>
          <div class="stat-value"><fmt:formatNumber value="${totalRevenu}" maxFractionDigits="0"/>€</div>
          <div class="stat-label">Revenus encaissés</div>
        </div>
      </div>

      <!-- Occupation -->
      <%
        Long occ = (Long)request.getAttribute("unitesOccupees");
        Long dis = (Long)request.getAttribute("unitesDisponibles");
        if(occ==null) occ=0L; if(dis==null) dis=0L;
        long tot = occ + dis;
        int pct = tot > 0 ? (int)(occ * 100 / tot) : 0;
      %>
      <div class="card" style="margin-bottom:20px">
        <div class="card-header">
          <span class="card-title">Taux d'occupation</span>
          <span style="font-size:22px;font-weight:700;color:var(--navy)"><%=pct%>%</span>
        </div>
        <div class="card-body">
          <div class="progress-bar-wrap">
            <div class="progress-bar" style="width:<%=pct%>%"></div>
          </div>
          <div style="display:flex;gap:20px;margin-top:12px;font-size:12.5px;color:var(--text-muted)">
            <span>Occupées&nbsp;<strong style="color:var(--text-primary)"><%=occ%></strong></span>
            <span>Disponibles&nbsp;<strong style="color:var(--text-primary)"><%=dis%></strong></span>
            <span>Total&nbsp;<strong style="color:var(--text-primary)"><%=tot%></strong></span>
          </div>
        </div>
      </div>

      <!-- Actions rapides -->
      <div class="card">
        <div class="card-header"><span class="card-title">Actions rapides</span></div>
        <div class="card-body" style="display:flex;flex-wrap:wrap;gap:10px">
          <a href="${pageContext.request.contextPath}/admin/immeubles?action=nouveau" class="btn btn-primary">Nouvel immeuble</a>
          <a href="${pageContext.request.contextPath}/admin/unites?action=nouveau"    class="btn btn-primary">Nouvelle unité</a>
          <a href="${pageContext.request.contextPath}/admin/contrats?action=nouveau"  class="btn btn-outline">Nouveau contrat</a>
          <a href="${pageContext.request.contextPath}/admin/paiements?action=nouveau" class="btn btn-outline">Saisir paiement</a>
          <a href="${pageContext.request.contextPath}/admin/demandes"                 class="btn btn-outline">Voir les demandes</a>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
