<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html>
<head><title>Mes immeubles — ImmoGest</title>
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
                <div class="col-lg-6 col-7"><h6 class="h2 text-white d-inline-block mb-0">Mes immeubles</h6></div>
                <div class="col-lg-6 col-5 text-right">
                    <a href="${pageContext.request.contextPath}/proprietaire/immeuble-form"
                       class="btn btn-sm btn-neutral">
                        <i class="ni ni-fat-add mr-1"></i>Ajouter
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid mt--6">
    <c:choose>
        <c:when test="${empty immeubles}">
            <div class="card">
                <div class="card-body text-center py-5">
                    <i class="ni ni-building" style="font-size:3rem;color:#ccc"></i>
                    <h4 class="mt-3 text-muted">Aucun immeuble</h4>
                    <p class="text-muted">Vous n'avez pas encore d'immeubles enregistrés.</p>
                    <a href="${pageContext.request.contextPath}/proprietaire/immeuble-form" class="btn btn-primary">
                        <i class="ni ni-fat-add mr-1"></i>Ajouter un immeuble
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <c:forEach var="imm" items="${immeubles}">
                    <div class="col-xl-4 col-md-6 mb-4">
                        <div class="card shadow h-100">
                            <div class="card-header bg-gradient-primary border-0 py-3">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div>
                                        <h5 class="text-white mb-0 font-weight-bold">${imm.nom}</h5>
                                        <p class="text-white text-xs mb-0 opacity-8">${imm.ville}</p>
                                    </div>
                                    <div class="icon icon-shape bg-white text-primary rounded-circle shadow"
                                         style="width:40px;height:40px">
                                        <i class="ni ni-building"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <p class="text-sm text-muted mb-2">
                                    <i class="ni ni-pin-3 mr-1"></i>${imm.adresse}
                                    <c:if test="${not empty imm.codePostal}">, ${imm.codePostal}</c:if>
                                </p>
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="badge badge-primary badge-pill">${imm.type}</span>
                                    <span class="badge badge-success badge-pill">
                      <i class="ni ni-key-25 mr-1"></i>${imm.nombreUnites} unité(s)
                    </span>
                                </div>
                                <c:if test="${not empty imm.description}">
                                    <p class="text-sm text-muted" style="line-height:1.5">
                                            ${imm.description.length() > 80 ? imm.description.substring(0,80).concat('...') : imm.description}
                                    </p>
                                </c:if>
                            </div>
                            <div class="card-footer bg-transparent d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/proprietaire/immeuble-detail?id=${imm.id}"
                                   class="btn btn-sm btn-outline-primary">
                                    <i class="ni ni-zoom-split-in mr-1"></i>Détail
                                </a>
                                <a href="${pageContext.request.contextPath}/proprietaire/immeuble-form?id=${imm.id}"
                                   class="btn btn-sm btn-outline-default">
                                    <i class="ni ni-settings mr-1"></i>Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/proprietaire/unite-form?immeubleId=${imm.id}"
                                   class="btn btn-sm btn-outline-info">
                                    <i class="ni ni-fat-add mr-1"></i>Unité
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
