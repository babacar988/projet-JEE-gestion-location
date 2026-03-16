<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
  com.gestionloc.entities.Utilisateur currentUser = 
    (com.gestionloc.entities.Utilisateur) session.getAttribute("utilisateur");
  String role = currentUser != null ? currentUser.getRole().toString() : "";
%>

<!-- Mobile Overlay -->
<div id="sidebarOverlay" style="position:fixed;inset:0;background:rgba(0,0,0,0.7);z-index:99;opacity:0;pointer-events:none;transition:opacity 0.3s;backdrop-filter:blur(4px);" 
     class="sidebar-overlay-js"></div>

<aside class="sidebar">
  <div class="sidebar-logo">
    <div class="logo-icon">🏢</div>
    <h1>ImmoGest</h1>
    <span>Gestion immobilière</span>
  </div>

  <nav class="sidebar-nav">
    <% if ("ADMIN".equals(role)) { %>
    <div class="nav-section">
      <div class="nav-section-label">Administration</div>
      <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
        <div class="nav-icon">📊</div>
        Tableau de bord
      </a>
      <a href="${pageContext.request.contextPath}/immeubles/liste" class="nav-item">
        <div class="nav-icon">🏗️</div>
        Immeubles
      </a>
      <a href="${pageContext.request.contextPath}/contrats/liste" class="nav-item">
        <div class="nav-icon">📋</div>
        Contrats
      </a>
      <a href="${pageContext.request.contextPath}/admin/paiements" class="nav-item">
        <div class="nav-icon">💰</div>
        Paiements
      </a>
    </div>
    <div class="nav-section">
      <div class="nav-section-label">Gestion</div>
      <a href="${pageContext.request.contextPath}/admin/locataires" class="nav-item">
        <div class="nav-icon">👥</div>
        Locataires
      </a>
      <a href="${pageContext.request.contextPath}/admin/utilisateurs" class="nav-item">
        <div class="nav-icon">⚙️</div>
        Utilisateurs
      </a>
    </div>
    <% } else if ("PROPRIETAIRE".equals(role)) { %>
    <div class="nav-section">
      <div class="nav-section-label">Mon espace</div>
      <a href="${pageContext.request.contextPath}/proprietaire/dashboard" class="nav-item">
        <div class="nav-icon">📊</div>
        Tableau de bord
      </a>
<%--      <a href="${pageContext.request.contextPath}/immeubles/liste" class="nav-item">--%>
<%--        <div class="nav-icon">🏗️</div>--%>
<%--        Mes immeubles--%>
<%--      </a>--%>
      <a href="${pageContext.request.contextPath}/contrats/liste" class="nav-item">
        <div class="nav-icon">📋</div>
        Contrats
      </a>
      <a href="${pageContext.request.contextPath}/admin/paiements" class="nav-item">
        <div class="nav-icon">💰</div>
        Paiements
      </a>
    </div>
    <% } else { %>
    <div class="nav-section">
      <div class="nav-section-label">Mon espace</div>
      <a href="${pageContext.request.contextPath}/locataire/dashboard" class="nav-item">
        <div class="nav-icon">🏠</div>
        Mon logement
      </a>
      <a href="${pageContext.request.contextPath}/locataire/offres" class="nav-item">
        <div class="nav-icon">🔍</div>
        Offres disponibles
      </a>
      <a href="${pageContext.request.contextPath}/locataire/mes-paiements" class="nav-item">
        <div class="nav-icon">💳</div>
        Mes paiements
      </a>
    </div>
    <% } %>
  </nav>

  <div class="sidebar-footer">
    <% if (currentUser != null) { %>
    <div class="user-info">
      <div class="user-avatar"><%= currentUser.getPrenom().charAt(0) %></div>
      <div>
        <div class="user-name"><%= currentUser.getNomComplet() %></div>
        <div class="user-role"><%= currentUser.getRole().toString().toLowerCase() %></div>
      </div>
    </div>
    <% } %>
    <a href="${pageContext.request.contextPath}/logout" class="nav-item" style="color:var(--danger);">
      <div class="nav-icon" style="background:rgba(239,68,68,0.1);">🚪</div>
      Déconnexion
    </a>
  </div>
</aside>
