<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html>
<head><title>Demande de location — ImmoGest</title>
    <jsp:include page="../shared/head.jsp"/>
</head>
<body>
<jsp:include page="../shared/navbar1.jsp">
    <jsp:param name="page" value="offres"/>
</jsp:include>
<div class="header bg-primary pb-6">
    <div class="container-fluid">
        <div class="header-body">
            <div class="row align-items-center py-4">
                <div class="col"><h6 class="h2 text-white d-inline-block mb-0">Demande de location</h6></div>
                <div class="col text-right">
                    <a href="${pageContext.request.contextPath}/locataire/offres" class="btn btn-sm btn-neutral">Retour
                        aux offres</a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid mt--6">
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">${error}
            <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
        </div>
    </c:if>
    <div class="row">
        <!-- Récap logement -->
        <div class="col-xl-4">
            <div class="card shadow">
                <div class="card-header bg-gradient-info text-white border-0">
                    <h4 class="text-white mb-0">Logement sélectionné</h4>
                </div>
                <div class="card-body">
                    <div class="text-center py-3 border-bottom mb-3">
                        <div class="icon icon-shape bg-gradient-info text-white rounded-circle shadow mx-auto mb-3"
                             style="width:64px;height:64px;font-size:1.8rem">
                            <i class="ni ni-building"></i>
                        </div>
                        <div class="h2 font-weight-bold">
                            <fmt:formatNumber value="${unite.loyerMensuel}" maxFractionDigits="0"/>€
                            <small class="text-muted" style="font-size:14px">/mois</small>
                        </div>
                    </div>
                    <dl class="row mb-0">
                        <dt class="col-6 text-muted text-sm">Unité</dt>
                        <dd class="col-6 text-sm font-weight-bold">N° ${unite.numero}</dd>
                        <dt class="col-6 text-muted text-sm">Type</dt>
                        <dd class="col-6"><span class="badge badge-primary badge-pill">${unite.type}</span></dd>
                        <dt class="col-6 text-muted text-sm">Immeuble</dt>
                        <dd class="col-6 text-sm font-weight-bold">${unite.immeuble.nom}</dd>
                        <dt class="col-6 text-muted text-sm">Ville</dt>
                        <dd class="col-6 text-sm">${unite.immeuble.ville}</dd>
                        <c:if test="${unite.superficie!=null}">
                            <dt class="col-6 text-muted text-sm">Surface</dt>
                            <dd class="col-6 text-sm">${unite.superficie} m²</dd>
                        </c:if>
                        <c:if test="${unite.nombrePieces!=null}">
                            <dt class="col-6 text-muted text-sm">Pièces</dt>
                            <dd class="col-6 text-sm">${unite.nombrePieces}</dd>
                        </c:if>
                        <c:if test="${unite.charges!=null}">
                            <dt class="col-6 text-muted text-sm">Charges</dt>
                            <dd class="col-6 text-sm"><fmt:formatNumber value="${unite.charges}" maxFractionDigits="0"/>€/mois</dd>
                        </c:if>
                    </dl>
                </div>
            </div>
        </div>
        <!-- Formulaire -->
        <div class="col-xl-8">
            <div class="card shadow">
                <div class="card-header bg-white border-0"><h3 class="mb-0">Votre demande</h3></div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/locataire/demande">
                        <input type="hidden" name="uniteId" value="${unite.id}">
                        <div class="form-group">
                            <label class="form-control-label">Date d'entrée souhaitée *</label>
                            <input type="date" name="dateSouhaitee" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-control-label">Message <small
                                    class="text-muted">(optionnel)</small></label>
                            <textarea name="message" class="form-control" rows="5"
                                      placeholder="Présentez-vous, expliquez votre situation professionnelle..."></textarea>
                        </div>
                        <div class="alert alert-info">
                            <i class="ni ni-bell-55 mr-2"></i>
                            Votre demande sera examinée par le gestionnaire. Vous serez notifié de la décision.
                        </div>
                        <hr>
                        <div class="d-flex justify-content-end" style="gap:10px">
                            <a href="${pageContext.request.contextPath}/locataire/offres"
                               class="btn btn-outline-secondary">Annuler</a>
                            <button type="submit" class="btn btn-primary">
                                <i class="ni ni-send mr-1"></i>Envoyer la demande
                            </button>
                        </div>
                    </form>
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
