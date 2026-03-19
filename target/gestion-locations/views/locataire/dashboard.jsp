<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Mon espace — ImmoGest</title>
    <jsp:include page="../shared/head.jsp"/>
</head>
<body>
<jsp:include page="../shared/navbar1.jsp">
    <jsp:param name="page" value="dashboard"/>
</jsp:include>
<div class="header bg-primary pb-6">
    <div class="container-fluid">
        <div class="header-body">
            <div class="row align-items-center py-4">
                <div class="col-lg-6 col-7">
                    <h6 class="h2 text-white d-inline-block mb-0">Bonjour, ${sessionScope.utilisateur.prenom} !</h6>
                    <p class="text-white text-sm mb-0 mt-1 opacity-8">Bienvenue sur votre espace locataire</p>
                </div>
            </div>
            <div class="row">
                <div class="col-xl-3 col-md-6">
                    <div class="card card-stats">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <h5 class="card-title text-uppercase text-muted mb-0">Contrats actifs</h5>
                                    <span class="h2 font-weight-bold mb-0">${contratsActifs}</span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-success text-white rounded-circle shadow">
                                        <i class="ni ni-single-copy-04"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card card-stats">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <h5 class="card-title text-uppercase text-muted mb-0">Demandes en attente</h5>
                                    <span class="h2 font-weight-bold mb-0">${demandesEnAttente}</span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-warning text-white rounded-circle shadow">
                                        <i class="ni ni-email-83"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card card-stats">
                        <div class="card-body">
                            <div class="row">
                                <div class="col"><h5 class="card-title text-uppercase text-muted mb-0">Paiements en
                                    retard</h5><span
                                        class="h2 font-weight-bold mb-0 text-danger">${paiementsEnRetard}</span></div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow"><i
                                            class="ni ni-fat-remove"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="card card-stats">
                        <div class="card-body">
                            <div class="row">
                                <div class="col"><h5 class="card-title text-uppercase text-muted mb-0">Offres
                                    disponibles</h5><span class="h2 font-weight-bold mb-0">${offresDisponibles}</span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-info text-white rounded-circle shadow"><i
                                            class="ni ni-zoom-split-in"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid mt--6">
    <!-- Contrat actif -->
    <c:if test="${not empty contratActif}">
        <div class="card mb-4 shadow">
            <div class="card-header bg-gradient-success text-white border-0">
                <div class="d-flex align-items-center justify-content-between">
                    <div><h4 class="text-white mb-0">Mon contrat en cours</h4></div>
                    <span class="badge badge-white text-success font-weight-bold">Actif</span>
                </div>
            </div>
            <div class="card-body">
                <div class="row text-center">
                    <div class="col-6 col-md-3 border-right">
                        <div class="h5 font-weight-bold">${contratActif.reference}</div>
                        <div class="text-muted text-xs text-uppercase">Référence</div>
                    </div>
                    <div class="col-6 col-md-3 border-right">
                        <div class="h5 font-weight-bold">N° ${contratActif.unite.numero}</div>
                        <div class="text-muted text-xs">${contratActif.unite.immeuble.nom}</div>
                    </div>
                    <div class="col-6 col-md-3 border-right">
                        <div class="h4 font-weight-bold text-success"><fmt:formatNumber
                                value="${contratActif.loyerMensuel}" maxFractionDigits="0"/>€
                        </div>
                        <div class="text-muted text-xs text-uppercase">Loyer / mois</div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="h5 font-weight-bold">${contratActif.dateDebut}</div>
                        <div class="text-muted text-xs text-uppercase">Début</div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    <!-- Accès rapides -->
    <div class="card shadow">
        <div class="card-header border-0"><h3 class="mb-0">Accès rapides</h3></div>
        <div class="card-body">
            <div class="row">
                <div class="col-6 col-md-3 mb-3">
                    <a href="${pageContext.request.contextPath}/locataire/offres"
                       class="btn btn-outline-primary btn-block">
                        <i class="ni ni-zoom-split-in d-block mb-1" style="font-size:1.4rem"></i>Voir les offres
                    </a>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <a href="${pageContext.request.contextPath}/locataire/mes-contrats"
                       class="btn btn-outline-success btn-block">
                        <i class="ni ni-single-copy-04 d-block mb-1" style="font-size:1.4rem"></i>Mes contrats
                    </a>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <a href="${pageContext.request.contextPath}/locataire/mes-paiements"
                       class="btn btn-outline-warning btn-block">
                        <i class="ni ni-credit-card d-block mb-1" style="font-size:1.4rem"></i>Mes paiements
                    </a>
                </div>
                <div class="col-6 col-md-3 mb-3">
                    <a href="${pageContext.request.contextPath}/locataire/mes-demandes"
                       class="btn btn-outline-default btn-block">
                        <i class="ni ni-email-83 d-block mb-1" style="font-size:1.4rem"></i>Mes demandes
                    </a>
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
