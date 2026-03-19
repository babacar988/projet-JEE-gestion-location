<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="64kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Contrat ${contrat.reference} — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
<jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="contrats"/></jsp:include>
  <!-- Header -->
  <div class="header bg-primary pb-6"><div class="container-fluid"><div class="header-body">
    <div class="row align-items-center py-4">
      <div class="col-lg-6 col-7">
        <h6 class="h2 text-white d-inline-block mb-0">Contrat ${contrat.reference}</h6>
      </div>
      <div class="col-lg-6 col-5 text-right">
        <a href="${pageContext.request.contextPath}/admin/contrats?action=modifier&id=${contrat.id}"
           class="btn btn-sm btn-neutral">
          <i class="ni ni-settings mr-1"></i>Modifier
        </a>
        <a href="${pageContext.request.contextPath}/admin/contrats" class="btn btn-sm btn-neutral">
          Retour
        </a>
      </div>
    </div>
    <!-- Statut badge -->
    <div class="row"><div class="col">
      <c:choose>
        <c:when test="${contrat.statut=='ACTIF'}">
          <span class="badge badge-success badge-pill px-3 py-2">
            <i class="ni ni-check-bold mr-1"></i>Actif
          </span>
        </c:when>
        <c:when test="${contrat.statut=='EN_ATTENTE'}">
          <span class="badge badge-warning badge-pill px-3 py-2">En attente</span>
        </c:when>
        <c:when test="${contrat.statut=='RESILIE'}">
          <span class="badge badge-danger badge-pill px-3 py-2">Résilié</span>
        </c:when>
        <c:otherwise>
          <span class="badge badge-default badge-pill px-3 py-2">${contrat.statut}</span>
        </c:otherwise>
      </c:choose>
    </div></div>
  </div></div></div>

  <!-- Content -->
  <div class="container-fluid mt--6">
    <div class="row">
      <!-- Infos contrat -->
      <div class="col-xl-4">
        <div class="card shadow">
          <div class="card-header bg-white border-0"><h3 class="mb-0">Détails du contrat</h3></div>
          <div class="card-body">
            <dl class="row mb-0 text-sm">
              <dt class="col-6 text-muted">Référence</dt>
              <dd class="col-6 font-weight-bold" style="font-family:monospace">${contrat.reference}</dd>
              <dt class="col-6 text-muted">Loyer mensuel</dt>
              <dd class="col-6 font-weight-bold h5 mb-0">
                <fmt:formatNumber value="${contrat.loyerMensuel}" maxFractionDigits="0"/>€
              </dd>
              <dt class="col-6 text-muted">Dépôt de garantie</dt>
              <dd class="col-6">
                <c:choose>
                  <c:when test="${contrat.depotGarantie != null}">
                    <fmt:formatNumber value="${contrat.depotGarantie}" maxFractionDigits="0"/>€
                  </c:when>
                  <c:otherwise>—</c:otherwise>
                </c:choose>
              </dd>
              <dt class="col-6 text-muted">Date de début</dt>
              <dd class="col-6">${contrat.dateDebut}</dd>
              <dt class="col-6 text-muted">Date de fin</dt>
              <dd class="col-6">${not empty contrat.dateFin ? contrat.dateFin : '—'}</dd>
            </dl>
          </div>
        </div>
      </div>
      <!-- Locataire + Unité -->
      <div class="col-xl-4">
        <div class="card shadow mb-4">
          <div class="card-header bg-white border-0"><h3 class="mb-0">Locataire</h3></div>
          <div class="card-body d-flex align-items-center">
            <span class="avatar avatar-sm rounded-circle bg-gradient-info text-white mr-3"
                  style="font-size:11px;font-weight:700">
              ${contrat.locataire.prenom.charAt(0)}${contrat.locataire.nom.charAt(0)}
            </span>
            <div>
              <div class="font-weight-bold">${contrat.locataire.prenom} ${contrat.locataire.nom}</div>
              <div class="text-sm text-muted">${contrat.locataire.email}</div>
              <c:if test="${not empty contrat.locataire.telephone}">
                <div class="text-sm text-muted">${contrat.locataire.telephone}</div>
              </c:if>
            </div>
          </div>
        </div>
        <div class="card shadow">
          <div class="card-header bg-white border-0"><h3 class="mb-0">Unité</h3></div>
          <div class="card-body text-sm">
            <div class="font-weight-bold">N° ${contrat.unite.numero} — ${contrat.unite.immeuble.nom}</div>
            <div class="text-muted">${contrat.unite.immeuble.ville}
              <c:if test="${contrat.unite.etage != null}"> · Étage ${contrat.unite.etage}</c:if>
              <c:if test="${contrat.unite.superficie != null}"> · ${contrat.unite.superficie} m²</c:if>
            </div>
          </div>
        </div>
      </div>
      <!-- Paiements -->
      <div class="col-xl-4">
        <div class="card shadow">
          <div class="card-header bg-white border-0 d-flex justify-content-between align-items-center">
            <h3 class="mb-0">Paiements</h3>
            <a href="${pageContext.request.contextPath}/admin/paiements?action=nouveau&contratId=${contrat.id}"
               class="btn btn-sm btn-primary">
              <i class="ni ni-fat-add mr-1"></i>Enregistrer
            </a>
          </div>
          <div class="table-responsive">
            <table class="table align-items-center table-flush table-sm">
              <thead class="thead-light">
                <tr><th>Montant</th><th>Échéance</th><th>Statut</th></tr>
              </thead>
              <tbody>
                <c:choose>
                  <c:when test="${empty contrat.paiements}">
                    <tr><td colspan="3" class="text-center py-3 text-muted text-sm">Aucun paiement</td></tr>
                  </c:when>
                  <c:otherwise>
                    <c:forEach var="p" items="${contrat.paiements}">
                      <tr>
                        <td class="font-weight-bold text-sm">
                          <fmt:formatNumber value="${p.montant}" maxFractionDigits="0"/>€
                        </td>
                        <td class="text-xs text-muted">${p.dateEcheance}</td>
                        <td>
                          <c:choose>
                            <c:when test="${p.statut=='PAYE'}">
                              <span class="badge badge-success badge-pill">Payé</span>
                            </c:when>
                            <c:when test="${p.statut=='EN_ATTENTE'}">
                              <span class="badge badge-warning badge-pill">Attente</span>
                            </c:when>
                            <c:when test="${p.statut=='EN_RETARD'}">
                              <span class="badge badge-danger badge-pill">Retard</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badge badge-default badge-pill">${p.statut}</span>
                            </c:otherwise>
                          </c:choose>
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
      <div class="row"><div class="col">
        <p class="text-muted text-sm">ImmoGest &copy; 2025</p>
      </div></div>
    </footer>
  </div>
</div><!-- /.main-content -->
<jsp:include page="../shared/scripts.jsp"/>
</body></html>
