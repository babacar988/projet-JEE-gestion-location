<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>${unite!=null?'Modifier':'Nouvelle'} unité — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="unites"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">${unite!=null?'Modifier l\'unité':'Nouvelle unité'}</h1>
      <a href="${pageContext.request.contextPath}/logout" class="topbar-logout" onclick="return confirm('Déconnecter ?')">⏻ Déconnexion</a>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <span class="breadcrumb-sep">›</span>
        <a href="${pageContext.request.contextPath}/admin/unites">Unités</a>
        <span class="breadcrumb-sep">›</span>
        <span>${unite!=null?'Modifier':'Ajouter'}</span>
      </div>
      <c:if test="${not empty error}"><div class="alert alert-danger">⚠️ ${error}</div></c:if>
      <div class="card" style="max-width:900px">
        <div class="card-header"><h2 class="card-title">🚪 Informations de l'unité</h2></div>
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/admin/unites" method="post">
            <c:if test="${unite!=null}"><input type="hidden" name="id" value="${unite.id}"></c:if>
            <div class="form-grid" style="margin-bottom:20px">
              <div class="form-group">
                <label>Numéro de l'unité *</label>
                <input type="text" name="numero" class="form-control" value="${unite.numero}" placeholder="A101" required>
              </div>
              <div class="form-group">
                <label>Immeuble *</label>
                <select name="immeubleId" class="form-control" required>
                  <option value="">-- Sélectionner un immeuble --</option>
                  <c:forEach var="imm" items="${immeubles}">
                    <option value="${imm.id}" ${unite!=null && unite.immeuble.id==imm.id?'selected':''}>
                      ${imm.nom} — ${imm.ville}
                    </option>
                  </c:forEach>
                </select>
              </div>
              <div class="form-group">
                <label>Type d'unité</label>
                <select name="type" class="form-control">
                  <option value="APPARTEMENT" ${unite.type=='APPARTEMENT'?'selected':''}>Appartement</option>
                  <option value="STUDIO" ${unite.type=='STUDIO'?'selected':''}>Studio</option>
                  <option value="MAISON" ${unite.type=='MAISON'?'selected':''}>Maison</option>
                  <option value="BUREAU" ${unite.type=='BUREAU'?'selected':''}>Bureau</option>
                  <option value="COMMERCE" ${unite.type=='COMMERCE'?'selected':''}>Commerce</option>
                  <option value="ENTREPOT" ${unite.type=='ENTREPOT'?'selected':''}>Entrepôt</option>
                </select>
              </div>
              <div class="form-group">
                <label>Statut</label>
                <select name="statut" class="form-control">
                  <option value="DISPONIBLE" ${unite.statut=='DISPONIBLE'?'selected':''}>✅ Disponible</option>
                  <option value="OCCUPEE" ${unite.statut=='OCCUPEE'?'selected':''}>🔴 Occupée</option>
                  <option value="EN_TRAVAUX" ${unite.statut=='EN_TRAVAUX'?'selected':''}>🔧 En travaux</option>
                  <option value="RESERVEE" ${unite.statut=='RESERVEE'?'selected':''}>📌 Réservée</option>
                </select>
              </div>
              <div class="form-group">
                <label>Nombre de pièces</label>
                <input type="number" name="nombrePieces" class="form-control" value="${unite.nombrePieces}" min="0" placeholder="3">
              </div>
              <div class="form-group">
                <label>Superficie (m²)</label>
                <input type="number" name="superficie" class="form-control" value="${unite.superficie}" step="0.5" placeholder="65.5">
              </div>
              <div class="form-group">
                <label>Étage</label>
                <input type="number" name="etage" class="form-control" value="${unite.etage}" min="0" placeholder="2">
              </div>
              <div class="form-group">
                <label>Loyer mensuel (€) *</label>
                <input type="number" name="loyerMensuel" class="form-control" value="${unite.loyerMensuel}" step="0.01" placeholder="850.00" required>
              </div>
              <div class="form-group">
                <label>Charges mensuelles (€)</label>
                <input type="number" name="charges" class="form-control" value="${unite.charges}" step="0.01" placeholder="80.00">
              </div>
              <div class="form-group">
                <label>Dépôt de garantie (€)</label>
                <input type="number" name="depot" class="form-control" value="${unite.depot}" step="0.01" placeholder="1700.00">
              </div>
              <div class="form-group full">
                <label>Description</label>
                <textarea name="description" class="form-control" rows="3" placeholder="Description de l'unité...">${unite.description}</textarea>
              </div>
              <div class="form-group full">
                <label>Équipements</label>
                <input type="text" name="equipements" class="form-control" value="${unite.equipements}" placeholder="Cuisine équipée, Parking, Cave...">
              </div>
            </div>
            <div style="display:flex;gap:12px">
              <button type="submit" class="btn btn-gold">${unite!=null?'💾 Enregistrer':'＋ Créer l\'unité'}</button>
              <a href="${pageContext.request.contextPath}/admin/unites" class="btn btn-outline">Annuler</a>
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
