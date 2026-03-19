<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Offres disponibles — ImmoGest</title>
    <jsp:include page="../shared/head.jsp"/>
</head>
<body>
<jsp:include page="../shared/navbar1.jsp">
    <jsp:param name="page" value="offres"/>
</jsp:include>
<div class="header bg-primary pb-6">
    <div class="container-fluid">
        <div class="header-body">
            <div class="row align-items-center py-4">
                <div class="col"><h6 class="h2 text-white d-inline-block mb-0">Offres disponibles</h6></div>
            </div>
            <!-- Filtres -->
            <div class="card">
                <div class="card-body py-3">
                    <form method="get" action="${pageContext.request.contextPath}/locataire/offres"
                          class="d-flex flex-wrap align-items-end" style="gap:12px">
                        <div class="form-group mb-0" style="flex:1;min-width:140px">
                            <label class="form-control-label text-white text-xs">Budget max (€/mois)</label>
                            <input type="number" name="maxLoyer" class="form-control form-control-sm"
                                   placeholder="2000" value="${param.maxLoyer}">
                        </div>
                        <div class="form-group mb-0" style="flex:1;min-width:120px">
                            <label class="form-control-label text-white text-xs">Pièces min</label>
                            <input type="number" name="minPieces" class="form-control form-control-sm"
                                   placeholder="2" value="${param.minPieces}">
                        </div>
                        <div class="form-group mb-0" style="flex:1;min-width:140px">
                            <label class="form-control-label text-white text-xs">Ville</label>
                            <input type="text" name="ville" class="form-control form-control-sm"
                                   placeholder="Paris" value="${param.ville}">
                        </div>
                        <div class="d-flex" style="gap:8px">
                            <button type="submit" class="btn btn-sm btn-white">Filtrer</button>
                            <a href="${pageContext.request.contextPath}/locataire/offres"
                               class="btn btn-sm btn-outline-white">Réinitialiser</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid mt--6">
    <c:choose>
        <c:when test="${empty unites}">
            <div class="card">
                <div class="card-body text-center py-5">
                    <i class="ni ni-building" style="font-size:3rem;color:#ccc"></i>
                    <h4 class="mt-3 text-muted">Aucune offre disponible</h4>
                    <p class="text-muted">Aucun logement ne correspond à vos critères actuellement.</p>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <p class="text-muted text-sm mb-3">${unites.size()} offre(s) disponible(s)</p>
            <div class="row">
                <c:forEach var="u" items="${unites}">
                    <div class="col-xl-4 col-md-6 mb-4">
                        <div class="card shadow h-100">
                            <div class="card-header border-0 bg-gradient-info py-3">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div>
                                        <span class="badge badge-white text-info font-weight-bold text-xs">${u.type}</span>
                                        <h5 class="text-white mb-0 mt-1">N° ${u.numero}
                                            <c:if test="${u.etage!=null}"> — Étage ${u.etage}</c:if>
                                        </h5>
                                    </div>
                                    <div class="text-right">
                                        <div class="h3 text-white mb-0 font-weight-bold">
                                            <fmt:formatNumber value="${u.loyerMensuel}" maxFractionDigits="0"/>€
                                        </div>
                                        <div class="text-white text-xs opacity-8">/mois</div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <p class="text-sm font-weight-bold mb-1">
                                    <i class="ni ni-building mr-1 text-muted"></i>${u.immeuble.nom}
                                </p>
                                <p class="text-sm text-muted mb-3">
                                    <i class="ni ni-pin-3 mr-1"></i>${u.immeuble.ville}
                                    <c:if test="${not empty u.immeuble.codePostal}">(${u.immeuble.codePostal})</c:if>
                                </p>
                                <div class="d-flex flex-wrap mb-3" style="gap:8px">
                                    <c:if test="${u.nombrePieces!=null}">
                      <span class="badge badge-secondary badge-pill">
                        <i class="ni ni-app mr-1"></i>${u.nombrePieces} pièce(s)
                      </span>
                                    </c:if>
                                    <c:if test="${u.superficie!=null}">
                                        <span class="badge badge-secondary badge-pill">${u.superficie} m²</span>
                                    </c:if>
                                    <c:if test="${u.charges!=null}">
                      <span class="badge badge-light badge-pill text-muted">
                        +<fmt:formatNumber value="${u.charges}" maxFractionDigits="0"/>€ charges
                      </span>
                                    </c:if>
                                </div>
                                <c:if test="${not empty u.description}">
                                    <p class="text-sm text-muted">${u.description.length()>100?u.description.substring(0,100).concat('...'):u.description}</p>
                                </c:if>
                            </div>
                            <div class="card-footer bg-transparent">
                                <a href="${pageContext.request.contextPath}/locataire/demande?uniteId=${u.id}"
                                   class="btn btn-primary btn-block btn-sm">
                                    <i class="ni ni-send mr-1"></i>Postuler
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
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
