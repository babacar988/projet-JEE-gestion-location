<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><title>Mes immeubles — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">&#9776;</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="immeubles"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Mes immeubles</h1>
      <div class="topbar-actions">
        <a href="${pageContext.request.contextPath}/proprietaire/immeuble-form?action=nouveau" class="btn btn-primary">+ Ajouter</a>
        <button class="btn-logout-topbar" onclick="openLogoutModal()">Déconnexion</button>
      </div>
    </div>
    <div class="page-content">
      <c:choose>
        <c:when test="${empty immeubles}">
          <div class="card">
            <div class="empty-state">
              <div class="empty-icon">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                  <rect x="4" y="2" width="16" height="20" rx="2"/>
                  <path d="M9 22v-4h6v4M8 6h.01M16 6h.01M8 10h.01M16 10h.01M8 14h.01M16 14h.01"/>
                </svg>
              </div>
              <div class="empty-title">Aucun immeuble enregistré</div>
              <div class="empty-sub">Contactez un administrateur pour ajouter vos immeubles.</div>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <div class="property-grid">
            <c:forEach var="imm" items="${immeubles}">
              <div class="property-card">
                <div class="property-card-image">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                    <rect x="4" y="2" width="16" height="20" rx="2"/>
                    <path d="M9 22v-4h6v4M8 6h.01M16 6h.01M8 10h.01M16 10h.01M8 14h.01M16 14h.01"/>
                  </svg>
                  <div class="property-card-badge">
                    <span class="badge ${imm.actif ? 'badge-success' : 'badge-danger'}">
                      <span class="badge-dot"></span>${imm.actif ? 'Actif' : 'Inactif'}
                    </span>
                  </div>
                </div>
                <div class="property-card-body">
                  <div class="property-card-title">${imm.nom}</div>
                  <div class="property-card-sub">${imm.adresse}, ${imm.ville}</div>
                  <div class="property-card-meta">
                    <span>${imm.nombreUnites} unité(s)</span>
                    <c:if test="${imm.nombreEtages != null}">
                      <span>${imm.nombreEtages} étage(s)</span>
                    </c:if>
                    <span><span class="badge badge-navy" style="font-size:10.5px">${imm.type}</span></span>
                  </div>
                </div>
                <div class="property-card-footer">
                  <span style="font-size:12px;color:var(--text-muted)">${imm.ville}</span>
                  <a href="${pageContext.request.contextPath}/proprietaire/immeuble-detail?id=${imm.id}"
                     class="btn btn-outline btn-sm">Voir le détail</a>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
