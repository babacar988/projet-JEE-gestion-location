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
                    <h6 class="h2 text-white d-inline-block mb-0">
                        Bonjour, ${sessionScope.utilisateur.prenom} !
                    </h6>
                    <p class="text-white text-sm mb-0 mt-1 opacity-8">
                        <%=new java.text.SimpleDateFormat("EEEE d MMMM yyyy", java.util.Locale.FRENCH).format(new java.util.Date())%>
                    </p>
                </div>
            </div>
            <!-- Stat cards -->
            <div class="row">
                <div class="col-xl-3 col-md-6">
                    <div class="card card-stats">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <h5 class="card-title text-uppercase text-muted mb-0">Immeubles</h5>
                                    <span class="h2 font-weight-bold mb-0">${totalImmeubles}</span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-primary text-white rounded-circle shadow">
                                        <i class="ni ni-building"></i>
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
                                    <h5 class="card-title text-uppercase text-muted mb-0">Unités</h5>
                                    <span class="h2 font-weight-bold mb-0">${totalUnites}</span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-info text-white rounded-circle shadow">
                                        <i class="ni ni-key-25"></i>
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
                                    <h5 class="card-title text-uppercase text-muted mb-0">Revenus encaissés</h5>
                                    <span class="h2 font-weight-bold mb-0">
                      <fmt:formatNumber value="${totalRevenu}" maxFractionDigits="0"/>€
                    </span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-orange text-white rounded-circle shadow">
                                        <i class="ni ni-money-coins"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Page content -->
<div class="container-fluid mt--6">
    <div class="row">
        <!-- Taux occupation -->
        <div class="col-xl-4">
            <div class="card">
                <div class="card-header border-0">
                    <div class="row align-items-center">
                        <div class="col"><h3 class="mb-0">Taux d'occupation</h3></div>
                        <div class="col text-right">
                            <%
                                Long occ = (Long) request.getAttribute("unitesOccupees");
                                Long dis = (Long) request.getAttribute("unitesDisponibles");
                                if (occ == null) occ = 0L;
                                if (dis == null) dis = 0L;
                                long tot = occ + dis;
                                int pct = tot > 0 ? (int) (occ * 100 / tot) : 0;
                            %>
                            <span class="h3 font-weight-bold mb-0 text-primary"><%=pct%>%</span>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="progress mb-3" style="height:10px">
                        <div class="progress-bar bg-gradient-success" style="width:<%=pct%>%"></div>
                    </div>
                    <div class="row text-center">
                        <div class="col-4 border-right">
                            <span class="d-block h4 font-weight-bold"><%=occ%></span>
                            <span class="text-muted text-xs">Occupées</span>
                        </div>
                        <div class="col-4 border-right">
                            <span class="d-block h4 font-weight-bold"><%=dis%></span>
                            <span class="text-muted text-xs">Disponibles</span>
                        </div>
                        <div class="col-4">
                            <span class="d-block h4 font-weight-bold text-danger">${paiementsEnRetard}</span>
                            <span class="text-muted text-xs">En retard</span>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Locataires -->
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <h5 class="card-title text-uppercase text-muted mb-0">Locataires actifs</h5>
                            <span class="h2 font-weight-bold mb-0">${totalLocataires}</span>
                        </div>
                        <div class="icon icon-shape bg-gradient-purple text-white rounded-circle shadow">
                            <i class="ni ni-circle-08"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Accès rapides -->
        <div class="col-xl-8">
            <div class="card">
                <div class="card-header border-0"><h3 class="mb-0">Accès rapides</h3></div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-6 col-md-4 mb-3">
                            <a href="${pageContext.request.contextPath}/proprietaire/immeubles"
                               class="btn btn-outline-primary btn-block">
                                <i class="ni ni-building d-block mb-1" style="font-size:1.4rem"></i>
                                Mes immeubles
                            </a>
                        </div>
                        <div class="col-6 col-md-4 mb-3">
                            <a href="${pageContext.request.contextPath}/proprietaire/immeuble-form"
                               class="btn btn-outline-default btn-block">
                                <i class="ni ni-fat-add d-block mb-1" style="font-size:1.4rem"></i>
                                Ajouter immeuble
                            </a>
                        </div>
                        <div class="col-6 col-md-4 mb-3">
                            <a href="${pageContext.request.contextPath}/proprietaire/unites"
                               class="btn btn-outline-info btn-block">
                                <i class="ni ni-key-25 d-block mb-1" style="font-size:1.4rem"></i>
                                Mes unités
                            </a>
                        </div>
                        <div class="col-6 col-md-4 mb-3">
                            <a href="${pageContext.request.contextPath}/proprietaire/unite-form"
                               class="btn btn-outline-default btn-block">
                                <i class="ni ni-fat-add d-block mb-1" style="font-size:1.4rem"></i>
                                Ajouter unité
                            </a>
                        </div>
                        <div class="col-6 col-md-4 mb-3">
                            <a href="${pageContext.request.contextPath}/proprietaire/contrats"
                               class="btn btn-outline-success btn-block">
                                <i class="ni ni-single-copy-04 d-block mb-1" style="font-size:1.4rem"></i>
                                Mes contrats
                            </a>
                        </div>
                        <div class="col-6 col-md-4 mb-3">
                            <a href="${pageContext.request.contextPath}/proprietaire/paiements"
                               class="btn btn-outline-warning btn-block">
                                <i class="ni ni-credit-card d-block mb-1" style="font-size:1.4rem"></i>
                                Paiements reçus
                            </a>
                        </div>
                    </div>
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
