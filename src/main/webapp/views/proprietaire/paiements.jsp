<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><title>Mes paiements — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">&#9776;</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="paiements"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Paiements reçus</h1>
      <div class="topbar-actions">
        <button class="btn-logout-topbar" onclick="openLogoutModal()">Déconnexion</button>
      </div>
    </div>
    <div class="page-content">

      <div class="stats-grid" style="margin-bottom:20px">
        <div class="stat-card">
          <div class="stat-icon green">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
          </div>
          <div class="stat-value"><fmt:formatNumber value="${totalPaye}" maxFractionDigits="0"/>€</div>
          <div class="stat-label">Total encaissé</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon gold">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
          </div>
          <div class="stat-value">${nbEnAttente}</div>
          <div class="stat-label">En attente</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon red">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
          </div>
          <div class="stat-value">${nbEnRetard}</div>
          <div class="stat-label">En retard</div>
        </div>
      </div>

      <div class="tabs">
        <button class="tab-btn active" onclick="switchTab('pt-all',this)">Tous</button>
        <button class="tab-btn" onclick="switchTab('pt-paye',this)">Encaissés</button>
        <button class="tab-btn" onclick="switchTab('pt-retard',this)">En retard</button>
      </div>

      <div class="card">
        <div id="pt-all" class="tab-content active">
          <div class="table-wrap"><table>
            <thead><tr><th>Référence</th><th>Locataire</th><th>Unité</th><th>Montant</th><th>Échéance</th><th>Paiement</th><th>Statut</th></tr></thead>
            <tbody>
            <c:choose>
              <c:when test="${empty paiements}">
                <tr><td colspan="7" style="text-align:center;padding:40px;color:var(--text-muted)">Aucun paiement</td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="p" items="${paiements}">
                  <tr>
                    <td style="font-family:monospace;font-size:12px">${p.reference}</td>
                    <td>
                      <div style="font-weight:500">${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}</div>
                      <div style="font-size:11px;color:var(--text-muted)">${p.contrat.locataire.email}</div>
                    </td>
                    <td style="font-size:12.5px">N° ${p.contrat.unite.numero} — ${p.contrat.unite.immeuble.nom}</td>
                    <td style="font-weight:600"><fmt:formatNumber value="${p.montant}" maxFractionDigits="0"/>€</td>
                    <td style="font-size:12px;color:var(--text-muted)">${p.dateEcheance}</td>
                    <td style="font-size:12px">${p.datePaiement != null ? p.datePaiement : '—'}</td>
                    <td>
                      <c:choose>
                        <c:when test="${p.statut == 'PAYE'}">      <span class="badge badge-success"><span class="badge-dot"></span>Encaissé</span></c:when>
                        <c:when test="${p.statut == 'EN_ATTENTE'}"><span class="badge badge-warning"><span class="badge-dot"></span>En attente</span></c:when>
                        <c:when test="${p.statut == 'EN_RETARD'}"> <span class="badge badge-danger"> <span class="badge-dot"></span>En retard</span></c:when>
                        <c:otherwise>                              <span class="badge badge-navy">${p.statut}</span></c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
            </tbody>
          </table></div>
        </div>

        <div id="pt-paye" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>Référence</th><th>Locataire</th><th>Unité</th><th>Montant</th><th>Date encaissement</th><th>Mode</th></tr></thead>
            <tbody>
            <c:set var="np" value="0"/>
            <c:forEach var="p" items="${paiements}">
              <c:if test="${p.statut == 'PAYE'}">
                <c:set var="np" value="${np+1}"/>
                <tr>
                  <td style="font-family:monospace;font-size:12px">${p.reference}</td>
                  <td style="font-weight:500">${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}</td>
                  <td>N° ${p.contrat.unite.numero} — ${p.contrat.unite.immeuble.nom}</td>
                  <td style="font-weight:600;color:var(--success)"><fmt:formatNumber value="${p.montant}" maxFractionDigits="0"/>€</td>
                  <td style="font-size:12px">${p.datePaiement}</td>
                  <td style="font-size:12px">${p.modePaiement}</td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${np==0}"><tr><td colspan="6" style="text-align:center;padding:36px;color:var(--text-muted)">Aucun paiement encaissé</td></tr></c:if>
            </tbody>
          </table></div>
        </div>

        <div id="pt-retard" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>Référence</th><th>Locataire</th><th>Unité</th><th>Montant</th><th>Échéance dépassée</th></tr></thead>
            <tbody>
            <c:set var="nr" value="0"/>
            <c:forEach var="p" items="${paiements}">
              <c:if test="${p.statut == 'EN_RETARD'}">
                <c:set var="nr" value="${nr+1}"/>
                <tr>
                  <td style="font-family:monospace;font-size:12px">${p.reference}</td>
                  <td style="font-weight:500">${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}</td>
                  <td>N° ${p.contrat.unite.numero} — ${p.contrat.unite.immeuble.nom}</td>
                  <td style="font-weight:600;color:var(--danger)"><fmt:formatNumber value="${p.montant}" maxFractionDigits="0"/>€</td>
                  <td style="font-size:12px;color:var(--danger)">${p.dateEcheance}</td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${nr==0}"><tr><td colspan="5" style="text-align:center;padding:36px;color:var(--text-muted)">Aucun paiement en retard</td></tr></c:if>
            </tbody>
          </table></div>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
