<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>${contrat!=null?'Modifier':'Nouveau'} contrat — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="contrats"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">${contrat!=null?'Modifier le contrat':'Nouveau contrat'}</h1>
      <a href="${pageContext.request.contextPath}/logout" class="topbar-logout" onclick="return confirm('Déconnecter ?')">⏻ Déconnexion</a>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <span class="breadcrumb-sep">›</span>
        <a href="${pageContext.request.contextPath}/admin/contrats">Contrats</a>
        <span class="breadcrumb-sep">›</span><span>${contrat!=null?'Modifier':'Créer'}</span>
      </div>
      <c:if test="${not empty error}"><div class="alert alert-danger">⚠️ ${error}</div></c:if>
      <div class="card" style="max-width:860px">
        <div class="card-header"><h2 class="card-title">📝 Informations du contrat</h2></div>
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/admin/contrats" method="post">
            <c:if test="${contrat!=null}"><input type="hidden" name="id" value="${contrat.id}"></c:if>
            <div class="form-grid" style="margin-bottom:20px">
              <div class="form-group">
                <label>Locataire *</label>
                <select name="locataireId" class="form-control" required>
                  <option value="">-- Sélectionner un locataire --</option>
                  <c:forEach var="l" items="${locataires}">
                    <option value="${l.id}" ${contrat!=null&&contrat.locataire.id==l.id?'selected':''}>
                      ${l.nomComplet} (${l.email})
                    </option>
                  </c:forEach>
                </select>
              </div>
              <div class="form-group">
                <label>Unité de location *</label>
                <select name="uniteId" class="form-control" required>
                  <option value="">-- Sélectionner une unité --</option>
                  <c:forEach var="u" items="${unites}">
                    <option value="${u.id}" ${contrat!=null&&contrat.unite.id==u.id?'selected':''}>
                      N°${u.numero} — ${u.immeuble.nom} (${u.immeuble.ville})
                    </option>
                  </c:forEach>
                </select>
              </div>
              <div class="form-group">
                <label>Date de début *</label>
                <input type="date" name="dateDebut" class="form-control" value="${contrat.dateDebut}" required>
              </div>
              <div class="form-group">
                <label>Date de fin</label>
                <input type="date" name="dateFin" class="form-control" value="${contrat.dateFin}">
              </div>
              <div class="form-group">
                <label>Loyer mensuel (€) *</label>
                <input type="number" name="loyerMensuel" class="form-control" value="${contrat.loyerMensuel}" step="0.01" required>
              </div>
              <div class="form-group">
                <label>Charges mensuelles (€)</label>
                <input type="number" name="chargesMensuelles" class="form-control" value="${contrat.chargesMensuelles}" step="0.01">
              </div>
              <div class="form-group">
                <label>Dépôt de garantie (€)</label>
                <input type="number" name="depotGarantie" class="form-control" value="${contrat.depotGarantie}" step="0.01">
              </div>
              <div class="form-group">
                <label>Statut</label>
                <select name="statut" class="form-control">
                  <option value="EN_ATTENTE" ${contrat.statut=='EN_ATTENTE'?'selected':''}>⏳ En attente</option>
                  <option value="ACTIF" ${contrat.statut=='ACTIF'||contrat==null?'selected':''}>✅ Actif</option>
                  <option value="TERMINE" ${contrat.statut=='TERMINE'?'selected':''}>🏁 Terminé</option>
                  <option value="RESILIE" ${contrat.statut=='RESILIE'?'selected':''}>❌ Résilié</option>
                </select>
              </div>
              <div class="form-group full">
                <label>Conditions particulières</label>
                <textarea name="conditions" class="form-control" rows="4" placeholder="Clauses spéciales, conditions...">${contrat.conditions}</textarea>
              </div>
            </div>
            <div style="display:flex;gap:12px">
              <button type="submit" class="btn btn-gold">${contrat!=null?'💾 Enregistrer':'＋ Créer le contrat'}</button>
              <a href="${pageContext.request.contextPath}/admin/contrats" class="btn btn-outline">Annuler</a>
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
