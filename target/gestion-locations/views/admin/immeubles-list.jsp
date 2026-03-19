<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="64kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Immeubles — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
<jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="immeubles"/></jsp:include>
<div class="header bg-primary pb-6"><div class="container-fluid"><div class="header-body">
  <div class="row align-items-center py-4">
    <div class="col-lg-6 col-7"><h6 class="h2 text-white d-inline-block mb-0">Immeubles</h6></div>
    <div class="col-lg-6 col-5 text-right">
      <a href="${pageContext.request.contextPath}/admin/immeubles?action=nouveau" class="btn btn-sm btn-neutral">
        <i class="ni ni-fat-add mr-1"></i>Ajouter
      </a>
    </div>
  </div>
</div></div></div>
<div class="container-fluid mt--6">
  <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
  <div class="card shadow">
    <div class="card-header border-0">
      <div class="row align-items-center">
        <div class="col"><h3 class="mb-0">Liste des immeubles</h3></div>
        <div class="col text-right"><span class="badge badge-primary badge-pill">${immeubles.size()} immeuble(s)</span></div>
      </div>
    </div>
    <div class="table-responsive">
      <table class="table align-items-center table-flush">
        <thead class="thead-light">
        <tr><th>Nom</th><th>Adresse</th><th>Ville</th><th>Type</th><th>Unités</th><th>Propriétaire</th><th>Statut</th><th>Actions</th></tr>
        </thead>
        <tbody>
        <c:choose>
          <c:when test="${empty immeubles}">
            <tr><td colspan="8" class="text-center py-5 text-muted">Aucun immeuble enregistré</td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="imm" items="${immeubles}">
              <tr>
                <td class="font-weight-bold">${imm.nom}</td>
                <td class="text-sm">${imm.adresse}</td>
                <td class="text-sm">${imm.ville}<c:if test="${not empty imm.codePostal}"> (${imm.codePostal})</c:if></td>
                <td><span class="badge badge-primary badge-pill">${imm.type}</span></td>
                <td class="text-center font-weight-bold">${imm.nombreUnites}</td>
                <td class="text-sm">
                  <c:choose>
                    <c:when test="${imm.proprietaire != null}">${imm.proprietaire.prenom} ${imm.proprietaire.nom}</c:when>
                    <c:otherwise><span class="text-muted">—</span></c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${imm.actif}"><span class="badge badge-success badge-pill">Actif</span></c:when>
                    <c:otherwise><span class="badge badge-danger badge-pill">Inactif</span></c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <a href="${pageContext.request.contextPath}/admin/immeubles?action=modifier&id=${imm.id}"
                     class="btn btn-sm btn-outline-primary" title="Modifier">
                    <i class="ni ni-settings"></i>
                  </a>
                  <a href="${pageContext.request.contextPath}/admin/immeubles?action=supprimer&id=${imm.id}"
                     class="btn btn-sm btn-outline-danger" title="Supprimer"
                     onclick="return confirm('Supprimer cet immeuble ?')">
                    <i class="ni ni-fat-remove"></i>
                  </a>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
        </tbody>
      </table>
    </div>
  </div>
  <footer class="footer pt-0"><div class="row"><div class="col"><p class="text-muted text-sm">ImmoGest &copy; 2025</p></div></div></footer>
</div>
</div><!-- /.main-content -->
<jsp:include page="../shared/scripts.jsp"/>
</body></html>
