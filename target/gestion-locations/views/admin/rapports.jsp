<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="64kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Rapports — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="rapports"/></jsp:include>
  <div class="main-content" id="panel">
<%--    <jsp:include page="../shared/topnav.jsp"/>--%>
    <div class="header bg-primary pb-6">
      <div class="container-fluid"><div class="header-body">
        <div class="row align-items-center py-4">
          <div class="col"><h6 class="h2 text-white d-inline-block mb-0">Rapports & Statistiques</h6></div>
        </div>
        <!-- KPI row -->
        <div class="row">
          <div class="col-xl-2 col-md-4 col-6">
            <div class="card card-stats"><div class="card-body">
              <div class="row"><div class="col">
                <h5 class="card-title text-uppercase text-muted mb-0">Immeubles</h5>
                <span class="h2 font-weight-bold mb-0">${totalImmeubles}</span>
              </div><div class="col-auto">
                <div class="icon icon-shape bg-gradient-orange text-white rounded-circle shadow"><i class="ni ni-building"></i></div>
              </div></div>
            </div></div>
          </div>
          <div class="col-xl-2 col-md-4 col-6">
            <div class="card card-stats"><div class="card-body">
              <div class="row"><div class="col">
                <h5 class="card-title text-uppercase text-muted mb-0">Unités</h5>
                <span class="h2 font-weight-bold mb-0">${totalUnites}</span>
              </div><div class="col-auto">
                <div class="icon icon-shape bg-gradient-yellow text-white rounded-circle shadow"><i class="ni ni-shop"></i></div>
              </div></div>
            </div></div>
          </div>
          <div class="col-xl-2 col-md-4 col-6">
            <div class="card card-stats"><div class="card-body">
              <div class="row"><div class="col">
                <h5 class="card-title text-uppercase text-muted mb-0">Contrats</h5>
                <span class="h2 font-weight-bold mb-0">${contratsActifs}</span>
              </div><div class="col-auto">
                <div class="icon icon-shape bg-gradient-green text-white rounded-circle shadow"><i class="ni ni-single-copy-04"></i></div>
              </div></div>
            </div></div>
          </div>
          <div class="col-xl-2 col-md-4 col-6">
            <div class="card card-stats"><div class="card-body">
              <div class="row"><div class="col">
                <h5 class="card-title text-uppercase text-muted mb-0">Revenus</h5>
                <span class="h2 font-weight-bold mb-0 text-success"><fmt:formatNumber value="${totalRevenu}" maxFractionDigits="0"/>€</span>
              </div><div class="col-auto">
                <div class="icon icon-shape bg-gradient-info text-white rounded-circle shadow"><i class="ni ni-credit-card"></i></div>
              </div></div>
            </div></div>
          </div>
          <div class="col-xl-2 col-md-4 col-6">
            <div class="card card-stats"><div class="card-body">
              <div class="row"><div class="col">
                <h5 class="card-title text-uppercase text-muted mb-0">En retard</h5>
                <span class="h2 font-weight-bold mb-0 text-danger">${paiementsEnRetard}</span>
              </div><div class="col-auto">
                <div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow"><i class="ni ni-fat-remove"></i></div>
              </div></div>
            </div></div>
          </div>
          <div class="col-xl-2 col-md-4 col-6">
            <div class="card card-stats"><div class="card-body">
              <div class="row"><div class="col">
                <h5 class="card-title text-uppercase text-muted mb-0">Locataires</h5>
                <span class="h2 font-weight-bold mb-0">${totalLocataires}</span>
              </div><div class="col-auto">
                <div class="icon icon-shape bg-gradient-purple text-white rounded-circle shadow"><i class="ni ni-single-02"></i></div>
              </div></div>
            </div></div>
          </div>
        </div>
      </div></div>
    </div>
    <div class="container-fluid mt--6">
      <div class="row">
        <!-- Taux occupation -->
        <div class="col-xl-6">
          <div class="card">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col"><h3 class="mb-0">Taux d'occupation</h3></div>
                <%
                  Long occ=(Long)request.getAttribute("unitesOccupees");
                  Long dis=(Long)request.getAttribute("unitesDisponibles");
                  if(occ==null)occ=0L; if(dis==null)dis=0L;
                  long tot=occ+dis; int pct=tot>0?(int)(occ*100/tot):0;
                %>
                <div class="col text-right">
                  <span class="h2 font-weight-bold text-primary"><%=pct%>%</span>
                </div>
              </div>
            </div>
            <div class="card-body">
              <div class="progress mb-3" style="height:12px">
                <div class="progress-bar bg-gradient-primary" style="width:<%=pct%>%"></div>
              </div>
              <div class="row">
                <div class="col text-center">
                  <span class="h4 font-weight-bold text-danger"><%=occ%></span>
                  <p class="text-muted text-sm mb-0">Occupées</p>
                </div>
                <div class="col text-center">
                  <span class="h4 font-weight-bold text-success"><%=dis%></span>
                  <p class="text-muted text-sm mb-0">Disponibles</p>
                </div>
                <div class="col text-center">
                  <span class="h4 font-weight-bold"><%=tot%></span>
                  <p class="text-muted text-sm mb-0">Total</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- Actions rapides -->
        <div class="col-xl-6">
          <div class="card">
            <div class="card-header border-0"><h3 class="mb-0">Actions</h3></div>
            <div class="card-body">
              <div class="row">
                <div class="col-6 mb-3">
                  <a href="${pageContext.request.contextPath}/admin/immeubles" class="btn btn-outline-primary btn-block">
                    <i class="ni ni-building mr-2"></i>Immeubles
                  </a>
                </div>
                <div class="col-6 mb-3">
                  <a href="${pageContext.request.contextPath}/admin/unites" class="btn btn-outline-primary btn-block">
                    <i class="ni ni-shop mr-2"></i>Unités
                  </a>
                </div>
                <div class="col-6 mb-3">
                  <a href="${pageContext.request.contextPath}/admin/contrats" class="btn btn-outline-primary btn-block">
                    <i class="ni ni-single-copy-04 mr-2"></i>Contrats
                  </a>
                </div>
                <div class="col-6 mb-3">
                  <a href="${pageContext.request.contextPath}/admin/paiements" class="btn btn-outline-primary btn-block">
                    <i class="ni ni-credit-card mr-2"></i>Paiements
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <footer class="footer pt-0"><div class="copyright text-center text-muted">&copy; <%=java.time.Year.now()%> ImmoGest</div></footer>
    </div>
  </div>
  </div><!-- /.main-content -->
<jsp:include page="../shared/scripts.jsp"/>
</body></html>
