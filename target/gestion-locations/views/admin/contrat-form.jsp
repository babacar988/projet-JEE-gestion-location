<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="64kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html>
<head><title>Contrat — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
<jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="contrats"/></jsp:include>
  <div class="header bg-primary pb-6"><div class="container-fluid"><div class="header-body">
    <div class="row align-items-center py-4">
      <div class="col"><h6 class="h2 text-white mb-0"><c:choose><c:when test="${not empty contrat}">Modifier le contrat</c:when><c:otherwise>Nouveau contrat</c:otherwise></c:choose></h6></div>
      <div class="col text-right"><a href="${pageContext.request.contextPath}/admin/contrats" class="btn btn-sm btn-neutral">Retour</a></div>
    </div>
  </div></div></div>
  <div class="container-fluid mt--6"><div class="row justify-content-center"><div class="col-lg-8">
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
    <div class="card shadow"><div class="card-header bg-white border-0"><h3 class="mb-0">Informations du contrat</h3></div>
    <div class="card-body">
      <form method="post" action="${pageContext.request.contextPath}/admin/contrats">
        <c:if test="${not empty contrat}"><input type="hidden" name="id" value="${contrat.id}"><input type="hidden" name="action" value="modifier"></c:if>
        <div class="row">
          <div class="col-md-6"><div class="form-group"><label class="form-control-label">Unité *</label>
            <select name="uniteId" class="form-control" required>
              <option value="">— Choisir —</option>
              <c:forEach var="u" items="${unites}"><option value="${u.id}" <c:if test="${contrat.unite.id==u.id}">selected</c:if>>${u.immeuble.nom} · N° ${u.numero}</option></c:forEach>
            </select>
          </div></div>
          <div class="col-md-6"><div class="form-group"><label class="form-control-label">Locataire *</label>
            <select name="locataireId" class="form-control" required>
              <option value="">— Choisir —</option>
              <c:forEach var="l" items="${locataires}"><option value="${l.id}" <c:if test="${contrat.locataire.id==l.id}">selected</c:if>>${l.prenom} ${l.nom}</option></c:forEach>
            </select>
          </div></div>
        </div>
        <div class="row">
          <div class="col-md-4"><div class="form-group"><label class="form-control-label">Loyer (€) *</label>
            <input type="number" name="loyerMensuel" class="form-control" step="0.01" required value="<c:out value='${contrat.loyerMensuel}'/>">
          </div></div>
          <div class="col-md-4"><div class="form-group"><label class="form-control-label">Dépôt de garantie (€)</label>
            <input type="number" name="depotGarantie" class="form-control" step="0.01" value="<c:out value='${contrat.depotGarantie}'/>">
          </div></div>
          <div class="col-md-4"><div class="form-group"><label class="form-control-label">Statut</label>
            <select name="statut" class="form-control">
              <option value="EN_ATTENTE" <c:if test="${contrat.statut=='EN_ATTENTE'||empty contrat}">selected</c:if>>En attente</option>
              <option value="ACTIF"      <c:if test="${contrat.statut=='ACTIF'     }">selected</c:if>>Actif</option>
              <option value="TERMINE"    <c:if test="${contrat.statut=='TERMINE'   }">selected</c:if>>Terminé</option>
              <option value="RESILIE"    <c:if test="${contrat.statut=='RESILIE'   }">selected</c:if>>Résilié</option>
            </select>
          </div></div>
        </div>
        <div class="row">
          <div class="col-md-6"><div class="form-group"><label class="form-control-label">Date de début *</label>
            <input type="date" name="dateDebut" class="form-control" required value="${contrat.dateDebut}">
          </div></div>
          <div class="col-md-6"><div class="form-group"><label class="form-control-label">Date de fin</label>
            <input type="date" name="dateFin" class="form-control" value="${contrat.dateFin}">
          </div></div>
        </div>
        <hr>
        <div class="d-flex justify-content-end" style="gap:10px">
          <a href="${pageContext.request.contextPath}/admin/contrats" class="btn btn-outline-secondary">Annuler</a>
          <button type="submit" class="btn btn-primary"><c:choose><c:when test="${not empty contrat}">Enregistrer</c:when><c:otherwise>Créer le contrat</c:otherwise></c:choose></button>
        </div>
      </form>
    </div></div>
  </div></div>
  <footer class="footer pt-0"><div class="row"><div class="col"><p class="text-muted text-sm">ImmoGest &copy; 2025</p></div></div></footer>
  </div>
</div>
<jsp:include page="../shared/scripts.jsp"/>
</body></html>
