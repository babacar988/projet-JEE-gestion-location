<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="64kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Dashboard Admin — ImmoGest</title>
  <jsp:include page="../shared/head.jsp"/>
</head>
<body>
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="dashboard"/></jsp:include>
  <div class="main-content" id="panel">
<%--    <jsp:include page="../shared/topnav.jsp"/>--%>
    <!-- Header -->
    <div class="header bg-primary pb-6">
      <div class="container-fluid">
        <div class="header-body">
          <div class="row align-items-center py-4">
            <div class="col-lg-6 col-7">
              <h6 class="h2 text-white d-inline-block mb-0">Tableau de bord</h6>
              <nav aria-label="breadcrumb" class="d-none d-md-inline-block ml-md-4">
                <ol class="breadcrumb breadcrumb-links breadcrumb-dark">
                  <li class="breadcrumb-item"><a href="#"><i class="fas fa-home"></i></a></li>
                  <li class="breadcrumb-item active">Dashboard</li>
                </ol>
              </nav>
            </div>
            <div class="col-lg-6 col-5 text-right">
              <span class="text-white text-sm">
                <%=new java.text.SimpleDateFormat("EEEE d MMMM yyyy",java.util.Locale.FRENCH).format(new java.util.Date())%>
              </span>
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
                      <div class="icon icon-shape bg-gradient-orange text-white rounded-circle shadow">
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
                      <div class="icon icon-shape bg-gradient-yellow text-white rounded-circle shadow">
                        <i class="ni ni-shop"></i>
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
                      <div class="icon icon-shape bg-gradient-green text-white rounded-circle shadow">
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
                      <h5 class="card-title text-uppercase text-muted mb-0">Revenus</h5>
                      <span class="h2 font-weight-bold mb-0"><fmt:formatNumber value="${totalRevenu}" maxFractionDigits="0"/>€</span>
                    </div>
                    <div class="col-auto">
                      <div class="icon icon-shape bg-gradient-info text-white rounded-circle shadow">
                        <i class="ni ni-credit-card"></i>
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
        <!-- Taux d'occupation -->
        <div class="col-xl-4">
          <div class="card">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col"><h3 class="mb-0">Occupation</h3></div>
              </div>
            </div>
            <div class="card-body">
              <%
                Long occ = (Long)request.getAttribute("unitesOccupees");
                Long dis = (Long)request.getAttribute("unitesDisponibles");
                if(occ==null)occ=0L; if(dis==null)dis=0L;
                long tot=occ+dis; int pct=tot>0?(int)(occ*100/tot):0;
              %>
              <div class="text-center mb-3">
                <span class="h1 font-weight-bold"><%=pct%>%</span>
                <p class="text-muted mb-0">taux d'occupation</p>
              </div>
              <div class="progress mb-3">
                <div class="progress-bar bg-gradient-primary" style="width:<%=pct%>%"></div>
              </div>
              <div class="row text-center">
                <div class="col-6">
                  <span class="badge badge-dot">
                    <i class="bg-danger"></i>
                  </span>
                  <span class="text-sm">Occupées <strong><%=occ%></strong></span>
                </div>
                <div class="col-6">
                  <span class="badge badge-dot">
                    <i class="bg-success"></i>
                  </span>
                  <span class="text-sm">Disponibles <strong><%=dis%></strong></span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- Alertes & actions rapides -->
        <div class="col-xl-4">
          <div class="card">
            <div class="card-header border-0">
              <h3 class="mb-0">Alertes</h3>
            </div>
            <div class="card-body">
              <c:if test="${paiementsEnRetard > 0}">
                <div class="alert alert-danger" role="alert">
                  <i class="fas fa-exclamation-triangle mr-2"></i>
                  <strong>${paiementsEnRetard}</strong> paiement(s) en retard
                </div>
              </c:if>
              <c:if test="${demandesEnAttente > 0}">
                <div class="alert alert-warning" role="alert">
                  <i class="fas fa-clock mr-2"></i>
                  <strong>${demandesEnAttente}</strong> demande(s) en attente
                </div>
              </c:if>
              <c:if test="${paiementsEnRetard == 0 && demandesEnAttente == 0}">
                <div class="alert alert-success"><i class="fas fa-check-circle mr-2"></i>Tout est en ordre !</div>
              </c:if>
            </div>
          </div>
        </div>
        <!-- Accès rapides -->
        <div class="col-xl-4">
          <div class="card">
            <div class="card-header border-0">
              <h3 class="mb-0">Actions rapides</h3>
            </div>
            <div class="card-body">
              <a href="${pageContext.request.contextPath}/admin/immeubles?action=nouveau"
                 class="btn btn-primary btn-block mb-2">
                <i class="ni ni-building mr-2"></i>Nouvel immeuble
              </a>
              <a href="${pageContext.request.contextPath}/admin/unites?action=nouveau"
                 class="btn btn-outline-primary btn-block mb-2">
                <i class="ni ni-shop mr-2"></i>Nouvelle unité
              </a>
              <a href="${pageContext.request.contextPath}/admin/contrats?action=nouveau"
                 class="btn btn-outline-primary btn-block mb-2">
                <i class="ni ni-single-copy-04 mr-2"></i>Nouveau contrat
              </a>
              <a href="${pageContext.request.contextPath}/admin/paiements?action=nouveau"
                 class="btn btn-outline-primary btn-block">
                <i class="ni ni-credit-card mr-2"></i>Enregistrer paiement
              </a>
            </div>
          </div>
        </div>
      </div>
      <!-- Footer -->
      <footer class="footer pt-0">
        <div class="row align-items-center justify-content-lg-between">
          <div class="col-lg-6">
            <div class="copyright text-center text-lg-left text-muted">
              &copy; <%=java.time.Year.now()%> <strong>ImmoGest</strong> — Gestion locative
            </div>
          </div>
        </div>
      </footer>
    </div>
  </div>
</div><!-- /.main-content -->
<jsp:include page="../shared/scripts.jsp"/>
</body>
</html>
