<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="256kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Paiements — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
<jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="paiements"/></jsp:include>
  <div class="header bg-primary pb-6"><div class="container-fluid"><div class="header-body">
    <div class="row align-items-center py-4">
      <div class="col-lg-6 col-7"><h6 class="h2 text-white d-inline-block mb-0">Paiements</h6></div>
      <div class="col-lg-6 col-5 text-right">
        <a href="${pageContext.request.contextPath}/admin/paiements?action=nouveau" class="btn btn-sm btn-neutral">
          <i class="ni ni-fat-add mr-1"></i>Enregistrer
        </a>
      </div>
    </div>
    <!-- Stats -->
    <div class="row">
      <div class="col-xl-4 col-md-6">
        <div class="card card-stats"><div class="card-body"><div class="row">
          <div class="col"><h5 class="card-title text-uppercase text-muted mb-0">Total encaissé</h5>
            <span class="h2 font-weight-bold mb-0 text-success"><fmt:formatNumber value="${totalPaye}" maxFractionDigits="0"/>€</span></div>
          <div class="col-auto"><div class="icon icon-shape bg-gradient-success text-white rounded-circle shadow"><i class="ni ni-money-coins"></i></div></div>
        </div></div></div>
      </div>
      <div class="col-xl-4 col-md-6">
        <div class="card card-stats"><div class="card-body"><div class="row">
          <div class="col"><h5 class="card-title text-uppercase text-muted mb-0">En attente</h5>
            <span class="h2 font-weight-bold mb-0 text-warning">${nbEnAttente}</span></div>
          <div class="col-auto"><div class="icon icon-shape bg-gradient-orange text-white rounded-circle shadow"><i class="ni ni-time-alarm"></i></div></div>
        </div></div></div>
      </div>
      <div class="col-xl-4 col-md-6">
        <div class="card card-stats"><div class="card-body"><div class="row">
          <div class="col"><h5 class="card-title text-uppercase text-muted mb-0">En retard</h5>
            <span class="h2 font-weight-bold mb-0 text-danger">${nbEnRetard}</span></div>
          <div class="col-auto"><div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow"><i class="ni ni-fat-remove"></i></div></div>
        </div></div></div>
      </div>
    </div>
    <!-- Filtres onglets -->
    <div class="row mt-2"><div class="col">
      <ul class="nav nav-pills nav-fill flex-column flex-md-row" id="tabs-p">
        <li class="nav-item"><a class="nav-link active" href="#" onclick="fp('',this)">Tous</a></li>
        <li class="nav-item"><a class="nav-link" href="#" onclick="fp('PAYE',this)">Encaissés</a></li>
        <li class="nav-item"><a class="nav-link" href="#" onclick="fp('EN_ATTENTE',this)">En attente</a></li>
        <li class="nav-item"><a class="nav-link" href="#" onclick="fp('EN_RETARD',this)">En retard</a></li>
      </ul>
    </div></div>
  </div></div></div>
  <div class="container-fluid mt--6">
    <div class="card shadow">
      <div class="table-responsive">
        <table class="table align-items-center table-flush" id="pTable">
          <thead class="thead-light">
            <tr><th>Référence</th><th>Locataire</th><th>Unité</th><th>Montant</th><th>Échéance</th><th>Date paiement</th><th>Mode</th><th>Statut</th><th>Actions</th></tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${empty paiements}">
                <tr><td colspan="9" class="text-center py-5 text-muted">Aucun paiement</td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="p" items="${paiements}">
                  <tr data-statut="${p.statut}">
                    <td style="font-family:monospace;font-size:11px;font-weight:600">${p.reference}</td>
                    <td class="text-sm">
                      <div class="font-weight-bold">${p.contrat.locataire.prenom} ${p.contrat.locataire.nom}</div>
                    </td>
                    <td class="text-sm">N° ${p.contrat.unite.numero}<br><span class="text-xs text-muted">${p.contrat.unite.immeuble.nom}</span></td>
                    <td class="font-weight-bold"><fmt:formatNumber value="${p.montant}" maxFractionDigits="0"/>€</td>
                    <td class="text-sm text-muted">${p.dateEcheance}</td>
                    <td class="text-sm">${not empty p.datePaiement ? p.datePaiement : '—'}</td>
                    <td class="text-sm">${not empty p.modePaiement ? p.modePaiement : '—'}</td>
                    <td>
                      <c:choose>
                        <c:when test="${p.statut=='PAYE'}"><span class="badge badge-success badge-pill">Payé</span></c:when>
                        <c:when test="${p.statut=='EN_ATTENTE'}"><span class="badge badge-warning badge-pill">En attente</span></c:when>
                        <c:when test="${p.statut=='EN_RETARD'}"><span class="badge badge-danger badge-pill">En retard</span></c:when>
                        <c:otherwise><span class="badge badge-default badge-pill">${p.statut}</span></c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <a href="${pageContext.request.contextPath}/admin/paiements?action=modifier&id=${p.id}"
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
</div><!-- /.main-content -->
<jsp:include page="../shared/scripts.jsp"/>
<script>function fp(s,l){document.querySelectorAll('#pTable tbody tr').forEach(tr=>{tr.style.display=(!s||tr.dataset.statut===s)?'':'none';});document.querySelectorAll('#tabs-p .nav-link').forEach(x=>x.classList.remove('active'));l.classList.add('active');return false;}</script>
</body></html>
