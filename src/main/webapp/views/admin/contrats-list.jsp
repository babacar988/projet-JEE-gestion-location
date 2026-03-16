<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><title>Contrats — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">&#9776;</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="contrats"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Contrats de location</h1>
      <div class="topbar-actions">
        <a href="${pageContext.request.contextPath}/admin/contrats?action=nouveau" class="btn btn-primary">+ Nouveau contrat</a>
        <button class="btn-logout-topbar" onclick="openLogoutModal()">Déconnexion</button>
      </div>
    </div>
    <div class="page-content">
      <!-- Résumé -->
      <div class="stats-grid" style="margin-bottom:20px">
        <div class="stat-card">
          <div class="stat-icon green"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg></div>
          <div class="stat-value">${contratsActifs}</div>
          <div class="stat-label">Actifs</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon gold"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg></div>
          <div class="stat-value">${contratsEnAttente}</div>
          <div class="stat-label">En attente</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon red"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg></div>
          <div class="stat-value">${contratsResilies}</div>
          <div class="stat-label">Résiliés</div>
        </div>
      </div>

      <div class="tabs">
        <button class="tab-btn active" onclick="switchTab('ct-all',this)">Tous</button>
        <button class="tab-btn" onclick="switchTab('ct-actif',this)">Actifs</button>
        <button class="tab-btn" onclick="switchTab('ct-attente',this)">En attente</button>
        <button class="tab-btn" onclick="switchTab('ct-autres',this)">Terminés / Résiliés</button>
      </div>

      <div class="card">
        <c:forEach items="${[['ct-all',''],['ct-actif','ACTIF'],['ct-attente','EN_ATTENTE'],['ct-autres','AUTRES']]}" var="tab" varStatus="ts">
        <%-- On génère les 4 tabs via un seul template --%>
        </c:forEach>

        <!-- Tous -->
        <div id="ct-all" class="tab-content active">
          <div class="table-wrap"><table>
            <thead><tr><th>Référence</th><th>Locataire</th><th>Unité</th><th>Loyer</th><th>Début</th><th>Statut</th><th>Actions</th></tr></thead>
            <tbody>
            <c:choose>
              <c:when test="${empty contrats}">
                <tr><td colspan="7" style="text-align:center;padding:40px;color:var(--text-muted)">Aucun contrat</td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="c" items="${contrats}">
                  <tr>
                    <td style="font-family:monospace;font-size:12px;font-weight:600">${c.reference}</td>
                    <td>
                      <div style="font-weight:500">${c.locataire.prenom} ${c.locataire.nom}</div>
                      <div style="font-size:11px;color:var(--text-muted)">${c.locataire.email}</div>
                    </td>
                    <td>
                      <div>N° ${c.unite.numero}</div>
                      <div style="font-size:11px;color:var(--text-muted)">${c.unite.immeuble.nom}</div>
                    </td>
                    <td style="font-weight:600"><fmt:formatNumber value="${c.loyerMensuel}" maxFractionDigits="0"/>€</td>
                    <td style="font-size:12px;color:var(--text-muted)">${c.dateDebut}</td>
                    <td>
                      <c:choose>
                        <c:when test="${c.statut == 'ACTIF'}">      <span class="badge badge-success"><span class="badge-dot"></span>Actif</span></c:when>
                        <c:when test="${c.statut == 'EN_ATTENTE'}"> <span class="badge badge-warning"><span class="badge-dot"></span>En attente</span></c:when>
                        <c:when test="${c.statut == 'RESILIE'}">    <span class="badge badge-danger"> <span class="badge-dot"></span>Résilié</span></c:when>
                        <c:when test="${c.statut == 'TERMINE'}">    <span class="badge badge-navy">Terminé</span></c:when>
                        <c:otherwise><span class="badge badge-navy">${c.statut}</span></c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <div style="display:flex;gap:6px">
                        <a href="${pageContext.request.contextPath}/admin/contrats?action=modifier&id=${c.id}" class="btn btn-outline btn-sm">Modifier</a>
                        <c:if test="${c.statut == 'ACTIF'}">
                          <a href="${pageContext.request.contextPath}/admin/contrats?action=resilier&id=${c.id}"
                             class="btn btn-danger btn-sm"
                             onclick="return confirm('Résilier ce contrat ?')">Résilier</a>
                        </c:if>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
            </tbody>
          </table></div>
        </div>

        <!-- Actifs -->
        <div id="ct-actif" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>Référence</th><th>Locataire</th><th>Unité</th><th>Loyer</th><th>Début</th><th>Actions</th></tr></thead>
            <tbody>
            <c:set var="nba" value="0"/>
            <c:forEach var="c" items="${contrats}">
              <c:if test="${c.statut == 'ACTIF'}">
                <c:set var="nba" value="${nba+1}"/>
                <tr>
                  <td style="font-family:monospace;font-size:12px">${c.reference}</td>
                  <td style="font-weight:500">${c.locataire.prenom} ${c.locataire.nom}</td>
                  <td>N° ${c.unite.numero} — ${c.unite.immeuble.nom}</td>
                  <td style="font-weight:600"><fmt:formatNumber value="${c.loyerMensuel}" maxFractionDigits="0"/>€</td>
                  <td style="font-size:12px;color:var(--text-muted)">${c.dateDebut}</td>
                  <td>
                    <div style="display:flex;gap:6px">
                      <a href="${pageContext.request.contextPath}/admin/contrats?action=modifier&id=${c.id}" class="btn btn-outline btn-sm">Modifier</a>
                      <a href="${pageContext.request.contextPath}/admin/contrats?action=resilier&id=${c.id}"
                         class="btn btn-danger btn-sm" onclick="return confirm('Résilier ?')">Résilier</a>
                    </div>
                  </td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${nba == 0}">
              <tr><td colspan="6" style="text-align:center;padding:36px;color:var(--text-muted)">Aucun contrat actif</td></tr>
            </c:if>
            </tbody>
          </table></div>
        </div>

        <!-- En attente -->
        <div id="ct-attente" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>Référence</th><th>Locataire</th><th>Unité</th><th>Loyer</th><th>Actions</th></tr></thead>
            <tbody>
            <c:set var="nbw" value="0"/>
            <c:forEach var="c" items="${contrats}">
              <c:if test="${c.statut == 'EN_ATTENTE'}">
                <c:set var="nbw" value="${nbw+1}"/>
                <tr>
                  <td style="font-family:monospace;font-size:12px">${c.reference}</td>
                  <td style="font-weight:500">${c.locataire.prenom} ${c.locataire.nom}</td>
                  <td>N° ${c.unite.numero} — ${c.unite.immeuble.nom}</td>
                  <td style="font-weight:600"><fmt:formatNumber value="${c.loyerMensuel}" maxFractionDigits="0"/>€</td>
                  <td><a href="${pageContext.request.contextPath}/admin/contrats?action=modifier&id=${c.id}" class="btn btn-outline btn-sm">Valider</a></td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${nbw == 0}">
              <tr><td colspan="5" style="text-align:center;padding:36px;color:var(--text-muted)">Aucun contrat en attente</td></tr>
            </c:if>
            </tbody>
          </table></div>
        </div>

        <!-- Terminés / Résiliés -->
        <div id="ct-autres" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>Référence</th><th>Locataire</th><th>Unité</th><th>Fin</th><th>Statut</th></tr></thead>
            <tbody>
            <c:set var="nbo" value="0"/>
            <c:forEach var="c" items="${contrats}">
              <c:if test="${c.statut == 'TERMINE' || c.statut == 'RESILIE'}">
                <c:set var="nbo" value="${nbo+1}"/>
                <tr>
                  <td style="font-family:monospace;font-size:12px">${c.reference}</td>
                  <td style="font-weight:500">${c.locataire.prenom} ${c.locataire.nom}</td>
                  <td>N° ${c.unite.numero} — ${c.unite.immeuble.nom}</td>
                  <td style="font-size:12px;color:var(--text-muted)">${c.dateFin}</td>
                  <td>
                    <c:choose>
                      <c:when test="${c.statut == 'RESILIE'}"><span class="badge badge-danger"><span class="badge-dot"></span>Résilié</span></c:when>
                      <c:otherwise><span class="badge badge-navy">Terminé</span></c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${nbo == 0}">
              <tr><td colspan="5" style="text-align:center;padding:36px;color:var(--text-muted)">Aucun contrat terminé ou résilié</td></tr>
            </c:if>
            </tbody>
          </table></div>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
