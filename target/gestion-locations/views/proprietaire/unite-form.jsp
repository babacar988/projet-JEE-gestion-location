<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html>
<head><title>Unité — ImmoGest</title>
    <jsp:include page="../shared/head.jsp"/>
</head>
<body>
<jsp:include page="../shared/navbar1.jsp">
    <jsp:param name="page" value="unite-form"/>
</jsp:include>
<div class="header bg-primary pb-6">
    <div class="container-fluid">
        <div class="header-body">
            <div class="row align-items-center py-4">
                <div class="col"><h6 class="h2 text-white mb-0">
                    <c:choose><c:when
                            test="${not empty unite}">Modifier N° ${unite.numero}</c:when><c:otherwise>Nouvelle unité</c:otherwise></c:choose>
                </h6></div>
                <div class="col text-right"><a href="${pageContext.request.contextPath}/proprietaire/unites"
                                               class="btn btn-sm btn-neutral">Annuler</a></div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid mt--6">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show">${error}
                    <button type="button" class="close" data-dismiss="alert"><span>&times;</span></button>
                </div>
            </c:if>
            <div class="card shadow">
                <div class="card-header bg-white border-0"><h3 class="mb-0">Informations de l'unité</h3></div>
                <div class="card-body">
                    <form method="post" action="${pageContext.request.contextPath}/proprietaire/unite-form">
                        <c:if test="${not empty unite}"><input type="hidden" name="id" value="${unite.id}"></c:if>
                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group"><label class="form-control-label">Immeuble *</label>
                                    <select name="immeubleId" class="form-control" required>
                                        <option value="">— Choisir un immeuble —</option>
                                        <c:forEach var="imm" items="${immeubles}">
                                            <option value="${imm.id}"
                                                    <c:choose>
                                                        <c:when test="${not empty unite && unite.immeuble.id==imm.id}">selected</c:when>
                                                        <c:when test="${empty unite && preselImmeuble==imm.id}">selected</c:when>
                                                    </c:choose>
                                            >${imm.nom} — ${imm.ville}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group"><label class="form-control-label">Numéro / Réf. *</label>
                                    <input type="text" name="numero" class="form-control" required placeholder="A101"
                                           value="<c:out value='${unite.numero}'/>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group"><label class="form-control-label">Type</label>
                                    <select name="type" class="form-control">
                                        <c:forEach var="t"
                                                   items="${['STUDIO','APPARTEMENT','MAISON','BUREAU','COMMERCE','ENTREPOT']}">
                                            <option value="${t}"
                                                    <c:if test="${unite.type==t}">selected</c:if>>${t}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group"><label class="form-control-label">Statut</label>
                                    <select name="statut" class="form-control">
                                        <option value="DISPONIBLE"
                                                <c:if test="${unite.statut=='DISPONIBLE'||empty unite}">selected</c:if>>
                                            Disponible
                                        </option>
                                        <option value="OCCUPEE"
                                                <c:if test="${unite.statut=='OCCUPEE'   }">selected</c:if>>Occupée
                                        </option>
                                        <option value="EN_TRAVAUX"
                                                <c:if test="${unite.statut=='EN_TRAVAUX'}">selected</c:if>>En travaux
                                        </option>
                                        <option value="RESERVEE"
                                                <c:if test="${unite.statut=='RESERVEE'  }">selected</c:if>>Réservée
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group"><label class="form-control-label">Étage <small
                                        class="text-muted">(0=RDC)</small></label>
                                    <input type="number" name="etage" class="form-control" min="0"
                                           value="<c:out value='${unite.etage}'/>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group"><label class="form-control-label">Pièces</label>
                                    <input type="number" name="nombrePieces" class="form-control" min="1"
                                           value="<c:out value='${unite.nombrePieces}'/>">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group"><label class="form-control-label">Surface (m²)</label>
                                    <input type="number" name="superficie" class="form-control" step="0.1"
                                           value="<c:out value='${unite.superficie}'/>">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group"><label class="form-control-label">Loyer (€) *</label>
                                    <input type="number" name="loyerMensuel" class="form-control" step="0.01" required
                                           value="<c:out value='${unite.loyerMensuel}'/>">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group"><label class="form-control-label">Charges (€/mois)</label>
                                    <input type="number" name="charges" class="form-control" step="0.01"
                                           value="<c:out value='${unite.charges}'/>">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group"><label class="form-control-label">Dépôt de garantie (€)</label>
                                    <input type="number" name="depot" class="form-control" step="0.01"
                                           value="<c:out value='${unite.depot}'/>">
                                </div>
                            </div>
                        </div>
                        <div class="form-group"><label class="form-control-label">Description</label>
                            <textarea name="description" class="form-control" rows="3"
                                      placeholder="Appartement lumineux, cuisine équipée..."><c:out
                                    value='${unite.description}'/></textarea>
                        </div>
                        <div class="form-group"><label class="form-control-label">Équipements <small class="text-muted">(séparés
                            par des virgules)</small></label>
                            <textarea name="equipements" class="form-control" rows="2"
                                      placeholder="Parking, cave, balcon..."><c:out
                                    value='${unite.equipements}'/></textarea>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-end" style="gap:10px">
                            <a href="${pageContext.request.contextPath}/proprietaire/unites"
                               class="btn btn-outline-secondary">Annuler</a>
                            <button type="submit" class="btn btn-primary">
                                <c:choose><c:when
                                        test="${not empty unite}">Enregistrer les modifications</c:when><c:otherwise>Ajouter l'unité</c:otherwise></c:choose>
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
