<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title><c:choose><c:when test="${not empty immeuble}">Modifier</c:when><c:otherwise>Ajouter</c:otherwise></c:choose> un immeuble — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">&#9776;</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="immeubles"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">
        <c:choose><c:when test="${not empty immeuble}">Modifier — ${immeuble.nom}</c:when>
        <c:otherwise>Ajouter un immeuble</c:otherwise></c:choose>
      </h1>
      <div class="topbar-actions">
        <a href="${pageContext.request.contextPath}/proprietaire/immeubles" class="btn btn-outline">Annuler</a>
      </div>
    </div>
    <div class="page-content">
      <c:if test="${not empty error}">
        <div class="alert alert-danger" data-dismiss>${error}</div>
      </c:if>

      <div class="card" style="max-width:720px">
        <div class="card-header">
          <span class="card-title">
            <c:choose><c:when test="${not empty immeuble}">Informations de l'immeuble</c:when>
            <c:otherwise>Nouvel immeuble</c:otherwise></c:choose>
          </span>
        </div>
        <div class="card-body">
          <form method="post" action="${pageContext.request.contextPath}/proprietaire/immeuble-form">
            <c:if test="${not empty immeuble}">
              <input type="hidden" name="id" value="${immeuble.id}">
            </c:if>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Nom de l'immeuble *</label>
                <input type="text" name="nom" class="form-control" required
                       placeholder="Résidence Les Acacias"
                       value="<c:out value='${immeuble.nom}'/>">
              </div>
              <div class="form-group">
                <label class="form-label">Type</label>
                <select name="type" class="form-control">
                  <c:forEach var="t" items="${['RESIDENTIEL','COMMERCIAL','MIXTE','INDUSTRIEL']}">
                    <option value="${t}" <c:if test="${immeuble.type == t}">selected</c:if>>${t}</option>
                  </c:forEach>
                </select>
              </div>
            </div>

            <div class="form-group">
              <label class="form-label">Adresse *</label>
              <input type="text" name="adresse" class="form-control" required
                     placeholder="12 rue de la Paix"
                     value="<c:out value='${immeuble.adresse}'/>">
            </div>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Ville *</label>
                <input type="text" name="ville" class="form-control" required
                       placeholder="Paris"
                       value="<c:out value='${immeuble.ville}'/>">
              </div>
              <div class="form-group">
                <label class="form-label">Code postal</label>
                <input type="text" name="codePostal" class="form-control"
                       placeholder="75001"
                       value="<c:out value='${immeuble.codePostal}'/>">
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Nombre d'étages</label>
                <input type="number" name="nombreEtages" class="form-control" min="0" max="100"
                       placeholder="5"
                       value="<c:out value='${immeuble.nombreEtages}'/>">
              </div>
              <div class="form-group">
                <label class="form-label">Année de construction</label>
                <input type="number" name="anneeConstruction" class="form-control" min="1800" max="2030"
                       placeholder="1985"
                       value="<c:out value='${immeuble.anneeConstruction}'/>">
              </div>
            </div>

            <div class="form-group">
              <label class="form-label">Description</label>
              <textarea name="description" class="form-control" rows="3"
                        placeholder="Description de l'immeuble..."><c:out value='${immeuble.description}'/></textarea>
            </div>

            <div class="form-group">
              <label class="form-label">Équipements</label>
              <textarea name="equipements" class="form-control" rows="2"
                        placeholder="Ascenseur, parking, digicode..."><c:out value='${immeuble.equipements}'/></textarea>
              <div class="form-hint">Séparés par des virgules</div>
            </div>

            <hr class="divider">
            <div style="display:flex;gap:10px;justify-content:flex-end">
              <a href="${pageContext.request.contextPath}/proprietaire/immeubles" class="btn btn-outline">Annuler</a>
              <button type="submit" class="btn btn-primary">
                <c:choose><c:when test="${not empty immeuble}">Enregistrer les modifications</c:when>
                <c:otherwise>Ajouter l'immeuble</c:otherwise></c:choose>
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
