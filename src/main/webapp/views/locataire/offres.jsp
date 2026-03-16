<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>Offres disponibles — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="offres"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Offres disponibles</h1>
      <a href="${pageContext.request.contextPath}/logout" class="topbar-logout"
         onclick="return confirm('Voulez-vous vous déconnecter ?')">⏻ Déconnexion</a>
    </div>
    <div class="page-content">
      <div class="card" style="margin-bottom:24px">
        <div class="card-body">
          <form method="get" style="display:flex;gap:16px;flex-wrap:wrap;align-items:flex-end">
            <div class="form-group" style="flex:1;min-width:140px">
              <label>Ville</label>
              <input type="text" name="ville" class="form-control" value="${param.ville}" placeholder="Paris">
            </div>
            <div class="form-group" style="flex:1;min-width:140px">
              <label>Loyer max (€)</label>
              <input type="number" name="maxLoyer" class="form-control" value="${param.maxLoyer}" placeholder="1500">
            </div>
            <div class="form-group" style="flex:1;min-width:120px">
              <label>Pièces min</label>
              <select name="minPieces" class="form-control">
                <option value="">Tous</option>
                <option value="1" ${param.minPieces=='1'?'selected':''}>1+</option>
                <option value="2" ${param.minPieces=='2'?'selected':''}>2+</option>
                <option value="3" ${param.minPieces=='3'?'selected':''}>3+</option>
                <option value="4" ${param.minPieces=='4'?'selected':''}>4+</option>
              </select>
            </div>
            <button type="submit" class="btn btn-primary">🔍 Rechercher</button>
            <a href="${pageContext.request.contextPath}/locataire/offres" class="btn btn-outline">Réinitialiser</a>
          </form>
        </div>
      </div>
      <p style="color:var(--text-muted);font-size:14px;margin-bottom:20px">
        <strong style="color:var(--navy)">${unites.size()}</strong> offre(s) trouvée(s)
      </p>
      <c:choose>
        <c:when test="${not empty unites}">
          <div class="property-grid">
            <c:forEach var="u" items="${unites}">
              <div class="property-card">
                <div class="property-img">
                  <c:choose>
                    <c:when test="${u.type=='STUDIO'}">🛏️</c:when>
                    <c:when test="${u.type=='BUREAU'}">💼</c:when>
                    <c:when test="${u.type=='COMMERCE'}">🏪</c:when>
                    <c:otherwise>🏠</c:otherwise>
                  </c:choose>
                  <div class="property-badge"><span class="badge badge-success">Disponible</span></div>
                </div>
                <div class="property-body">
                  <div class="property-title">N° ${u.numero} — ${u.type}</div>
                  <div class="property-address">🏢 ${u.immeuble.nom} · ${u.immeuble.ville}</div>
                  <div class="property-stats">
                    <c:if test="${u.nombrePieces!=null}"><span class="property-stat">🛏 ${u.nombrePieces} pièces</span></c:if>
                    <c:if test="${u.superficie!=null}"><span class="property-stat">📐 ${u.superficie}m²</span></c:if>
                  </div>
                  <div class="property-price">
                    <fmt:formatNumber value="${u.loyerMensuel}" maxFractionDigits="0"/>€<span>/mois</span>
                  </div>
                </div>
                <div class="property-footer">
                  <span style="font-size:11px;color:var(--text-muted)">${u.equipements}</span>
                  <a href="${pageContext.request.contextPath}/locataire/demande?uniteId=${u.id}" class="btn btn-gold btn-sm">Demander →</a>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:when>
        <c:otherwise>
          <div class="card">
            <div class="empty-state">
              <div class="empty-icon">🏘️</div>
              <div class="empty-title">Aucune offre disponible</div>
              <div class="empty-text">Modifiez vos critères ou revenez plus tard</div>
              <a href="${pageContext.request.contextPath}/locataire/offres" class="btn btn-gold">Voir toutes les offres</a>
            </div>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>
<!-- MODALE DÉCO (incluse via navbar.jsp) -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body></html>
