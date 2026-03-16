<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>Mes paiements — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="mes-paiements"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Mes Paiements</h1>
      <a href="${pageContext.request.contextPath}/logout" class="topbar-logout" onclick="return confirm('Déconnecter ?')">⏻ Déconnexion</a>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/locataire/dashboard">Dashboard</a>
        <span class="breadcrumb-sep">›</span><span>Mes paiements</span>
      </div>

      <div class="stats-grid" style="margin-bottom:24px">
        <div class="stat-card success"><div class="stat-icon-wrap">✅</div>
          <div class="stat-value">${nbPayes}</div><div class="stat-label">Payés</div></div>
        <div class="stat-card warning"><div class="stat-icon-wrap">⏳</div>
          <div class="stat-value">${nbEnAttente}</div><div class="stat-label">En attente</div></div>
        <div class="stat-card danger"><div class="stat-icon-wrap">⚠️</div>
          <div class="stat-value">${nbEnRetard}</div><div class="stat-label">En retard</div></div>
      </div>

      <div class="card">
        <div class="card-header"><h2 class="card-title">💳 Historique de mes paiements</h2></div>
        <c:choose>
          <c:when test="${not empty paiements}">
            <div class="table-wrap">
              <table>
                <thead><tr><th>Référence</th><th>Contrat</th><th>Montant</th><th>Échéance</th><th>Date paiement</th><th>Statut</th></tr></thead>
                <tbody>
                <c:forEach var="p" items="${paiements}">
                  <tr>
                    <td style="font-family:monospace;font-size:12px">${p.reference}</td>
                    <td style="font-size:12px;color:var(--text-muted)">${p.contrat.reference}</td>
                    <td style="font-weight:700;color:var(--navy)"><fmt:formatNumber value="${p.montant}" maxFractionDigits="2"/>€</td>
                    <td>${p.dateEcheance}</td>
                    <td>${p.datePaiement!=null?p.datePaiement:'—'}</td>
                    <td>
                      <c:choose>
                        <c:when test="${p.statut=='PAYE'}"><span class="badge badge-success">✅ Payé</span></c:when>
                        <c:when test="${p.statut=='EN_ATTENTE'}"><span class="badge badge-warning">⏳ En attente</span></c:when>
                        <c:when test="${p.statut=='EN_RETARD'}"><span class="badge badge-danger">⚠️ Retard</span></c:when>
                        <c:otherwise><span class="badge badge-navy">Annulé</span></c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
                </tbody>
              </table>
            </div>
          </c:when>
          <c:otherwise>
            <div class="empty-state">
              <div class="empty-icon">💳</div>
              <div class="empty-title">Aucun paiement</div>
              <div class="empty-text">L'historique de vos paiements apparaîtra ici</div>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</div>
<!-- MODALE DÉCO (incluse via navbar.jsp) -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body></html>
