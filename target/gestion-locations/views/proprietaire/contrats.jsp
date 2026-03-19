<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Mes contrats — ImmoGest</title>
    <jsp:include page="../shared/head.jsp"/>
</head>
<body>
<jsp:include page="../shared/navbar1.jsp">
    <jsp:param name="page" value="contrats"/>
</jsp:include>
<div class="header bg-primary pb-6">
    <div class="container-fluid">
        <div class="header-body">
            <div class="row align-items-center py-4">
                <div class="col"><h6 class="h2 text-white d-inline-block mb-0">Mes contrats</h6></div>
            </div>
            <div class="row">
                <div class="col-xl-3 col-md-6">
                    <div class="card card-stats">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <h5 class="card-title text-uppercase text-muted mb-0">Actifs</h5>
                                    <span class="h2 font-weight-bold mb-0 text-success">${contratsActifs}</span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-success text-white rounded-circle shadow"><i
                                            class="ni ni-check-bold"></i></div>
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
                                    <h5 class="card-title text-uppercase text-muted mb-0">En attente</h5>
                                    <span class="h2 font-weight-bold mb-0 text-warning">${contratsEnAttente}</span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-orange text-white rounded-circle shadow"><i
                                            class="ni ni-time-alarm"></i></div>
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
                                    <h5 class="card-title text-uppercase text-muted mb-0">Total</h5>
                                    <span class="h2 font-weight-bold mb-0">${contrats.size()}</span>
                                </div>
                                <div class="col-auto">
                                    <div class="icon icon-shape bg-gradient-info text-white rounded-circle shadow"><i
                                            class="ni ni-single-copy-04"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col">
                    <ul class="nav nav-pills nav-fill flex-column flex-md-row" id="tabs-c">
                        <li class="nav-item"><a class="nav-link active" href="#" onclick="fc('',this)">Tous</a></li>
                        <li class="nav-item"><a class="nav-link" href="#" onclick="fc('ACTIF',this)">Actifs</a></li>
                        <li class="nav-item"><a class="nav-link" href="#" onclick="fc('EN_ATTENTE',this)">En attente</a>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="#" onclick="fc('RESILIE',this)">Résiliés</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid mt--6">
    <div class="card">
        <div class="table-responsive">
            <table class="table align-items-center table-flush" id="cTable">
                <thead class="thead-light">
                <tr>
                    <th>Référence</th>
                    <th>Locataire</th>
                    <th>Unité</th>
                    <th>Loyer</th>
                    <th>Début</th>
                    <th>Statut</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty contrats}">
                        <tr>
                            <td colspan="6" class="text-center py-5 text-muted">Aucun contrat</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="c" items="${contrats}">
                            <tr data-statut="${c.statut}">
                                <td style="font-family:monospace;font-size:11px;font-weight:600">${c.reference}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                        <span class="avatar avatar-sm rounded-circle bg-gradient-info text-white mr-2"
                              style="font-size:11px;font-weight:700">
                                ${c.locataire.prenom.charAt(0)}${c.locataire.nom.charAt(0)}
                        </span>
                                        <div>
                                            <div class="font-weight-bold text-sm">${c.locataire.prenom} ${c.locataire.nom}</div>
                                            <div class="text-xs text-muted">${c.locataire.email}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-sm">N° ${c.unite.numero} — ${c.unite.immeuble.nom}</td>
                                <td class="font-weight-bold"><fmt:formatNumber value="${c.loyerMensuel}"
                                                                               maxFractionDigits="0"/>€
                                </td>
                                <td class="text-sm text-muted">${c.dateDebut}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.statut=='ACTIF'}"> <span
                                                class="badge badge-success badge-pill">Actif</span></c:when>
                                        <c:when test="${c.statut=='EN_ATTENTE'}"> <span
                                                class="badge badge-warning badge-pill">En attente</span></c:when>
                                        <c:when test="${c.statut=='RESILIE'}"> <span
                                                class="badge badge-danger  badge-pill">Résilié</span></c:when>
                                        <c:otherwise> <span
                                                class="badge badge-default badge-pill">${c.statut}</span></c:otherwise>
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
    <footer class="footer pt-0">
        <div class="row">
            <div class="col"><p class="text-muted text-sm">ImmoGest &copy; 2025</p></div>
        </div>
    </footer>
</div>
</div>
<jsp:include page="../shared/scripts.jsp"/>
<script>function fc(s, l) {
    document.querySelectorAll('#cTable tbody tr').forEach(tr => {
        tr.style.display = (!s || tr.dataset.statut === s) ? '' : 'none';
    });
    document.querySelectorAll('#tabs-c .nav-link').forEach(x => x.classList.remove('active'));
    l.classList.add('active');
    return false;
}</script>
</body>
</html>
