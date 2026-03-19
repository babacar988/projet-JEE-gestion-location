<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="64kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html>
<head><title>Utilisateur — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
<jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="utilisateurs"/></jsp:include>
  <div class="header bg-primary pb-6"><div class="container-fluid"><div class="header-body">
    <div class="row align-items-center py-4">
      <div class="col"><h6 class="h2 text-white mb-0"><c:choose><c:when test="${not empty utilisateur}">Modifier l'utilisateur</c:when><c:otherwise>Ajouter un utilisateur</c:otherwise></c:choose></h6></div>
      <div class="col text-right"><a href="${pageContext.request.contextPath}/admin/utilisateurs" class="btn btn-sm btn-neutral">Retour</a></div>
    </div>
  </div></div></div>
  <div class="container-fluid mt--6"><div class="row justify-content-center"><div class="col-lg-6">
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
    <div class="card shadow"><div class="card-header bg-white border-0"><h3 class="mb-0">Informations</h3></div>
    <div class="card-body">
      <form method="post" action="${pageContext.request.contextPath}/admin/utilisateurs">
        <c:if test="${not empty utilisateur}"><input type="hidden" name="id" value="${utilisateur.id}"></c:if>
        <div class="row">
          <div class="col-md-6"><div class="form-group"><label class="form-control-label">Prénom *</label>
            <input type="text" name="prenom" class="form-control" required value="<c:out value='${utilisateur.prenom}'/>">
          </div></div>
          <div class="col-md-6"><div class="form-group"><label class="form-control-label">Nom *</label>
            <input type="text" name="nom" class="form-control" required value="<c:out value='${utilisateur.nom}'/>">
          </div></div>
        </div>
        <div class="form-group"><label class="form-control-label">Email *</label>
          <input type="email" name="email" class="form-control" required value="<c:out value='${utilisateur.email}'/>">
        </div>
        <div class="row">
          <div class="col-md-6"><div class="form-group"><label class="form-control-label">Mot de passe <c:if test="${not empty utilisateur}"><small class="text-muted">(laisser vide)</small></c:if></label>
            <input type="password" name="password" class="form-control" <c:if test="${empty utilisateur}">required</c:if>>
          </div></div>
          <div class="col-md-6"><div class="form-group"><label class="form-control-label">Rôle *</label>
            <select name="role" class="form-control" required>
              <option value="LOCATAIRE"    <c:if test="${utilisateur.role=='LOCATAIRE'   }">selected</c:if>>Locataire</option>
              <option value="PROPRIETAIRE" <c:if test="${utilisateur.role=='PROPRIETAIRE'}">selected</c:if>>Propriétaire</option>
              <option value="ADMIN"        <c:if test="${utilisateur.role=='ADMIN'       }">selected</c:if>>Administrateur</option>
            </select>
          </div></div>
        </div>
        <div class="form-group"><label class="form-control-label">Téléphone</label>
          <input type="tel" name="telephone" class="form-control" placeholder="06 12 34 56 78" value="<c:out value='${utilisateur.telephone}'/>">
        </div>
        <hr>
        <div class="d-flex justify-content-end" style="gap:10px">
          <a href="${pageContext.request.contextPath}/admin/utilisateurs" class="btn btn-outline-secondary">Annuler</a>
          <button type="submit" class="btn btn-primary"><c:choose><c:when test="${not empty utilisateur}">Enregistrer</c:when><c:otherwise>Créer</c:otherwise></c:choose></button>
        </div>
      </form>
    </div></div>
  </div></div>
  <footer class="footer pt-0"><div class="row"><div class="col"><p class="text-muted text-sm">ImmoGest &copy; 2025</p></div></div></footer>
  </div>
</div>
<jsp:include page="../shared/scripts.jsp"/>
</body></html>
