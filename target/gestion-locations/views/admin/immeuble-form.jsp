<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="64kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html>
<head><title>Immeuble — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
<jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="immeubles"/></jsp:include>
  <div class="header bg-primary pb-6">
    <div class="container-fluid"><div class="header-body">
      <div class="row align-items-center py-4">
        <div class="col"><h6 class="h2 text-white mb-0">
          <c:choose><c:when test="${not empty immeuble}">Modifier ${immeuble.nom}</c:when><c:otherwise>Ajouter un immeuble</c:otherwise></c:choose>
        </h6></div>
        <div class="col text-right"><a href="${pageContext.request.contextPath}/admin/immeubles" class="btn btn-sm btn-neutral">Retour</a></div>
      </div>
    </div></div>
  </div>
  <div class="container-fluid mt--6">
    <div class="row justify-content-center"><div class="col-lg-8">
      <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
      <div class="card shadow">
        <div class="card-header bg-white border-0">
          <h3 class="mb-0">Informations de l'immeuble</h3>
        </div>
        <div class="card-body">
          <form method="post" action="${pageContext.request.contextPath}/admin/immeubles">
            <c:if test="${not empty immeuble}"><input type="hidden" name="id" value="${immeuble.id}"></c:if>
            <div class="row">
              <div class="col-md-8">
                <div class="form-group"><label class="form-control-label">Nom *</label>
                  <input type="text" name="nom" class="form-control" required placeholder="Résidence Les Acacias" value="<c:out value='${immeuble.nom}'/>">
                </div>
              </div>
              <div class="col-md-4">
                <div class="form-group"><label class="form-control-label">Type</label>
                  <select name="type" class="form-control">
                    <c:forEach var="t" items="${['RESIDENTIEL','COMMERCIAL','MIXTE','INDUSTRIEL']}">
                      <option value="${t}" <c:if test="${immeuble.type==t}">selected</c:if>>${t}</option>
                    </c:forEach>
                  </select>
                </div>
              </div>
            </div>
            <div class="form-group"><label class="form-control-label">Adresse *</label>
              <input type="text" name="adresse" class="form-control" required placeholder="12 rue de la Paix" value="<c:out value='${immeuble.adresse}'/>">
            </div>
            <div class="row">
              <div class="col-md-6"><div class="form-group"><label class="form-control-label">Ville *</label>
                <input type="text" name="ville" class="form-control" required value="<c:out value='${immeuble.ville}'/>">
              </div></div>
              <div class="col-md-3"><div class="form-group"><label class="form-control-label">Code postal</label>
                <input type="text" name="codePostal" class="form-control" value="<c:out value='${immeuble.codePostal}'/>">
              </div></div>
              <div class="col-md-3"><div class="form-group"><label class="form-control-label">Étages</label>
                <input type="number" name="nombreEtages" class="form-control" value="<c:out value='${immeuble.nombreEtages}'/>">
              </div></div>
            </div>
            <div class="form-group"><label class="form-control-label">Propriétaire</label>
              <select name="proprietaireId" class="form-control">
                <option value="">— Aucun —</option>
                <c:forEach var="p" items="${proprietaires}">
                  <option value="${p.id}" <c:if test="${immeuble.proprietaire.id==p.id}">selected</c:if>>${p.prenom} ${p.nom}</option>
                </c:forEach>
              </select>
            </div>
            <div class="form-group"><label class="form-control-label">Description</label>
              <textarea name="description" class="form-control" rows="3"><c:out value='${immeuble.description}'/></textarea>
            </div>
            <div class="form-group"><label class="form-control-label">Équipements</label>
              <textarea name="equipements" class="form-control" rows="2" placeholder="Ascenseur, parking..."><c:out value='${immeuble.equipements}'/></textarea>
            </div>
            <hr>
            <div class="d-flex justify-content-end" style="gap:10px">
              <a href="${pageContext.request.contextPath}/admin/immeubles" class="btn btn-outline-secondary">Annuler</a>
              <button type="submit" class="btn btn-primary">
                <c:choose><c:when test="${not empty immeuble}">Enregistrer</c:when><c:otherwise>Créer l'immeuble</c:otherwise></c:choose>
              </button>
            </div>
          </form>
        </div>
      </div>
    </div></div>
    <footer class="footer pt-0"><div class="row"><div class="col"><p class="text-muted text-sm">ImmoGest &copy; 2025</p></div></div></footer>
  </div>
</div>
<jsp:include page="../shared/scripts.jsp"/>
</body></html>
