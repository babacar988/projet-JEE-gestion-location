<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    com.gestionlocations.entities.Utilisateur u =
            (com.gestionlocations.entities.Utilisateur) session.getAttribute("utilisateur");
    if (u == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    String role     = u.getRole().name().toLowerCase();
    String initials = String.valueOf(u.getPrenom().charAt(0)) + String.valueOf(u.getNom().charAt(0));
    pageContext.setAttribute("userRole",    role);
    pageContext.setAttribute("initials",    initials.toUpperCase());
    pageContext.setAttribute("currentUser", u);
%>

<!-- SVG sprite inline -->
<svg xmlns="http://www.w3.org/2000/svg" style="display:none">
    <symbol id="ic-home" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/>
    </symbol>
    <symbol id="ic-building" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <rect x="4" y="2" width="16" height="20" rx="2"/><path d="M9 22v-4h6v4M8 6h.01M16 6h.01M8 10h.01M16 10h.01M8 14h.01M16 14h.01"/>
    </symbol>
    <symbol id="ic-door" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><circle cx="10" cy="13" r="1"/>
    </symbol>
    <symbol id="ic-file" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/>
    </symbol>
    <symbol id="ic-payment" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/>
    </symbol>
    <symbol id="ic-users" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
    </symbol>
    <symbol id="ic-inbox" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="22 12 16 12 14 15 10 15 8 12 2 12"/><path d="M5.45 5.11L2 12v6a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2v-6l-3.45-6.89A2 2 0 0 0 16.76 4H7.24a2 2 0 0 0-1.79 1.11z"/>
    </symbol>
    <symbol id="ic-chart" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/><line x1="2" y1="20" x2="22" y2="20"/>
    </symbol>
    <symbol id="ic-search" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
    </symbol>
    <symbol id="ic-user" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/>
    </symbol>
    <symbol id="ic-logout" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/>
    </symbol>
    <symbol id="ic-grid" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/>
    </symbol>
    <symbol id="ic-building-logo" viewBox="0 0 24 24" fill="currentColor">
        <path d="M1 22V9.5l10-8 10 8V22H15v-7h-6v7H1zm2-2h4v-7h10v7h4V10.35l-8-6.4-8 6.4V20z"/>
    </symbol>
</svg>

<aside class="sidebar" id="sidebar">
    <div class="sidebar-brand">
        <a href="${pageContext.request.contextPath}/${userRole}/dashboard" class="brand-logo">
            <div class="brand-icon">
                <svg viewBox="0 0 24 24"><use href="#ic-building-logo"/></svg>
            </div>
            <div>
                <div class="brand-text">ImmoGest</div>
                <div class="brand-sub">Gestion locative</div>
            </div>
        </a>
    </div>

    <nav class="sidebar-nav">
        <div class="nav-section-title">Principal</div>

        <a href="${pageContext.request.contextPath}/${userRole}/dashboard"
           class="nav-link ${param.page=='dashboard'?'active':''}">
            <svg class="nav-icon"><use href="#ic-grid"/></svg>
            Tableau de bord
        </a>

        <c:if test="${userRole=='admin'}">
            <a href="${pageContext.request.contextPath}/admin/immeubles"
               class="nav-link ${param.page=='immeubles'?'active':''}">
                <svg class="nav-icon"><use href="#ic-building"/></svg>
                Immeubles
            </a>
            <a href="${pageContext.request.contextPath}/admin/unites"
               class="nav-link ${param.page=='unites'?'active':''}">
                <svg class="nav-icon"><use href="#ic-door"/></svg>
                Unités
            </a>
            <a href="${pageContext.request.contextPath}/admin/contrats"
               class="nav-link ${param.page=='contrats'?'active':''}">
                <svg class="nav-icon"><use href="#ic-file"/></svg>
                Contrats
            </a>
            <a href="${pageContext.request.contextPath}/admin/paiements"
               class="nav-link ${param.page=='paiements'?'active':''}">
                <svg class="nav-icon"><use href="#ic-payment"/></svg>
                Paiements
            </a>
        </c:if>



        <c:if test="${userRole=='proprietaire'}">
            <a href="${pageContext.request.contextPath}/proprietaire/immeubles"
               class="nav-link ${param.page=='immeubles'?'active':''}">
                <svg class="nav-icon"><use href="#ic-building"/></svg>
                Immeubles
            </a>
            <a href="${pageContext.request.contextPath}/proprietaire/unites"
               class="nav-link ${param.page=='unites'?'active':''}">
                <svg class="nav-icon"><use href="#ic-door"/></svg>
                Unités
            </a>
            <a href="${pageContext.request.contextPath}/proprietaire/contrats"
               class="nav-link ${param.page=='contrats'?'active':''}">
                <svg class="nav-icon"><use href="#ic-file"/></svg>
                Contrats
            </a>
            <a href="${pageContext.request.contextPath}/proprietaire/paiements"
               class="nav-link ${param.page=='paiements'?'active':''}">
                <svg class="nav-icon"><use href="#ic-payment"/></svg>
                Paiements
            </a>
        </c:if>




        <c:if test="${userRole=='admin'}">
            <div class="nav-section-title" style="margin-top:8px">Administration</div>
            <a href="${pageContext.request.contextPath}/admin/utilisateurs"
               class="nav-link ${param.page=='utilisateurs'?'active':''}">
                <svg class="nav-icon"><use href="#ic-users"/></svg>
                Utilisateurs
            </a>
            <a href="${pageContext.request.contextPath}/admin/demandes"
               class="nav-link ${param.page=='demandes'?'active':''}">
                <svg class="nav-icon"><use href="#ic-inbox"/></svg>
                Demandes
            </a>
            <a href="${pageContext.request.contextPath}/admin/rapports"
               class="nav-link ${param.page=='rapports'?'active':''}">
                <svg class="nav-icon"><use href="#ic-chart"/></svg>
                Rapports
            </a>
        </c:if>

        <c:if test="${userRole=='locataire'}">
            <a href="${pageContext.request.contextPath}/locataire/offres"
               class="nav-link ${param.page=='offres'?'active':''}">
                <svg class="nav-icon"><use href="#ic-search"/></svg>
                Offres disponibles
            </a>
            <a href="${pageContext.request.contextPath}/locataire/mes-contrats"
               class="nav-link ${param.page=='mes-contrats'?'active':''}">
                <svg class="nav-icon"><use href="#ic-file"/></svg>
                Mes contrats
            </a>
            <a href="${pageContext.request.contextPath}/locataire/mes-paiements"
               class="nav-link ${param.page=='mes-paiements'?'active':''}">
                <svg class="nav-icon"><use href="#ic-payment"/></svg>
                Mes paiements
            </a>
            <a href="${pageContext.request.contextPath}/locataire/mes-demandes"
               class="nav-link ${param.page=='mes-demandes'?'active':''}">
                <svg class="nav-icon"><use href="#ic-inbox"/></svg>
                Mes demandes
            </a>
        </c:if>

        <div class="nav-section-title" style="margin-top:8px">Compte</div>
        <a href="${pageContext.request.contextPath}/${userRole}/profil"
           class="nav-link ${param.page=='profil'?'active':''}">
            <svg class="nav-icon"><use href="#ic-user"/></svg>
            Mon profil
        </a>
<%--        <button class="nav-link nav-link-logout nav-btn" onclick="openLogoutModal()">--%>
<%--            <svg class="nav-icon"><use href="#ic-logout"/></svg>--%>
<%--            Déconnexion--%>
<%--        </button>--%>
    </nav>

    <div class="sidebar-footer">
        <div class="user-info-bar">
            <div class="user-avatar-lg">${initials}</div>
            <div>
                <div class="user-name-lg">${currentUser.prenom} ${currentUser.nom}</div>
                <div class="user-role-lg">
                    <c:choose>
                        <c:when test="${userRole=='admin'}">Administrateur</c:when>
                        <c:when test="${userRole=='proprietaire'}">Propriétaire</c:when>
                        <c:otherwise>Locataire</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <button class="btn-deconnexion" onclick="openLogoutModal()">
            <svg style="width:14px;height:14px"><use href="#ic-logout"/></svg>
            Se déconnecter
        </button>
    </div>
</aside>

<div class="sidebar-overlay" id="sidebarOverlay" onclick="toggleSidebar()"></div>

<!-- Modale déconnexion -->
<div id="logoutModal" class="logout-modal-overlay" onclick="closeLogoutModal(event)">
    <div class="logout-modal">
        <div class="logout-modal-icon">
            <svg style="width:24px;height:24px;color:var(--danger)"><use href="#ic-logout"/></svg>
        </div>
        <h3 class="logout-modal-title">Déconnexion</h3>
        <p class="logout-modal-text">
            Voulez-vous vraiment quitter votre session ?<br>
            <span style="font-size:12px;color:var(--text-muted)">Vous devrez vous reconnecter pour accéder à votre espace.</span>
        </p>
        <div class="logout-modal-actions">
            <button class="btn btn-outline" onclick="document.getElementById('logoutModal').classList.remove('active')">
                Annuler
            </button>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout-confirm">
                Se déconnecter
            </a>
        </div>
    </div>
</div>
