<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Mes unités — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
<jsp:include page="../shared/navbar1.jsp"><jsp:param name="page" value="unites"/></jsp:include>
  <div class="header bg-primary pb-6"><div class="container-fluid"><div class="header-body">
    <div class="row align-items-center py-4">
      <div class="col-lg-6 col-7"><h6 class="h2 text-white d-inline-block mb-0">Mes unités</h6></div>
      <div class="col-lg-6 col-5 text-right">
        <a href="${pageContext.request.contextPath}/proprietaire/unite-form" class="btn btn-sm btn-neutral">
          <i class="ni ni-fat-add mr-1"></i>Nouvelle unité
        </a>
      </div>
    </div>
    <!-- Stats mini -->
    <div class="row">
      <div class="col-xl-3 col-md-6">
        <div class="card card-stats"><div class="card-body">
          <div class="row"><div class="col">
            <h5 class="card-title text-uppercase text-muted mb-0">Total</h5>
            <span class="h2 font-weight-bold mb-0">${unites.size()}</span>
          </div><div class="col-auto"><div class="icon icon-shape bg-gradient-primary text-white rounded-circle shadow"><i class="ni ni-key-25"></i></div></div></div>
        </div></div>
      </div>
      <div class="col-xl-3 col-md-6">
        <div class="card card-stats"><div class="card-body">
          <div class="row"><div class="col">
            <h5 class="card-title text-uppercase text-muted mb-0">Disponibles</h5>
            <c:set var="nbD" value="0"/>
            <c:forEach var="u" items="${unites}"><c:if test="${u.statut=='DISPONIBLE'}"><c:set var="nbD" value="${nbD+1}"/></c:if></c:forEach>
            <span class="h2 font-weight-bold mb-0 text-success">${nbD}</span>
          </div><div class="col-auto"><div class="icon icon-shape bg-gradient-success text-white rounded-circle shadow"><i class="ni ni-check-bold"></i></div></div></div>
        </div></div>
      </div>
      <div class="col-xl-3 col-md-6">
        <div class="card card-stats"><div class="card-body">
          <div class="row"><div class="col">
            <h5 class="card-title text-uppercase text-muted mb-0">Occupées</h5>
            <c:set var="nbO" value="0"/>
            <c:forEach var="u" items="${unites}"><c:if test="${u.statut=='OCCUPEE'}"><c:set var="nbO" value="${nbO+1}"/></c:if></c:forEach>
            <span class="h2 font-weight-bold mb-0 text-danger">${nbO}</span>
          </div><div class="col-auto"><div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow"><i class="ni ni-fat-remove"></i></div></div></div>
        </div></div>
      </div>
      <div class="col-xl-3 col-md-6">
        <div class="card card-stats"><div class="card-body">
          <div class="row"><div class="col">
            <h5 class="card-title text-uppercase text-muted mb-0">Immeubles</h5>
            <span class="h2 font-weight-bold mb-0">${immeubles.size()}</span>
          </div><div class="col-auto"><div class="icon icon-shape bg-gradient-info text-white rounded-circle shadow"><i class="ni ni-building"></i></div></div></div>
        </div></div>
      </div>
    </div>
  </div></div></div>
  <div class="container-fluid mt--6">
    <!-- Filtre -->
    <div class="card mb-3"><div class="card-body py-3">
      <div class="d-flex align-items-center" style="gap:12px;flex-wrap:wrap">
        <span class="text-sm font-weight-bold text-muted">Filtrer par immeuble :</span>
        <select id="filterImm" class="form-control form-control-sm" style="max-width:260px"
                onchange="filterByImm(this.value)">
          <option value="">Tous les immeubles</option>
          <c:forEach var="imm" items="${immeubles}">
            <option value="${imm.id}">${imm.nom} — ${imm.ville}</option>
          </c:forEach>
        </select>
      </div>
    </div></div>
    <div class="card">
      <div class="table-responsive">
        <table class="table align-items-center table-flush" id="unitesTable">
          <thead class="thead-light">
            <tr><th>N° / Étage</th><th>Immeuble</th><th>Type</th><th>Pièces</th><th>Surface</th><th>Loyer</th><th>Statut</th><th>Actions</th></tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${empty unites}">
                <tr><td colspan="8" class="text-center py-5">
                  <i class="ni ni-key-25" style="font-size:2rem;color:#ccc"></i>
                  <p class="text-muted mt-2 mb-3">Aucune unité</p>
                  <a href="${pageContext.request.contextPath}/proprietaire/unite-form" class="btn btn-sm btn-primary">Ajouter une unité</a>
                </td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="u" items="${unites}">
                  <tr data-imm="${u.immeuble.id}">
                    <td>
                      <div class="font-weight-bold">N° ${u.numero}</div>
                      <div class="text-xs text-muted"><c:choose><c:when test="${u.etage!=null}">Étage ${u.etage}</c:when><c:otherwise>RDC</c:otherwise></c:choose></div>
                    </td>
                    <td>
                      <div class="font-weight-bold text-sm">${u.immeuble.nom}</div>
                      <div class="text-xs text-muted">${u.immeuble.ville}</div>
                    </td>
                    <td><span class="badge badge-primary badge-pill text-xs">${u.type}</span></td>
                    <td class="text-sm"><c:choose><c:when test="${u.nombrePieces!=null}">${u.nombrePieces} p.</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                    <td class="text-sm"><c:choose><c:when test="${u.superficie!=null}">${u.superficie} m²</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                    <td class="font-weight-bold"><fmt:formatNumber value="${u.loyerMensuel}" maxFractionDigits="0"/>€</td>
                    <td>
                      <c:choose>
                        <c:when test="${u.statut=='DISPONIBLE'}"><span class="badge badge-success badge-pill">Disponible</span></c:when>
                        <c:when test="${u.statut=='OCCUPEE'}">   <span class="badge badge-danger  badge-pill">Occupée</span></c:when>
                        <c:when test="${u.statut=='EN_TRAVAUX'}"><span class="badge badge-warning badge-pill">Travaux</span></c:when>
                        <c:otherwise>                            <span class="badge badge-default badge-pill">${u.statut}</span></c:otherwise>
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
    <footer class="footer pt-0"><div class="row"><div class="col"><p class="text-muted text-sm">ImmoGest &copy; 2025</p></div></div></footer>
  </div>
</div>
<jsp:include page="../shared/scripts.jsp"/>
<script>
function filterByImm(immId) {
  document.querySelectorAll('#unitesTable tbody tr').forEach(tr => {
    tr.style.display = (!immId || tr.dataset.imm === immId) ? '' : 'none';
  });
}
</script>
</body></html>
