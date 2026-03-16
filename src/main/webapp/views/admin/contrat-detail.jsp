 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>Contrat ${contrat.reference} — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="contrats"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Contrat ${contrat.reference}</h1>
      <div class="topbar-actions">
        <a href="${pageContext.request.contextPath}/admin/contrats?action=modifier&id=${contrat.id}" class="btn btn-outline btn-sm">✏️ Modifier</a>
        <c:if test="${contrat.statut=='ACTIF'}">
          <a href="${pageContext.request.contextPath}/admin/contrats?action=resilier&id=${contrat.id}" class="btn btn-danger btn-sm"
             onclick="return confirm('Résilier ce contrat ?')">🚫 Résilier</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/logout" class="topbar-logout" onclick="return confirm('Déconnecter ?')">⏻ Déconnexion</a>
      </div>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <span class="breadcrumb-sep">›</span>
        <a href="${pageContext.request.contextPath}/admin/contrats">Contrats</a>
        <span class="breadcrumb-sep">›</span><span>${contrat.reference}</span>
      </div>
      <div style="display:grid;grid-template-columns:2fr 1fr;gap:24px">
        <!-- Détails -->
        <div>
          <div class="card" style="margin-bottom:24px">
            <div class="card-header"><h2 class="card-title">📋 Détails du contrat</h2>
              <c:choose>
                <c:when test="${contrat.statut=='ACTIF'}"><span class="badge badge-success">✅ Actif</span></c:when>
                <c:when test="${contrat.statut=='EN_ATTENTE'}"><span class="badge badge-warning">⏳ En attente</span></c:when>
                <c:when test="${contrat.statut=='RESILIE'}"><span class="badge badge-danger">❌ Résilié</span></c:when>
                <c:otherwise><span class="badge badge-navy">🏁 Terminé</span></c:otherwise>
              </c:choose>
            </div>
            <div class="card-body">
              <div class="detail-grid">
                <div class="detail-item"><div class="detail-label">Référence</div><div class="detail-value" style="font-family:monospace">${contrat.reference}</div></div>
                <div class="detail-item"><div class="detail-label">Date début</div><div class="detail-value">${contrat.dateDebut}</div></div>
                <div class="detail-item"><div class="detail-label">Date fin</div><div class="detail-value">${contrat.dateFin!=null?contrat.dateFin:'Indéterminée'}</div></div>
                <div class="detail-item"><div class="detail-label">Loyer mensuel</div>
                  <div class="detail-value" style="color:var(--gold);font-size:20px"><fmt:formatNumber value="${contrat.loyerMensuel}" maxFractionDigits="0"/>€</div></div>
                <div class="detail-item"><div class="detail-label">Charges</div><div class="detail-value">${contrat.chargesMensuelles!=null?contrat.chargesMensuelles:0}€/mois</div></div>
                <div class="detail-item"><div class="detail-label">Dépôt de garantie</div><div class="detail-value">${contrat.depotGarantie!=null?contrat.depotGarantie:0}€</div></div>
              </div>
              <c:if test="${not empty contrat.conditions}">
                <div style="margin-top:20px;padding:16px;background:var(--cream);border-radius:var(--radius-sm)">
                  <div class="detail-label">Conditions particulières</div>
                  <p style="margin-top:8px;font-size:14px;color:var(--text-secondary)">${contrat.conditions}</p>
                </div>
              </c:if>
            </div>
          </div>

          <!-- Paiements -->
          <div class="card">
            <div class="card-header">
              <h2 class="card-title">💰 Historique des paiements</h2>
              <a href="${pageContext.request.contextPath}/admin/paiements?action=nouveau&contratId=${contrat.id}" class="btn btn-gold btn-sm">＋ Enregistrer</a>
            </div>
            <c:choose>
              <c:when test="${not empty paiements}">
                <div class="table-wrap">
                  <table>
                    <thead><tr><th>Référence</th><th>Montant</th><th>Date</th><th>Échéance</th><th>Mode</th><th>Statut</th></tr></thead>
                    <tbody>
                    <c:forEach var="p" items="${paiements}">
                      <tr>
                        <td style="font-family:monospace;font-size:12px">${p.reference}</td>
                        <td style="font-weight:600"><fmt:formatNumber value="${p.montant}" maxFractionDigits="2"/>€</td>
                        <td>${p.datePaiement!=null?p.datePaiement:'—'}</td>
                        <td>${p.dateEcheance}</td>
                        <td>${p.modePaiement!=null?p.modePaiement:'—'}</td>
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
                <div class="empty-state" style="padding:32px">
                  <div style="font-size:36px">💳</div>
                  <div class="empty-title" style="font-size:16px">Aucun paiement enregistré</div>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- Sidebar info -->
        <div>
          <div class="card" style="margin-bottom:20px">
            <div class="card-header"><h2 class="card-title">🏠 Locataire</h2></div>
            <div class="card-body">
              <div style="text-align:center;margin-bottom:16px">
                <div class="user-avatar-lg" style="margin:0 auto 8px;width:52px;height:52px;font-size:18px">
                  ${contrat.locataire.prenom.charAt(0)}${contrat.locataire.nom.charAt(0)}
                </div>
                <div style="font-weight:600;font-size:16px">${contrat.locataire.nomComplet}</div>
                <div style="font-size:13px;color:var(--text-muted)">${contrat.locataire.email}</div>
                <div style="font-size:13px;color:var(--text-muted)">${contrat.locataire.telephone}</div>
              </div>
            </div>
          </div>
          <div class="card">
            <div class="card-header"><h2 class="card-title">🚪 Unité</h2></div>
            <div class="card-body">
              <div class="detail-item" style="margin-bottom:10px"><div class="detail-label">Numéro</div><div class="detail-value">N° ${contrat.unite.numero}</div></div>
              <div class="detail-item" style="margin-bottom:10px"><div class="detail-label">Immeuble</div><div class="detail-value">${contrat.unite.immeuble.nom}</div></div>
              <div class="detail-item" style="margin-bottom:10px"><div class="detail-label">Ville</div><div class="detail-value">${contrat.unite.immeuble.ville}</div></div>
              <div class="detail-item"><div class="detail-label">Type</div><div class="detail-value">${contrat.unite.type}</div></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- MODALE DÉCO (incluse via navbar.jsp) -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body></html>
