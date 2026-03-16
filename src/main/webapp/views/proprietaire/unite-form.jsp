<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title><c:choose><c:when test="${not empty unite}">Modifier l'unité</c:when><c:otherwise>Nouvelle unité</c:otherwise></c:choose> — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">&#9776;</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="unites"/></jsp:include>

  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">
        <c:choose>
          <c:when test="${not empty unite}">Modifier — N° ${unite.numero}</c:when>
          <c:otherwise>Nouvelle unité</c:otherwise>
        </c:choose>
      </h1>
      <div class="topbar-actions">
        <a href="${pageContext.request.contextPath}/proprietaire/unites" class="btn btn-outline">Annuler</a>
        <button class="btn-logout-topbar" onclick="openLogoutModal()">Déconnexion</button>
      </div>
    </div>

    <div class="page-content">
      <c:if test="${not empty error}">
        <div class="alert alert-danger" data-dismiss>${error}</div>
      </c:if>

      <div class="card" style="max-width:780px">
        <div class="card-header">
          <span class="card-title">
            <c:choose>
              <c:when test="${not empty unite}">Informations de l'unité</c:when>
              <c:otherwise>Ajouter une unité</c:otherwise>
            </c:choose>
          </span>
        </div>
        <div class="card-body">
          <form method="post" action="${pageContext.request.contextPath}/proprietaire/unite-form">

            <c:if test="${not empty unite}">
              <input type="hidden" name="id" value="${unite.id}">
            </c:if>

            <%-- ── Immeuble + Numéro ── --%>
            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Immeuble *</label>
                <select name="immeubleId" class="form-control" required>
                  <option value="">— Choisir un immeuble —</option>
                  <c:forEach var="imm" items="${immeubles}">
                    <option value="${imm.id}"
                      <c:choose>
                        <c:when test="${not empty unite && unite.immeuble.id == imm.id}">selected</c:when>
                        <c:when test="${empty unite && preselImmeuble == imm.id}">selected</c:when>
                      </c:choose>
                    >${imm.nom} — ${imm.ville}</option>
                  </c:forEach>
                </select>
              </div>
              <div class="form-group">
                <label class="form-label">Numéro / Référence *</label>
                <input type="text" name="numero" class="form-control" required
                       placeholder="A101"
                       value="<c:out value='${unite.numero}'/>">
              </div>
            </div>

            <%-- ── Type + Statut ── --%>
            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Type</label>
                <select name="type" class="form-control">
                  <c:forEach var="t" items="${['STUDIO','APPARTEMENT','MAISON','BUREAU','COMMERCE','ENTREPOT']}">
                    <option value="${t}" <c:if test="${unite.type == t}">selected</c:if>>${t}</option>
                  </c:forEach>
                </select>
              </div>
              <div class="form-group">
                <label class="form-label">Statut</label>
                <select name="statut" class="form-control">
                  <option value="DISPONIBLE"  <c:if test="${unite.statut == 'DISPONIBLE'  || empty unite}">selected</c:if>>Disponible</option>
                  <option value="OCCUPEE"     <c:if test="${unite.statut == 'OCCUPEE'    }">selected</c:if>>Occupée</option>
                  <option value="EN_TRAVAUX"  <c:if test="${unite.statut == 'EN_TRAVAUX' }">selected</c:if>>En travaux</option>
                  <option value="RESERVEE"    <c:if test="${unite.statut == 'RESERVEE'   }">selected</c:if>>Réservée</option>
                </select>
              </div>
            </div>

            <%-- ── Étage + Pièces ── --%>
            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Étage</label>
                <input type="number" name="etage" class="form-control" min="0" max="99"
                       placeholder="0 = RDC"
                       value="<c:out value='${unite.etage}'/>">
              </div>
              <div class="form-group">
                <label class="form-label">Nombre de pièces</label>
                <input type="number" name="nombrePieces" class="form-control" min="1" max="20"
                       placeholder="3"
                       value="<c:out value='${unite.nombrePieces}'/>">
              </div>
            </div>

            <%-- ── Surface + Loyer ── --%>
            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Superficie (m²)</label>
                <input type="number" name="superficie" class="form-control" step="0.1" min="1"
                       placeholder="65.5"
                       value="<c:out value='${unite.superficie}'/>">
              </div>
              <div class="form-group">
                <label class="form-label">Loyer mensuel (€) *</label>
                <input type="number" name="loyerMensuel" class="form-control" step="0.01" required min="1"
                       placeholder="900.00"
                       value="<c:out value='${unite.loyerMensuel}'/>">
              </div>
            </div>

            <%-- ── Charges + Dépôt ── --%>
            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Charges mensuelles (€)</label>
                <input type="number" name="charges" class="form-control" step="0.01" min="0"
                       placeholder="80.00"
                       value="<c:out value='${unite.charges}'/>">
              </div>
              <div class="form-group">
                <label class="form-label">Dépôt de garantie (€)</label>
                <input type="number" name="depot" class="form-control" step="0.01" min="0"
                       placeholder="1800.00"
                       value="<c:out value='${unite.depot}'/>">
              </div>
            </div>

            <%-- ── Description ── --%>
            <div class="form-group">
              <label class="form-label">Description</label>
              <textarea name="description" class="form-control" rows="3"
                        placeholder="Appartement lumineux, cuisine équipée, double vitrage..."><c:out value='${unite.description}'/></textarea>
            </div>

            <%-- ── Équipements ── --%>
            <div class="form-group">
              <label class="form-label">Équipements</label>
              <textarea name="equipements" class="form-control" rows="2"
                        placeholder="Parking, cave, balcon, gardien..."><c:out value='${unite.equipements}'/></textarea>
              <div class="form-hint">Séparés par des virgules</div>
            </div>

            <hr class="divider">
            <div style="display:flex;gap:10px;justify-content:flex-end">
              <a href="${pageContext.request.contextPath}/proprietaire/unites" class="btn btn-outline">Annuler</a>
              <button type="submit" class="btn btn-primary">
                <c:choose>
                  <c:when test="${not empty unite}">Enregistrer les modifications</c:when>
                  <c:otherwise>Ajouter l'unité</c:otherwise>
                </c:choose>
              </button>
            </div>

          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
