<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>${immeuble!=null?'Modifier':'Ajouter'} immeuble — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="immeubles"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">${immeuble!=null?'Modifier l\'immeuble':'Nouvel immeuble'}</h1>
      <a href="${pageContext.request.contextPath}/logout" class="topbar-logout"
         onclick="return confirm('Voulez-vous vous déconnecter ?')">⏻ Déconnexion</a>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <span class="breadcrumb-sep">›</span>
        <a href="${pageContext.request.contextPath}/admin/immeubles">Immeubles</a>
        <span class="breadcrumb-sep">›</span><span>${immeuble!=null?'Modifier':'Ajouter'}</span>
      </div>
      <c:if test="${not empty error}"><div class="alert alert-danger">⚠️ ${error}</div></c:if>
      <div class="card" style="max-width:860px">
        <div class="card-header"><h2 class="card-title">🏢 Informations de l'immeuble</h2></div>
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/admin/immeubles" method="post">
            <c:if test="${immeuble!=null}"><input type="hidden" name="id" value="${immeuble.id}"></c:if>
            <div class="form-grid" style="margin-bottom:20px">
              <div class="form-group">
                <label>Nom de l'immeuble *</label>
                <input type="text" name="nom" class="form-control" value="${immeuble.nom}" placeholder="Résidence Les Pins" required>
              </div>
              <div class="form-group">
                <label>Type</label>
                <select name="type" class="form-control">
                  <option value="RESIDENTIEL" ${immeuble.type=='RESIDENTIEL'?'selected':''}>Résidentiel</option>
                  <option value="COMMERCIAL" ${immeuble.type=='COMMERCIAL'?'selected':''}>Commercial</option>
                  <option value="MIXTE" ${immeuble.type=='MIXTE'?'selected':''}>Mixte</option>
                  <option value="INDUSTRIEL" ${immeuble.type=='INDUSTRIEL'?'selected':''}>Industriel</option>
                </select>
              </div>
              <div class="form-group">
                <label>Adresse *</label>
                <input type="text" name="adresse" class="form-control" value="${immeuble.adresse}" placeholder="12 rue de la Paix" required>
              </div>
              <div class="form-group">
                <label>Ville *</label>
                <input type="text" name="ville" class="form-control" value="${immeuble.ville}" placeholder="Paris" required>
              </div>
              <div class="form-group">
                <label>Code postal</label>
                <input type="text" name="codePostal" class="form-control" value="${immeuble.codePostal}" placeholder="75001">
              </div>
              <div class="form-group">
                <label>Nombre d'étages</label>
                <input type="number" name="nombreEtages" class="form-control" value="${immeuble.nombreEtages}" min="0">
              </div>
              <div class="form-group">
                <label>Année de construction</label>
                <input type="number" name="anneeConstruction" class="form-control" value="${immeuble.anneeConstruction}" placeholder="1995">
              </div>
              <div class="form-group">
                <label>Propriétaire</label>
                <select name="proprietaireId" class="form-control">
                  <option value="">-- Sélectionner --</option>
                  <c:forEach var="p" items="${proprietaires}">
                    <option value="${p.id}" ${immeuble!=null&&immeuble.proprietaire!=null&&immeuble.proprietaire.id==p.id?'selected':''}>
                      ${p.nomComplet} (${p.email})
                    </option>
                  </c:forEach>
                </select>
              </div>
              <div class="form-group full">
                <label>Description</label>
                <textarea name="description" class="form-control" rows="3" placeholder="Description de l'immeuble...">${immeuble.description}</textarea>
              </div>
              <div class="form-group full">
                <label>Équipements</label>
                <input type="text" name="equipements" class="form-control" value="${immeuble.equipements}" placeholder="Parking, Ascenseur, Digicode...">
              </div>
            </div>
            <div style="display:flex;gap:12px">
              <button type="submit" class="btn btn-gold">${immeuble!=null?'💾 Enregistrer':'＋ Créer l\'immeuble'}</button>
              <a href="${pageContext.request.contextPath}/admin/immeubles" class="btn btn-outline">Annuler</a>
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
