<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>Rapports — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="rapports"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Rapports & Statistiques</h1>
      <a href="${pageContext.request.contextPath}/logout" class="topbar-logout" onclick="return confirm('Déconnecter ?')">⏻ Déconnexion</a>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <span class="breadcrumb-sep">›</span><span>Rapports</span>
      </div>

      <!-- KPIs globaux -->
      <div class="stats-grid" style="margin-bottom:32px">
        <div class="stat-card navy"><div class="stat-icon-wrap">🏗️</div>
          <div class="stat-value">${totalImmeubles}</div><div class="stat-label">Immeubles</div></div>
        <div class="stat-card gold"><div class="stat-icon-wrap">🚪</div>
          <div class="stat-value">${totalUnites}</div><div class="stat-label">Unités totales</div></div>
        <div class="stat-card success"><div class="stat-icon-wrap">📝</div>
          <div class="stat-value">${contratsActifs}</div><div class="stat-label">Contrats actifs</div></div>
        <div class="stat-card info"><div class="stat-icon-wrap">💰</div>
          <div class="stat-value"><fmt:formatNumber value="${revenuTotal}" maxFractionDigits="0"/>€</div>
          <div class="stat-label">Revenus totaux</div></div>
        <div class="stat-card"><div class="stat-icon-wrap">👥</div>
          <div class="stat-value">${totalLocataires}</div><div class="stat-label">Locataires</div></div>
        <div class="stat-card danger"><div class="stat-icon-wrap">⚠️</div>
          <div class="stat-value">${paiementsRetard}</div><div class="stat-label">Paiements en retard</div></div>
      </div>

      <div style="display:grid;grid-template-columns:1fr 1fr;gap:24px;margin-bottom:24px">

        <!-- Occupation -->
        <div class="card">
          <div class="card-header"><h2 class="card-title">📊 Taux d'occupation</h2></div>
          <div class="card-body">
            <%
              Long occ = (Long)request.getAttribute("unitesOccupees");
              Long dis = (Long)request.getAttribute("unitesDisponibles");
              Long trav = (Long)request.getAttribute("unitesEnTravaux");
              if(occ==null)occ=0L; if(dis==null)dis=0L; if(trav==null)trav=0L;
              long tot = occ+dis+trav;
              int pctOcc  = tot>0?(int)(occ*100/tot):0;
              int pctDis  = tot>0?(int)(dis*100/tot):0;
              int pctTrav = tot>0?(int)(trav*100/tot):0;
            %>
            <!-- Barre empilée -->
            <div style="height:20px;border-radius:10px;overflow:hidden;display:flex;margin-bottom:16px;background:var(--cream)">
              <div style="width:<%=pctOcc%>%;background:#2D7A4F;transition:width .6s"></div>
              <div style="width:<%=pctDis%>%;background:#C9A84C;transition:width .6s"></div>
              <div style="width:<%=pctTrav%>%;background:#B7660D;transition:width .6s"></div>
            </div>
            <div style="display:flex;flex-direction:column;gap:10px">
              <div style="display:flex;align-items:center;justify-content:space-between">
                <div style="display:flex;align-items:center;gap:8px">
                  <div style="width:12px;height:12px;border-radius:3px;background:#2D7A4F"></div>
                  <span style="font-size:13px">Occupées</span>
                </div>
                <div style="font-weight:600"><%=occ%> <span style="color:var(--text-muted);font-weight:400">(<%=pctOcc%>%)</span></div>
              </div>
              <div style="display:flex;align-items:center;justify-content:space-between">
                <div style="display:flex;align-items:center;gap:8px">
                  <div style="width:12px;height:12px;border-radius:3px;background:#C9A84C"></div>
                  <span style="font-size:13px">Disponibles</span>
                </div>
                <div style="font-weight:600"><%=dis%> <span style="color:var(--text-muted);font-weight:400">(<%=pctDis%>%)</span></div>
              </div>
              <div style="display:flex;align-items:center;justify-content:space-between">
                <div style="display:flex;align-items:center;gap:8px">
                  <div style="width:12px;height:12px;border-radius:3px;background:#B7660D"></div>
                  <span style="font-size:13px">En travaux</span>
                </div>
                <div style="font-weight:600"><%=trav%> <span style="color:var(--text-muted);font-weight:400">(<%=pctTrav%>%)</span></div>
              </div>
            </div>
          </div>
        </div>

        <!-- Revenus par mois (simulé) -->
        <div class="card">
          <div class="card-header"><h2 class="card-title">💰 Synthèse financière</h2></div>
          <div class="card-body">
            <div style="display:flex;flex-direction:column;gap:16px">
              <div style="padding:16px;background:var(--success-bg);border-radius:var(--radius-sm);display:flex;justify-content:space-between;align-items:center">
                <div><div style="font-size:12px;color:var(--success);font-weight:600;text-transform:uppercase;letter-spacing:1px">Revenus encaissés</div>
                  <div style="font-family:'Playfair Display',serif;font-size:26px;font-weight:700;color:var(--success)">
                    <fmt:formatNumber value="${revenuTotal}" maxFractionDigits="0"/>€</div></div>
                <span style="font-size:32px">✅</span>
              </div>
              <div style="padding:16px;background:var(--warning-bg);border-radius:var(--radius-sm);display:flex;justify-content:space-between;align-items:center">
                <div><div style="font-size:12px;color:var(--warning);font-weight:600;text-transform:uppercase;letter-spacing:1px">Loyers attendus/mois</div>
                  <div style="font-family:'Playfair Display',serif;font-size:26px;font-weight:700;color:var(--warning)">
                    <fmt:formatNumber value="${loyersAttendusMois}" maxFractionDigits="0"/>€</div></div>
                <span style="font-size:32px">📅</span>
              </div>
              <div style="padding:16px;background:var(--danger-bg);border-radius:var(--radius-sm);display:flex;justify-content:space-between;align-items:center">
                <div><div style="font-size:12px;color:var(--danger);font-weight:600;text-transform:uppercase;letter-spacing:1px">Impayés</div>
                  <div style="font-family:'Playfair Display',serif;font-size:26px;font-weight:700;color:var(--danger)">
                    ${paiementsRetard} paiement(s)</div></div>
                <span style="font-size:32px">⚠️</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Actions rapides -->
      <div class="card">
        <div class="card-header"><h2 class="card-title">⚡ Actions de gestion</h2></div>
        <div class="card-body">
          <div style="display:flex;flex-wrap:wrap;gap:12px">
            <a href="${pageContext.request.contextPath}/admin/immeubles" class="btn btn-primary">🏗️ Gérer les immeubles</a>
            <a href="${pageContext.request.contextPath}/admin/unites" class="btn btn-primary">🚪 Gérer les unités</a>
            <a href="${pageContext.request.contextPath}/admin/contrats" class="btn btn-primary">📝 Gérer les contrats</a>
            <a href="${pageContext.request.contextPath}/admin/paiements" class="btn btn-gold">💰 Gérer les paiements</a>
            <a href="${pageContext.request.contextPath}/admin/demandes" class="btn btn-outline">📬 Voir les demandes</a>
            <a href="${pageContext.request.contextPath}/admin/utilisateurs" class="btn btn-outline">👥 Gérer les utilisateurs</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- MODALE DÉCO (incluse via navbar.jsp) -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body></html>
