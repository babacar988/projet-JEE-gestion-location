<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>Demande de location — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="offres"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Faire une demande</h1>
      <a href="${pageContext.request.contextPath}/logout" class="topbar-logout" onclick="return confirm('Déconnecter ?')">⏻ Déconnexion</a>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/locataire/offres">Offres</a>
        <span class="breadcrumb-sep">›</span><span>Demande de location</span>
      </div>
      <c:if test="${not empty error}"><div class="alert alert-danger">⚠️ ${error}</div></c:if>

      <div style="display:grid;grid-template-columns:1fr 1fr;gap:24px;max-width:900px">
        <!-- Résumé unité -->
        <div class="card">
          <div class="card-header"><h2 class="card-title">🏠 Logement sélectionné</h2></div>
          <div class="card-body">
            <div style="background:linear-gradient(135deg,var(--navy),var(--navy-mid));border-radius:var(--radius-sm);padding:20px;text-align:center;margin-bottom:20px">
              <div style="font-size:48px;margin-bottom:8px">🏠</div>
              <div style="color:white;font-family:'Playfair Display',serif;font-size:18px;font-weight:600">Unité N° ${unite.numero}</div>
              <div style="color:var(--gold-light);font-size:13px">${unite.type}</div>
            </div>
            <div style="display:flex;flex-direction:column;gap:10px">
              <div class="detail-item"><div class="detail-label">Immeuble</div><div class="detail-value">${unite.immeuble.nom}</div></div>
              <div class="detail-item"><div class="detail-label">Adresse</div><div class="detail-value">${unite.immeuble.adresse}, ${unite.immeuble.ville}</div></div>
              <c:if test="${unite.nombrePieces!=null}">
                <div class="detail-item"><div class="detail-label">Pièces</div><div class="detail-value">${unite.nombrePieces} pièces</div></div>
              </c:if>
              <c:if test="${unite.superficie!=null}">
                <div class="detail-item"><div class="detail-label">Superficie</div><div class="detail-value">${unite.superficie} m²</div></div>
              </c:if>
              <div class="detail-item"><div class="detail-label">Loyer mensuel</div>
                <div class="detail-value" style="font-family:'Playfair Display',serif;font-size:22px;color:var(--gold)">
                  <fmt:formatNumber value="${unite.loyerMensuel}" maxFractionDigits="0"/>€</div></div>
            </div>
          </div>
        </div>

        <!-- Formulaire -->
        <div class="card">
          <div class="card-header"><h2 class="card-title">📬 Votre demande</h2></div>
          <div class="card-body">
            <form action="${pageContext.request.contextPath}/locataire/demande" method="post">
              <input type="hidden" name="uniteId" value="${unite.id}">
              <div class="form-group" style="margin-bottom:20px">
                <label>Message au gestionnaire</label>
                <textarea name="message" class="form-control" rows="6"
                  placeholder="Présentez-vous brièvement, indiquez vos revenus, votre situation professionnelle, votre date d'entrée souhaitée..."></textarea>
              </div>
              <div style="padding:14px;background:var(--warning-bg);border-radius:var(--radius-sm);margin-bottom:20px;font-size:13px;color:var(--warning)">
                ⚠️ Votre demande sera examinée par le gestionnaire. Vous serez notifié de la décision.
              </div>
              <div style="display:flex;gap:12px">
                <button type="submit" class="btn btn-gold" style="flex:1;justify-content:center">📬 Envoyer la demande</button>
                <a href="${pageContext.request.contextPath}/locataire/offres" class="btn btn-outline">Annuler</a>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- MODALE DÉCO (incluse via navbar.jsp) -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body></html>
