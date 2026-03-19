<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="64kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Unités — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
<jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="unites"/></jsp:include>
  <div class="header bg-primary pb-6"><div class="container-fluid"><div class="header-body">
    <div class="row align-items-center py-4">
      <div class="col-lg-6 col-7"><h6 class="h2 text-white d-inline-block mb-0">Unités</h6></div>
      <div class="col-lg-6 col-5 text-right">
        <a href="${pageContext.request.contextPath}/admin/unites?action=nouveau" class="btn btn-sm btn-neutral">
          <i class="ni ni-fat-add mr-1"></i>Ajouter
        </a>
      </div>
    </div>
  </div></div></div>
  <div class="container-fluid mt--6">
    <div class="card shadow">
      <div class="card-header border-0">
        <div class="row align-items-center">
          <div class="col"><h3 class="mb-0">Liste des unités</h3></div>
          <div class="col text-right"><span class="badge badge-info badge-pill">${unites.size()} unité(s)</span></div>
        </div>
      </div>
      <div class="table-responsive">
        <table class="table align-items-center table-flush">
          <thead class="thead-light">
            <tr><th>N°</th><th>Type</th><th>Immeuble</th><th>Étage</th><th>Surface</th><th>Loyer</th><th>Statut</th><th>Actions</th></tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${empty unites}">
                <tr><td colspan="8" class="text-center py-5 text-muted">Aucune unité enregistrée</td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="u" items="${unites}">
                  <tr>
                    <td class="font-weight-bold">N° ${u.numero}</td>
                    <td><span class="badge badge-primary badge-pill text-xs">${u.type}</span></td>
                    <td class="text-sm">
                      <div class="font-weight-bold">${u.immeuble.nom}</div>
                      <div class="text-xs text-muted">${u.immeuble.ville}</div>
                    </td>
                    <td class="text-sm"><c:choose><c:when test="${u.etage != null}">Étage ${u.etage}</c:when><c:otherwise>RDC</c:otherwise></c:choose></td>
                    <td class="text-sm"><c:choose><c:when test="${u.superficie != null}">${u.superficie} m²</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                    <td class="font-weight-bold"><fmt:formatNumber value="${u.loyerMensuel}" maxFractionDigits="0"/>€</td>
                    <td>
                      <c:choose>
                        <c:when test="${u.statut=='DISPONIBLE'}"><span class="badge badge-success badge-pill">Disponible</span></c:when>
                        <c:when test="${u.statut=='OCCUPEE'}"><span class="badge badge-danger badge-pill">Occupée</span></c:when>
                        <c:when test="${u.statut=='EN_TRAVAUX'}"><span class="badge badge-warning badge-pill">Travaux</span></c:when>
                        <c:otherwise><span class="badge badge-default badge-pill">${u.statut}</span></c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <a href="${pageContext.request.contextPath}/admin/unites?action=modifier&id=${u.id}"
                         class="btn btn-sm btn-outline-primary"><i class="ni ni-settings"></i></a>
                      <a href="${pageContext.request.contextPath}/admin/unites?action=supprimer&id=${u.id}"
                         class="btn btn-sm btn-outline-danger"
                         onclick="return confirm('Supprimer cette unité ?')"><i class="ni ni-fat-remove"></i></a>
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
