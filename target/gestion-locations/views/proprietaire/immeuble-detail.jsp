<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>${immeuble.nom} — ImmoGest</title>
    <jsp:include page="../shared/head.jsp"/>
</head>
<body>
<jsp:include page="../shared/navbar1.jsp">
    <jsp:param name="page" value="immeubles"/>
</jsp:include>
<div class="header bg-primary pb-6">
    <div class="container-fluid">
        <div class="header-body">
            <div class="row align-items-center py-4">
                <div class="col-lg-6 col-7"><h6 class="h2 text-white d-inline-block mb-0">${immeuble.nom}</h6></div>
                <div class="col-lg-6 col-5 text-right">
                    <a href="${pageContext.request.contextPath}/proprietaire/immeuble-form?id=${immeuble.id}"
                       class="btn btn-sm btn-neutral">
                        <i class="ni ni-settings mr-1"></i>Modifier
                    </a>
                    <a href="${pageContext.request.contextPath}/proprietaire/immeubles" class="btn btn-sm btn-neutral">Retour</a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid mt--6">
    <div class="row">
        <!-- Infos -->
        <div class="col-xl-4">
            <div class="card shadow">
                <div class="card-header bg-white border-0"><h3 class="mb-0">Informations</h3></div>
                <div class="card-body">
                    <dl class="row mb-0">
                        <dt class="col-sm-5 text-muted text-sm">Adresse</dt>
                        <dd class="col-sm-7 text-sm font-weight-bold">${immeuble.adresse}</dd>
                        <dt class="col-sm-5 text-muted text-sm">Ville</dt>
                        <dd class="col-sm-7 text-sm">${immeuble.ville} <c:if
                                test="${not empty immeuble.codePostal}">(${immeuble.codePostal})</c:if></dd>
                        <dt class="col-sm-5 text-muted text-sm">Type</dt>
                        <dd class="col-sm-7"><span class="badge badge-primary badge-pill">${immeuble.type}</span></dd>
                        <c:if test="${immeuble.nombreEtages != null}">
                            <dt class="col-sm-5 text-muted text-sm">Étages</dt>
                            <dd class="col-sm-7 text-sm">${immeuble.nombreEtages}</dd>
                        </c:if>
                        <c:if test="${immeuble.anneeConstruction != null}">
                            <dt class="col-sm-5 text-muted text-sm">Construction</dt>
                            <dd class="col-sm-7 text-sm">${immeuble.anneeConstruction}</dd>
                        </c:if>
                        <dt class="col-sm-5 text-muted text-sm">Statut</dt>
                        <dd class="col-sm-7">
                <span class="badge ${immeuble.actif ? 'badge-success' : 'badge-danger'} badge-pill">
                    ${immeuble.actif ? 'Actif' : 'Inactif'}
                </span>
                        </dd>
                    </dl>
                    <c:if test="${not empty immeuble.description}">
                        <hr>
                        <p class="text-sm text-muted mb-0">${immeuble.description}</p>
                    </c:if>
                    <c:if test="${not empty immeuble.equipements}">
                        <hr>
                        <p class="text-xs text-muted mb-1 font-weight-bold text-uppercase">Équipements</p>
                        <p class="text-sm mb-0">${immeuble.equipements}</p>
                    </c:if>
                </div>
            </div>
            <!-- Stats unités -->
            <div class="card shadow">
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-4">
                            <span class="d-block h3 font-weight-bold">${immeuble.nombreUnites}</span>
                            <span class="text-muted text-xs">Total</span>
                        </div>
                        <div class="col-4 border-left border-right">
                            <c:set var="nbDispo" value="0"/>
                            <c:forEach var="u" items="${immeuble.unites}">
                                <c:if test="${u.statut=='DISPONIBLE'}"><c:set var="nbDispo"
                                                                              value="${nbDispo+1}"/></c:if>
                            </c:forEach>
                            <span class="d-block h3 font-weight-bold text-success">${nbDispo}</span>
                            <span class="text-muted text-xs">Disponibles</span>
                        </div>
                        <div class="col-4">
                            <c:set var="nbOcc" value="0"/>
                            <c:forEach var="u" items="${immeuble.unites}">
                                <c:if test="${u.statut=='OCCUPEE'}"><c:set var="nbOcc" value="${nbOcc+1}"/></c:if>
                            </c:forEach>
                            <span class="d-block h3 font-weight-bold text-danger">${nbOcc}</span>
                            <span class="text-muted text-xs">Occupées</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Table unités -->
        <div class="col-xl-8">
            <div class="card shadow">
                <div class="card-header border-0">
                    <div class="row align-items-center">
                        <div class="col"><h3 class="mb-0">Unités</h3></div>
                        <div class="col text-right">
                            <a href="${pageContext.request.contextPath}/proprietaire/unite-form?immeubleId=${immeuble.id}"
                               class="btn btn-sm btn-primary">
                                <i class="ni ni-fat-add mr-1"></i>Ajouter une unité
                            </a>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table align-items-center table-flush">
                        <thead class="thead-light">
                        <tr>
                            <th>N°</th>
                            <th>Type</th>
                            <th>Étage</th>
                            <th>Pièces</th>
                            <th>Surface</th>
                            <th>Loyer</th>
                            <th>Statut</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty immeuble.unites}">
                                <tr>
                                    <td colspan="8" class="text-center py-4 text-muted">Aucune unité</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="u" items="${immeuble.unites}">
                                    <tr>
                                        <td class="font-weight-bold">N° ${u.numero}</td>
                                        <td><span class="badge badge-primary badge-pill text-xs">${u.type}</span></td>
                                        <td class="text-sm"><c:choose><c:when
                                                test="${u.etage != null}">Étage ${u.etage}</c:when><c:otherwise>RDC</c:otherwise></c:choose></td>
                                        <td class="text-sm"><c:choose><c:when
                                                test="${u.nombrePieces!=null}">${u.nombrePieces} p.</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                                        <td class="text-sm"><c:choose><c:when
                                                test="${u.superficie!=null}">${u.superficie} m²</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                                        <td class="font-weight-bold"><fmt:formatNumber value="${u.loyerMensuel}"
                                                                                       maxFractionDigits="0"/>€
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.statut=='DISPONIBLE'}"><span
                                                        class="badge badge-success badge-pill">Disponible</span></c:when>
                                                <c:when test="${u.statut=='OCCUPEE'}"> <span
                                                        class="badge badge-danger  badge-pill">Occupée</span></c:when>
                                                <c:when test="${u.statut=='EN_TRAVAUX'}"><span
                                                        class="badge badge-warning badge-pill">Travaux</span></c:when>
                                                <c:otherwise> <span
                                                        class="badge badge-default badge-pill">${u.statut}</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/proprietaire/unite-form?id=${u.id}"
                                               class="btn btn-sm btn-outline-primary"><i class="ni ni-settings"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
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
