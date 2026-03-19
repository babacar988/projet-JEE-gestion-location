<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="64kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html>
<head><title>Paiement — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
<jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="paiements"/></jsp:include>
  <div class="header bg-primary pb-6"><div class="container-fluid"><div class="header-body">
    <div class="row align-items-center py-4">
      <div class="col"><h6 class="h2 text-white mb-0">Enregistrer un paiement</h6></div>
      <div class="col text-right"><a href="${pageContext.request.contextPath}/admin/paiements" class="btn btn-sm btn-neutral">Retour</a></div>
    </div>
  </div></div></div>
  <div class="container-fluid mt--6"><div class="row justify-content-center"><div class="col-lg-6">
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
    <div class="card shadow"><div class="card-header bg-white border-0"><h3 class="mb-0">Nouveau paiement</h3></div>
    <div class="card-body">
      <form method="post" action="${pageContext.request.contextPath}/admin/paiements">
        <div class="form-group"><label class="form-control-label">Contrat *</label>
          <select name="contratId" class="form-control" required>
            <option value="">— Choisir —</option>
            <c:forEach var="c" items="${contrats}">
              <option value="${c.id}" <c:if test="${param.contratId==c.id||paiement.contrat.id==c.id}">selected</c:if>>${c.reference} — ${c.locataire.prenom} ${c.locataire.nom}</option>
            </c:forEach>
          </select>
        </div>
        <div class="row">
          <div class="col-md-6"><div class="form-group"><label class="form-control-label">Montant (€) *</label>
            <input type="number" name="montant" class="form-control" step="0.01" required value="<c:out value='${paiement.montant}'/>">
          </div></div>
          <div class="col-md-6"><div class="form-group"><label class="form-control-label">Date d'échéance *</label>
            <input type="date" name="dateEcheance" class="form-control" required value="${paiement.dateEcheance}">
          </div></div>
        </div>
        <div class="row">
          <div class="col-md-6"><div class="form-group"><label class="form-control-label">Date de paiement</label>
            <input type="date" name="datePaiement" class="form-control" value="${paiement.datePaiement}">
          </div></div>
          <div class="col-md-6"><div class="form-group"><label class="form-control-label">Mode de paiement</label>
            <select name="modePaiement" class="form-control">
              <option value="">—</option>
              <option value="VIREMENT"    <c:if test="${paiement.modePaiement=='VIREMENT'   }">selected</c:if>>Virement</option>
              <option value="CHEQUE"      <c:if test="${paiement.modePaiement=='CHEQUE'     }">selected</c:if>>Chèque</option>
              <option value="ESPECES"     <c:if test="${paiement.modePaiement=='ESPECES'    }">selected</c:if>>Espèces</option>
              <option value="PRELEVEMENT" <c:if test="${paiement.modePaiement=='PRELEVEMENT'}">selected</c:if>>Prélèvement</option>
            </select>
          </div></div>
        </div>
        <div class="form-group"><label class="form-control-label">Statut</label>
          <select name="statut" class="form-control">
            <option value="EN_ATTENTE" <c:if test="${paiement.statut=='EN_ATTENTE'||empty paiement}">selected</c:if>>En attente</option>
            <option value="PAYE"       <c:if test="${paiement.statut=='PAYE'      }">selected</c:if>>Payé</option>
            <option value="EN_RETARD"  <c:if test="${paiement.statut=='EN_RETARD' }">selected</c:if>>En retard</option>
          </select>
        </div>
        <hr>
        <div class="d-flex justify-content-end" style="gap:10px">
          <a href="${pageContext.request.contextPath}/admin/paiements" class="btn btn-outline-secondary">Annuler</a>
          <button type="submit" class="btn btn-primary">Enregistrer</button>
        </div>
      </form>
    </div></div>
  </div></div>
  <footer class="footer pt-0"><div class="row"><div class="col"><p class="text-muted text-sm">ImmoGest &copy; 2025</p></div></div></footer>
  </div>
</div>
<jsp:include page="../shared/scripts.jsp"/>
</body></html>
