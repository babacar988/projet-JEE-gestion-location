<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    com.gestionlocations.entities.Utilisateur u =
            (com.gestionlocations.entities.Utilisateur) session.getAttribute("utilisateur");
    if (u == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String role = u.getRole().name().toLowerCase();
    String initials = String.valueOf(u.getPrenom().charAt(0)) + u.getNom().charAt(0);
    pageContext.setAttribute("userRole", role);
    pageContext.setAttribute("initials", initials.toUpperCase());
    pageContext.setAttribute("currentUser", u);
%>

<%-- ═══════════════════════════════════════════════════
     SIDEBAR ARGON
════════════════════════════════════════════════════ --%>
<nav class="sidenav navbar navbar-vertical fixed-left navbar-expand-xs navbar-light bg-white" id="sidenav-main">
    <div class="scrollbar-inner">

        <%-- Brand --%>
        <div class="sidenav-header align-items-center">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/${userRole}/dashboard">
                <img src="${pageContext.request.contextPath}/argon-assets/img/brand/blue.png"
                     class="navbar-brand-img" alt="ImmoGest">
            </a>
        </div>

        <%-- User card --%>
        <div class="card card-profile shadow mt-0 mb-3 mx-3">
            <div class="card-body p-3">
                <div class="d-flex align-items-center">
                    <div class="avatar avatar-sm rounded-circle bg-gradient-primary text-white font-weight-bold mr-2"
                         style="width:36px;height:36px;display:flex;align-items:center;justify-content:center;font-size:13px;flex-shrink:0">
                        ${initials}
                    </div>
                    <div style="min-width:0">
                        <h6 class="mb-0 text-sm font-weight-bold text-truncate">${currentUser.prenom} ${currentUser.nom}</h6>
                        <p class="text-xs text-muted mb-0">
                            <c:choose>
                                <c:when test="${userRole=='admin'}">Administrateur</c:when>
                                <c:when test="${userRole=='proprietaire'}">Propriétaire</c:when>
                                <c:otherwise>Locataire</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <div class="navbar-inner">
            <div class="collapse navbar-collapse" id="sidenav-collapse-main">

                <%-- ── ADMIN ── --%>
                <c:if test="${userRole=='admin'}">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='dashboard'?'active':''}"
                               href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="ni ni-tv-2 text-primary"></i>
                                <span class="nav-link-text">Tableau de bord</span>
                            </a>
                        </li>
                    </ul>
                    <hr class="my-3">
                    <h6 class="navbar-heading p-0 text-muted text-xs font-weight-bold">Patrimoine</h6>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='immeubles'?'active':''}"
                               href="${pageContext.request.contextPath}/admin/immeubles">
                                <i class="ni ni-building text-blue"></i>
                                <span class="nav-link-text">Immeubles</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='unites'?'active':''}"
                               href="${pageContext.request.contextPath}/admin/unites">
                                <i class="ni ni-key-25 text-info"></i>
                                <span class="nav-link-text">Unités</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='contrats'?'active':''}"
                               href="${pageContext.request.contextPath}/admin/contrats">
                                <i class="ni ni-single-copy-04 text-orange"></i>
                                <span class="nav-link-text">Contrats</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='paiements'?'active':''}"
                               href="${pageContext.request.contextPath}/admin/paiements">
                                <i class="ni ni-credit-card text-green"></i>
                                <span class="nav-link-text">Paiements</span>
                            </a>
                        </li>
                    </ul>
                    <hr class="my-3">
                    <h6 class="navbar-heading p-0 text-muted text-xs font-weight-bold">Administration</h6>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='utilisateurs'?'active':''}"
                               href="${pageContext.request.contextPath}/admin/utilisateurs">
                                <i class="ni ni-circle-08 text-pink"></i>
                                <span class="nav-link-text">Utilisateurs</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='demandes'?'active':''}"
                               href="${pageContext.request.contextPath}/admin/demandes">
                                <i class="ni ni-email-83 text-yellow"></i>
                                <span class="nav-link-text">Demandes</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='rapports'?'active':''}"
                               href="${pageContext.request.contextPath}/admin/rapports">
                                <i class="ni ni-chart-bar-32 text-default"></i>
                                <span class="nav-link-text">Rapports</span>
                            </a>
                        </li>
                    </ul>
                </c:if>

                <%-- ── PROPRIETAIRE ── --%>
                <c:if test="${userRole=='proprietaire'}">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='dashboard'?'active':''}"
                               href="${pageContext.request.contextPath}/proprietaire/dashboard">
                                <i class="ni ni-tv-2 text-primary"></i>
                                <span class="nav-link-text">Tableau de bord</span>
                            </a>
                        </li>
                    </ul>
                    <hr class="my-3">
                    <h6 class="navbar-heading p-0 text-muted text-xs font-weight-bold">Mon patrimoine</h6>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='immeubles'?'active':''}"
                               href="${pageContext.request.contextPath}/proprietaire/immeubles">
                                <i class="ni ni-building text-blue"></i>
                                <span class="nav-link-text">Mes immeubles</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='immeuble-form'?'active':''}"
                               href="${pageContext.request.contextPath}/proprietaire/immeuble-form">
                                <i class="ni ni-fat-add text-primary"></i>
                                <span class="nav-link-text">Ajouter immeuble</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='unites'?'active':''}"
                               href="${pageContext.request.contextPath}/proprietaire/unites">
                                <i class="ni ni-key-25 text-info"></i>
                                <span class="nav-link-text">Mes unités</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='unite-form'?'active':''}"
                               href="${pageContext.request.contextPath}/proprietaire/unite-form">
                                <i class="ni ni-fat-add text-info"></i>
                                <span class="nav-link-text">Ajouter une unité</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='contrats'?'active':''}"
                               href="${pageContext.request.contextPath}/proprietaire/contrats">
                                <i class="ni ni-single-copy-04 text-orange"></i>
                                <span class="nav-link-text">Mes contrats</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='paiements'?'active':''}"
                               href="${pageContext.request.contextPath}/proprietaire/paiements">
                                <i class="ni ni-credit-card text-green"></i>
                                <span class="nav-link-text">Paiements reçus</span>
                            </a>
                        </li>
                    </ul>
                </c:if>

                <%-- ── LOCATAIRE ── --%>
                <c:if test="${userRole=='locataire'}">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='dashboard'?'active':''}"
                               href="${pageContext.request.contextPath}/locataire/dashboard">
                                <i class="ni ni-tv-2 text-primary"></i>
                                <span class="nav-link-text">Tableau de bord</span>
                            </a>
                        </li>
                    </ul>
                    <hr class="my-3">
                    <h6 class="navbar-heading p-0 text-muted text-xs font-weight-bold">Mon espace</h6>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='offres'?'active':''}"
                               href="${pageContext.request.contextPath}/locataire/offres">
                                <i class="ni ni-zoom-split-in text-primary"></i>
                                <span class="nav-link-text">Offres disponibles</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='mes-contrats'?'active':''}"
                               href="${pageContext.request.contextPath}/locataire/mes-contrats">
                                <i class="ni ni-single-copy-04 text-orange"></i>
                                <span class="nav-link-text">Mes contrats</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='mes-paiements'?'active':''}"
                               href="${pageContext.request.contextPath}/locataire/mes-paiements">
                                <i class="ni ni-credit-card text-green"></i>
                                <span class="nav-link-text">Mes paiements</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.page=='mes-demandes'?'active':''}"
                               href="${pageContext.request.contextPath}/locataire/mes-demandes">
                                <i class="ni ni-email-83 text-yellow"></i>
                                <span class="nav-link-text">Mes demandes</span>
                            </a>
                        </li>
                    </ul>
                </c:if>

                <%-- Compte (commun) --%>
                <hr class="my-3">
                <h6 class="navbar-heading p-0 text-muted text-xs font-weight-bold">Compte</h6>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link ${param.page=='profil'?'active':''}"
                           href="${pageContext.request.contextPath}/profil">
                            <i class="ni ni-single-02 text-yellow"></i>
                            <span class="nav-link-text">Mon profil</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-danger" href="#"
                           onclick="openLogoutModal(); return false;">
                            <i class="ni ni-user-run text-danger"></i>
                            <span class="nav-link-text">Déconnexion</span>
                        </a>
                    </li>
                </ul>

            </div>
        </div>
    </div>
</nav>

<%-- ═══════════════════════════════════════════════════
     TOPNAV ARGON (ouvre main-content)
════════════════════════════════════════════════════ --%>
<div class="main-content" id="panel">
    <nav class="navbar navbar-top navbar-expand navbar-dark bg-primary border-bottom">
        <div class="container-fluid">
            <div class="collapse navbar-collapse" id="navbarSupportedContent">

                <%-- Breadcrumb --%>
                <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                    <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/${userRole}/dashboard">
                                <i class="fas fa-home"></i>
                            </a>
                        </li>
                        <li class="breadcrumb-item active text-white">
                            <c:choose>
                                <c:when test="${param.page=='dashboard'}">Tableau de bord</c:when>
                                <c:when test="${param.page=='immeubles'}">Immeubles</c:when>
                                <c:when test="${param.page=='immeuble-form'}">Ajouter immeuble</c:when>
                                <c:when test="${param.page=='unites'}">Unités</c:when>
                                <c:when test="${param.page=='unite-form'}">Ajouter unité</c:when>
                                <c:when test="${param.page=='contrats'}">Contrats</c:when>
                                <c:when test="${param.page=='paiements'}">Paiements</c:when>
                                <c:when test="${param.page=='demandes'}">Demandes</c:when>
                                <c:when test="${param.page=='utilisateurs'}">Utilisateurs</c:when>
                                <c:when test="${param.page=='rapports'}">Rapports</c:when>
                                <c:when test="${param.page=='offres'}">Offres disponibles</c:when>
                                <c:when test="${param.page=='mes-contrats'}">Mes contrats</c:when>
                                <c:when test="${param.page=='mes-paiements'}">Mes paiements</c:when>
                                <c:when test="${param.page=='mes-demandes'}">Mes demandes</c:when>
                                <c:when test="${param.page=='profil'}">Mon profil</c:when>
                                <c:otherwise>ImmoGest</c:otherwise>
                            </c:choose>
                        </li>
                    </ol>
                </nav>

                <%-- Toggle mobile --%>
                <ul class="navbar-nav align-items-center ml-md-auto">
                    <li class="nav-item d-xl-none">
                        <div class="pr-3 sidenav-toggler sidenav-toggler-dark"
                             data-action="sidenav-pin" data-target="#sidenav-main">
                            <div class="sidenav-toggler-inner">
                                <i class="sidenav-toggler-line"></i>
                                <i class="sidenav-toggler-line"></i>
                                <i class="sidenav-toggler-line"></i>
                            </div>
                        </div>
                    </li>
                </ul>

                <%-- Dropdown utilisateur à droite --%>
                <ul class="navbar-nav align-items-center ml-auto ml-md-0">
                    <li class="nav-item dropdown">
                        <a class="nav-link pr-0" href="#" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <div class="media align-items-center">
                <span class="avatar avatar-sm rounded-circle bg-white text-primary font-weight-bold"
                      style="display:flex;align-items:center;justify-content:center;font-size:11px;width:36px;height:36px">
                    ${initials}
                </span>
                                <div class="media-body ml-2 d-none d-lg-block">
                  <span class="mb-0 text-sm font-weight-bold text-white">
                    ${currentUser.prenom} ${currentUser.nom}
                  </span>
                                </div>
                            </div>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right">
                            <div class="dropdown-header noti-title">
                                <h6 class="text-overflow m-0">Bienvenue !</h6>
                            </div>
                            <a href="${pageContext.request.contextPath}/profil" class="dropdown-item">
                                <i class="ni ni-single-02"></i>
                                <span>Mon profil</span>
                            </a>
                            <div class="dropdown-divider"></div>
                            <a href="#" class="dropdown-item text-danger"
                               onclick="openLogoutModal(); return false;">
                                <i class="ni ni-user-run"></i>
                                <span>Déconnexion</span>
                            </a>
                        </div>
                    </li>
                </ul>

            </div>
        </div>
    </nav>
    <%-- ↑ main-content reste OUVERT — chaque JSP le ferme avec </div><!-- /.main-content --> --%>

    <%-- ═══════════════════════════════════════════════════
         MODALE DÉCONNEXION
    ════════════════════════════════════════════════════ --%>
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
         aria-labelledby="logoutModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title font-weight-bold" id="logoutModalLabel">
                        <i class="ni ni-user-run text-danger mr-2"></i>Déconnexion
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fermer">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center py-4">
                    <div class="mb-3">
          <span class="btn btn-icon btn-warning btn-lg rounded-circle"
                style="pointer-events:none;width:60px;height:60px">
            <i class="ni ni-user-run" style="font-size:1.5rem"></i>
          </span>
                    </div>
                    <p class="text-sm text-muted mb-0">
                        Voulez-vous vraiment quitter votre session ?
                    </p>
                    <p class="text-xs text-muted">Vous devrez vous reconnecter ensuite.</p>
                </div>
                <div class="modal-footer border-0 pt-0 d-flex justify-content-center" style="gap:10px">
                    <button type="button" class="btn btn-outline-secondary btn-sm"
                            data-dismiss="modal">
                        Annuler
                    </button>
                    <a href="${pageContext.request.contextPath}/logout"
                       class="btn btn-danger btn-sm">
                        <i class="ni ni-user-run mr-1"></i>Se déconnecter
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openLogoutModal() {
            $('#logoutModal').modal('show');
        }
    </script>
