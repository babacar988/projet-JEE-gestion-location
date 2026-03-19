<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="64kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Demandes — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="demandes"/></jsp:include>
  <div class="main-content" id="panel">
<%--    <jsp:include page="../shared/topnav.jsp"/>--%>
    <div class="header bg-primary pb-6">
      <div class="container-fluid"><div class="header-body">
        <div class="row align-items-center py-4">
          <div class="col"><h6 class="h2 text-white d-inline-block mb-0">Demandes de location</h6></div>
        </div>
      </div></div>
    </div>
    <div class="container-fluid mt--6">
      <div class="row"><div class="col">
        <div class="card">
          <div class="card-header border-0">
            <h3 class="mb-0">Toutes les demandes</h3>
          </div>
          <c:choose>
            <c:when test="${empty demandes}">
              <div class="card-body text-center py-5">
                <i class="ni ni-email-83 fa-3x text-muted mb-3 d-block"></i>
                <p class="text-muted">Aucune demande</p>
              </div>
            </c:when>
            <c:otherwise>
              <div class="table-responsive">
                <table class="table align-items-center table-flush">
                  <thead class="thead-light">
                    <tr><th>Locataire</th><th>Logement</th><th>Loyer</th><th>Date</th><th>Statut</th><th>Actions</th></tr>
                  </thead>
                  <tbody>
                  <c:forEach var="d" items="${demandes}">
                    <tr>
                      <td>
                        <div class="d-flex align-items-center">
                          <div class="avatar avatar-sm rounded-circle bg-gradient-info text-white d-flex align-items-center justify-content-center mr-2"
                               style="font-size:10px;width:32px;height:32px;flex-shrink:0">
                            ${d.locataire.prenom.charAt(0)}${d.locataire.nom.charAt(0)}
                          </div>
                          <div>
                            <span class="font-weight-bold text-sm">${d.locataire.prenom} ${d.locataire.nom}</span>
                            <br><small class="text-muted">${d.locataire.email}</small>
                          </div>
                        </div>
                      </td>
                      <td class="text-sm">N° ${d.unite.numero} — ${d.unite.immeuble.nom}</td>
                      <td><fmt:formatNumber value="${d.unite.loyerMensuel}" maxFractionDigits="0"/>€</td>
                      <td class="text-sm text-muted">${d.dateDemande}</td>
                      <td>
                        <c:choose>
                          <c:when test="${d.statut=='EN_ATTENTE'}">
                            <span class="badge badge-dot"><i class="bg-warning"></i><span class="text-warning">En attente</span></span>
                          </c:when>
                          <c:when test="${d.statut=='ACCEPTEE'}">
                            <span class="badge badge-dot"><i class="bg-success"></i><span class="text-success">Acceptée</span></span>
                          </c:when>
                          <c:when test="${d.statut=='REFUSEE'}">
                            <span class="badge badge-dot"><i class="bg-danger"></i><span class="text-danger">Refusée</span></span>
                          </c:when>
                          <c:otherwise><span class="badge badge-secondary">${d.statut}</span></c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <c:if test="${d.statut=='EN_ATTENTE'}">
                          <a href="${pageContext.request.contextPath}/admin/demandes?action=accepter&id=${d.id}"
                             class="btn btn-sm btn-success"
                             onclick="return confirm('Accepter cette demande ?')">
                            <i class="fas fa-check"></i>
                          </a>
                          <a href="${pageContext.request.contextPath}/admin/demandes?action=refuser&id=${d.id}"
                             class="btn btn-sm btn-danger"
                             onclick="return confirm('Refuser cette demande ?')">
                            <i class="fas fa-times"></i>
                          </a>
                        </c:if>
                      </td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div></div>
      <footer class="footer pt-0"><div class="copyright text-center text-muted">&copy; <%=java.time.Year.now()%> ImmoGest</div></footer>
    </div>
  </div>
  </div><!-- /.main-content -->
<jsp:include page="../shared/scripts.jsp"/>
</body></html>
