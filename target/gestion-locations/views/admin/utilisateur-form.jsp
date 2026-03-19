<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="128kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html>
<head><title>Utilisateur — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
<jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="utilisateurs"/></jsp:include>
  <div class="header bg-primary pb-6"><div class="container-fluid"><div class="header-body">
    <div class="row align-items-center py-4">
      <div class="col">
        <h6 class="h2 text-white mb-0">
          <%-- editUser = null → création | editUser != null → modification --%>
          <c:choose>
            <c:when test="${not empty editUser}">Modifier — ${editUser.prenom} ${editUser.nom}</c:when>
            <c:otherwise>Ajouter un utilisateur</c:otherwise>
          </c:choose>
        </h6>
      </div>
      <div class="col text-right">
        <a href="${pageContext.request.contextPath}/admin/utilisateurs" class="btn btn-sm btn-neutral">
          Retour
        </a>
      </div>
    </div>
  </div></div></div>

  <div class="container-fluid mt--6">
    <div class="row justify-content-center">
      <div class="col-lg-7">

        <c:if test="${not empty error}">
          <div class="alert alert-danger alert-dismissible fade show">
            <i class="ni ni-fat-remove mr-2"></i>${error}
            <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
          </div>
        </c:if>

        <div class="card shadow">
          <div class="card-header bg-white border-0 d-flex align-items-center">
            <div class="mr-auto">
              <h3 class="mb-0">
                <c:choose>
                  <c:when test="${not empty editUser}">
                    <i class="ni ni-settings text-primary mr-2"></i>Modifier l'utilisateur
                  </c:when>
                  <c:otherwise>
                    <i class="ni ni-fat-add text-primary mr-2"></i>Nouvel utilisateur
                  </c:otherwise>
                </c:choose>
              </h3>
            </div>
            <c:if test="${not empty editUser}">
              <span class="badge ${editUser.actif ? 'badge-success' : 'badge-danger'} badge-pill">
                ${editUser.actif ? 'Actif' : 'Inactif'}
              </span>
            </c:if>
          </div>
          <div class="card-body">
            <form method="post" action="${pageContext.request.contextPath}/admin/utilisateurs">

              <%-- ID caché uniquement en mode modification --%>
              <c:if test="${not empty editUser}">
                <input type="hidden" name="id" value="${editUser.id}">
              </c:if>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <label class="form-control-label">Prénom *</label>
                    <input type="text" name="prenom" class="form-control" required
                           placeholder="Marie"
                           value="<c:out value='${editUser.prenom}'/>">
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label class="form-control-label">Nom *</label>
                    <input type="text" name="nom" class="form-control" required
                           placeholder="Dupont"
                           value="<c:out value='${editUser.nom}'/>">
                  </div>
                </div>
              </div>

              <div class="form-group">
                <label class="form-control-label">Email *</label>
                <input type="email" name="email" class="form-control" required
                       placeholder="utilisateur@exemple.fr"
                       value="<c:out value='${editUser.email}'/>">
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <label class="form-control-label">
                      Mot de passe
                      <c:if test="${not empty editUser}">
                        <small class="text-muted">(laisser vide = inchangé)</small>
                      </c:if>
                      <c:if test="${empty editUser}">*</c:if>
                    </label>
                    <input type="password" name="password" class="form-control"
                           placeholder="••••••••"
                           <c:if test="${empty editUser}">required</c:if>>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label class="form-control-label">Rôle *</label>
                    <select name="role" class="form-control" required>
                      <option value="LOCATAIRE"
                        <c:if test="${editUser.role=='LOCATAIRE' || empty editUser}">selected</c:if>>
                        🏠 Locataire
                      </option>
                      <option value="PROPRIETAIRE"
                        <c:if test="${editUser.role=='PROPRIETAIRE'}">selected</c:if>>
                        🏢 Propriétaire
                      </option>
                      <option value="ADMIN"
                        <c:if test="${editUser.role=='ADMIN'}">selected</c:if>>
                        ⚙️ Administrateur
                      </option>
                    </select>
                  </div>
                </div>
              </div>

              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <label class="form-control-label">Téléphone</label>
                    <input type="tel" name="telephone" class="form-control"
                           placeholder="06 12 34 56 78"
                           value="<c:out value='${editUser.telephone}'/>">
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label class="form-control-label">Statut du compte</label>
                    <select name="actif" class="form-control">
                      <option value="true"
                        <c:if test="${editUser.actif || empty editUser}">selected</c:if>>
                        ✅ Actif
                      </option>
                      <option value="false"
                        <c:if test="${not editUser.actif && not empty editUser}">selected</c:if>>
                        ❌ Inactif
                      </option>
                    </select>
                  </div>
                </div>
              </div>

              <hr class="my-4">
              <div class="d-flex justify-content-between align-items-center">
                <a href="${pageContext.request.contextPath}/admin/utilisateurs"
                   class="btn btn-outline-secondary">
                  <i class="ni ni-fat-remove mr-1"></i>Annuler
                </a>
                <button type="submit" class="btn btn-primary">
                  <c:choose>
                    <c:when test="${not empty editUser}">
                      <i class="ni ni-check-bold mr-1"></i>Enregistrer les modifications
                    </c:when>
                    <c:otherwise>
                      <i class="ni ni-fat-add mr-1"></i>Créer l'utilisateur
                    </c:otherwise>
                  </c:choose>
                </button>
              </div>
            </form>
          </div>
        </div>

      </div>
    </div>
    <footer class="footer pt-0"><div class="row"><div class="col">
      <p class="text-muted text-sm">ImmoGest &copy; 2025</p>
    </div></div></footer>
  </div>
</div><!-- /.main-content -->
<jsp:include page="../shared/scripts.jsp"/>
</body></html>
