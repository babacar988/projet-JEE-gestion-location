<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>Enregistrer un paiement — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="paiements"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Enregistrer un paiement</h1>
      <a href="${pageContext.request.contextPath}/logout" class="topbar-logout" onclick="return confirm('Déconnecter ?')">⏻ Déconnexion</a>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <span class="breadcrumb-sep">›</span>
        <a href="${pageContext.request.contextPath}/admin/paiements">Paiements</a>
        <span class="breadcrumb-sep">›</span><span>Nouveau</span>
      </div>
      <c:if test="${not empty error}"><div class="alert alert-danger">⚠️ ${error}</div></c:if>
      <div class="card" style="max-width:700px">
        <div class="card-header"><h2 class="card-title">💰 Nouveau paiement</h2></div>
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/admin/paiements" method="post">
            <c:if test="${paiement!=null}"><input type="hidden" name="id" value="${paiement.id}"></c:if>
            <div class="form-grid" style="margin-bottom:20px">
              <div class="form-group full">
                <label>Contrat *</label>
                <select name="contratId" class="form-control" required>
                  <option value="">-- Sélectionner un contrat --</option>
                  <c:forEach var="c" items="${contrats}">
                    <option value="${c.id}" ${paiement!=null&&paiement.contrat.id==c.id?'selected':''}
                            ${param.contratId==c.id?'selected':''}>
                      ${c.reference} — ${c.locataire.nomComplet} (${c.unite.immeuble.nom})
                    </option>
                  </c:forEach>
                </select>
              </div>
              <div class="form-group">
                <label>Montant (€) *</label>
                <input type="number" name="montant" class="form-control" value="${paiement.montant}" step="0.01" placeholder="850.00" required>
              </div>
              <div class="form-group">
                <label>Date d'échéance *</label>
                <input type="date" name="dateEcheance" class="form-control" value="${paiement.dateEcheance}" required>
              </div>
              <div class="form-group">
                <label>Statut</label>
                <select name="statut" class="form-control">
                  <option value="PAYE">✅ Payé</option>
                  <option value="EN_ATTENTE">⏳ En attente</option>
                  <option value="EN_RETARD">⚠️ En retard</option>
                </select>
              </div>
              <div class="form-group">
                <label>Mode de paiement</label>
                <select name="modePaiement" class="form-control">
                  <option value="">-- Non renseigné --</option>
                  <option value="VIREMENT">💸 Virement</option>
                  <option value="CHEQUE">📄 Chèque</option>
                  <option value="ESPECES">💵 Espèces</option>
                  <option value="PRELEVEMENT">🔄 Prélèvement</option>
                  <option value="CARTE">💳 Carte</option>
                </select>
              </div>
              <div class="form-group full">
                <label>Notes</label>
                <textarea name="notes" class="form-control" rows="3" placeholder="Notes éventuelles...">${paiement.notes}</textarea>
              </div>
            </div>
            <div style="display:flex;gap:12px">
              <button type="submit" class="btn btn-gold">💾 Enregistrer le paiement</button>
              <a href="${pageContext.request.contextPath}/admin/paiements" class="btn btn-outline">Annuler</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- MODALE DÉCO (incluse via navbar.jsp) -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body></html>
