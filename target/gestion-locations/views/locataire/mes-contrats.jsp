<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Mes contrats — ImmoGest</title>
    <jsp:include page="../shared/head.jsp"/>
</head>
<body>
<jsp:include page="../shared/navbar1.jsp">
    <jsp:param name="page" value="mes-contrats"/>
</jsp:include>
<div class="header bg-primary pb-6">
    <div class="container-fluid">
        <div class="header-body">
            <div class="row align-items-center py-4">
                <div class="col"><h6 class="h2 text-white d-inline-block mb-0">Mes contrats</h6></div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid mt--6">
    <div class="card shadow">
        <div class="table-responsive">
            <table class="table align-items-center table-flush">
                <thead class="thead-light">
                <tr>
                    <th>Référence</th>
                    <th>Logement</th>
                    <th>Immeuble</th>
                    <th>Loyer</th>
                    <th>Début</th>
                    <th>Fin</th>
                    <th>Statut</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty contrats}">
                        <tr>
                            <td colspan="7" class="text-center py-5">
                                <i class="ni ni-single-copy-04" style="font-size:2.5rem;color:#ccc"></i>
                                <h4 class="text-muted mt-3">Aucun contrat</h4>
                                <p class="text-muted">Vous n'avez pas encore de contrat de location.</p>
                                <a href="${pageContext.request.contextPath}/locataire/offres"
                                   class="btn btn-sm btn-primary">Voir les offres</a>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="c" items="${contrats}">
                            <tr>
                                <td style="font-family:monospace;font-size:11px;font-weight:700">${c.reference}</td>
                                <td>
                                    <div class="font-weight-bold">N° ${c.unite.numero}</div>
                                    <div class="text-xs text-muted">
                                        <c:choose><c:when
                                                test="${c.unite.etage!=null}">Étage ${c.unite.etage}</c:when><c:otherwise>RDC</c:otherwise></c:choose>
                                        <c:if test="${c.unite.superficie!=null}"> · ${c.unite.superficie} m²</c:if>
                                    </div>
                                </td>
                                <td class="text-sm">
                                    <div class="font-weight-bold">${c.unite.immeuble.nom}</div>
                                    <div class="text-xs text-muted">${c.unite.immeuble.ville}</div>
                                </td>
                                <td class="font-weight-bold h5 mb-0"><fmt:formatNumber value="${c.loyerMensuel}"
                                                                                       maxFractionDigits="0"/>€
                                </td>
                                <td class="text-sm text-muted">${c.dateDebut}</td>
                                <td class="text-sm text-muted">${not empty c.dateFin ? c.dateFin : '—'}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.statut=='ACTIF'}"> <span
                                                class="badge badge-success badge-pill">Actif</span></c:when>
                                        <c:when test="${c.statut=='EN_ATTENTE'}"> <span
                                                class="badge badge-warning badge-pill">En attente</span></c:when>
                                        <c:when test="${c.statut=='RESILIE'}"> <span
                                                class="badge badge-danger  badge-pill">Résilié</span></c:when>
                                        <c:otherwise> <span
                                                class="badge badge-default badge-pill">${c.statut}</span></c:otherwise>
                                    </c:choose>
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
