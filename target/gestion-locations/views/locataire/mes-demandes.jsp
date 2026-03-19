<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Mes demandes — ImmoGest</title>
    <jsp:include page="../shared/head.jsp"/>
</head>
<body>
<jsp:include page="../shared/navbar1.jsp">
    <jsp:param name="page" value="mes-demandes"/>
</jsp:include>
<div class="header bg-primary pb-6">
    <div class="container-fluid">
        <div class="header-body">
            <div class="row align-items-center py-4">
                <div class="col"><h6 class="h2 text-white d-inline-block mb-0">Mes demandes</h6></div>
                <div class="col text-right">
                    <a href="${pageContext.request.contextPath}/locataire/offres" class="btn btn-sm btn-neutral">
                        <i class="ni ni-fat-add mr-1"></i>Nouvelle demande
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid mt--6">
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show">${success}
            <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
        </div>
    </c:if>
    <div class="card shadow">
        <div class="table-responsive">
            <table class="table align-items-center table-flush">
                <thead class="thead-light">
                <tr>
                    <th>Logement</th>
                    <th>Immeuble</th>
                    <th>Loyer</th>
                    <th>Date demande</th>
                    <th>Statut</th>
                    <th>Message</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty demandes}">
                        <tr>
                            <td colspan="6" class="text-center py-5">
                                <i class="ni ni-email-83" style="font-size:2.5rem;color:#ccc"></i>
                                <h4 class="text-muted mt-3">Aucune demande</h4>
                                <p class="text-muted">Vous n'avez pas encore soumis de demande.</p>
                                <a href="${pageContext.request.contextPath}/locataire/offres"
                                   class="btn btn-sm btn-primary">Voir les offres</a>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="d" items="${demandes}">
                            <tr>
                                <td>
                                    <div class="font-weight-bold">N° ${d.unite.numero}</div>
                                    <div class="text-xs">
                                        <span class="badge badge-primary badge-pill">${d.unite.type}</span>
                                        <c:if test="${d.unite.superficie!=null}"> ${d.unite.superficie} m²</c:if>
                                    </div>
                                </td>
                                <td class="text-sm">
                                    <div class="font-weight-bold">${d.unite.immeuble.nom}</div>
                                    <div class="text-xs text-muted">${d.unite.immeuble.ville}</div>
                                </td>
                                <td class="font-weight-bold"><fmt:formatNumber value="${d.unite.loyerMensuel}"
                                                                               maxFractionDigits="0"/>€
                                </td>
                                <td class="text-sm text-muted">${d.dateDemande}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${d.statut=='EN_ATTENTE'}"><span
                                                class="badge badge-warning badge-pill">En attente</span></c:when>
                                        <c:when test="${d.statut=='ACCEPTEE'}"> <span
                                                class="badge badge-success badge-pill">Acceptée</span></c:when>
                                        <c:when test="${d.statut=='REFUSEE'}"> <span
                                                class="badge badge-danger  badge-pill">Refusée</span></c:when>
                                        <c:otherwise> <span
                                                class="badge badge-default badge-pill">${d.statut}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-sm text-muted" style="max-width:180px">
                                        ${not empty d.message ? d.message : '—'}
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    <footer class="footer pt-0">
        <div class="row">
            <div class="col"><p class="text-muted text-sm">ImmoGest &copy; 2025</p></div>
        </div>
    </footer>
</div>
</div>
<jsp:include page="../shared/scripts.jsp"/>
</body>
</html>
