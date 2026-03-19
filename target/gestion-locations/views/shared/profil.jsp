<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="256kb" autoFlush="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html>
<head><title>Mon profil — ImmoGest</title><jsp:include page="head.jsp"/></head>
<body>
<jsp:include page="navbar.jsp"><jsp:param name="page" value="profil"/></jsp:include>
  <div class="header bg-primary pb-6"><div class="container-fluid"><div class="header-body">
    <div class="row align-items-center py-4">
      <div class="col"><h6 class="h2 text-white d-inline-block mb-0">Mon profil</h6></div>
    </div>
  </div></div></div>
  <div class="container-fluid mt--6">

    <c:if test="${not empty success}">
      <div class="alert alert-success alert-dismissible fade show">
        <i class="ni ni-check-bold mr-2"></i>${success}
        <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
      </div>
    </c:if>
    <c:if test="${not empty error}">
      <div class="alert alert-danger alert-dismissible fade show">
        ${error}
        <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
      </div>
    </c:if>

    <div class="row">
      <!-- Card identité -->
      <div class="col-xl-4 col-lg-5">
        <div class="card card-profile shadow">
          <div class="row justify-content-center">
            <div class="col-lg-3 order-lg-2">
              <div class="card-profile-image">
                <span class="avatar avatar-xl rounded-circle bg-gradient-primary text-white"
                      style="font-size:2rem;font-weight:800;display:flex;align-items:center;
                             justify-content:center;width:90px;height:90px;margin-top:-45px">
                  ${sessionScope.utilisateur.prenom.charAt(0)}${sessionScope.utilisateur.nom.charAt(0)}
                </span>
              </div>
            </div>
          </div>
          <div class="card-header text-center border-0 pt-8 pb-0 pb-md-4"></div>
          <div class="card-body pt-0 pt-md-4">
            <div class="text-center mt-md-5 pb-3">
              <h4 class="font-weight-bold">
                ${sessionScope.utilisateur.prenom} ${sessionScope.utilisateur.nom}
              </h4>
              <div class="h5 font-weight-300 text-muted">
                <i class="ni ni-email-83 mr-1"></i>${sessionScope.utilisateur.email}
              </div>
              <c:if test="${not empty sessionScope.utilisateur.telephone}">
                <div class="h5 mt-1 text-muted">
                  <i class="ni ni-mobile-button mr-1"></i>${sessionScope.utilisateur.telephone}
                </div>
              </c:if>
              <div class="mt-3">
                <c:choose>
                  <c:when test="${sessionScope.utilisateur.role=='ADMIN'}">
                    <span class="badge badge-primary badge-pill px-3 py-2">Administrateur</span>
                  </c:when>
                  <c:when test="${sessionScope.utilisateur.role=='PROPRIETAIRE'}">
                    <span class="badge badge-warning badge-pill px-3 py-2">Propriétaire</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge badge-info badge-pill px-3 py-2">Locataire</span>
                  </c:otherwise>
                </c:choose>
              </div>
              <hr class="my-4">
              <a href="#" class="btn btn-outline-danger btn-sm"
                 onclick="openLogoutModal(); return false;">
                <i class="ni ni-user-run mr-1"></i>Se déconnecter
              </a>
            </div>
          </div>
        </div>
      </div>

      <!-- Formulaire modification -->
      <div class="col-xl-8 col-lg-7">
        <div class="card shadow">
          <div class="card-header bg-white border-0">
            <h3 class="mb-0">Modifier mes informations</h3>
          </div>
          <div class="card-body">
            <form method="post" action="${pageContext.request.contextPath}/${userRole}/profil">
              <h6 class="heading-small text-muted mb-4 text-uppercase" style="font-size:.65rem">
                Informations personnelles
              </h6>
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <label class="form-control-label">Prénom</label>
                    <input type="text" name="prenom" class="form-control" required
                           value="<c:out value='${sessionScope.utilisateur.prenom}'/>">
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label class="form-control-label">Nom</label>
                    <input type="text" name="nom" class="form-control" required
                           value="<c:out value='${sessionScope.utilisateur.nom}'/>">
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-md-8">
                  <div class="form-group">
                    <label class="form-control-label">Email</label>
                    <input type="email" name="email" class="form-control" required
                           value="<c:out value='${sessionScope.utilisateur.email}'/>">
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                    <label class="form-control-label">Téléphone</label>
                    <input type="tel" name="telephone" class="form-control"
                           placeholder="06 12 34 56 78"
                           value="<c:out value='${sessionScope.utilisateur.telephone}'/>">
                  </div>
                </div>
              </div>

              <hr class="my-4">
              <h6 class="heading-small text-muted mb-4 text-uppercase" style="font-size:.65rem">
                Changer le mot de passe
              </h6>
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group">
                    <label class="form-control-label">
                      Nouveau mot de passe
                      <small class="text-muted">(laisser vide pour ne pas changer)</small>
                    </label>
                    <input type="password" name="password" class="form-control"
                           placeholder="••••••••">
                  </div>
                </div>
              </div>

              <div class="text-right">
                <button type="submit" class="btn btn-primary">
                  <i class="ni ni-check-bold mr-1"></i>Enregistrer les modifications
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
<jsp:include page="scripts.jsp"/>
</body></html>
