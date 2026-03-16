<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><title>Mes contrats — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">&#9776;</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="contrats"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Mes contrats</h1>
      <div class="topbar-actions">
        <button class="btn-logout-topbar" onclick="openLogoutModal()">Déconnexion</button>
      </div>
    </div>
    <div class="page-content">

      <div class="stats-grid" style="margin-bottom:20px">
        <div class="stat-card">
          <div class="stat-icon green">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
          </div>
          <div class="stat-value">${contratsActifs}</div>
          <div class="stat-label">Actifs</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon gold">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
          </div>
          <div class="stat-value">${contratsEnAttente}</div>
          <div class="stat-label">En attente</div>
        </div>
        <div class="stat-card">
          <div class="stat-icon navy">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
          </div>
          <div class="stat-value">${contrats.size()}</div>
          <div class="stat-label">Total</div>
        </div>
      </div>

      <div class="tabs">
        <button class="tab-btn active" onclick="switchTab('ct-all',this)">Tous</button>
        <button class="tab-btn" onclick="switchTab('ct-actif',this)">Actifs</button>
        <button class="tab-btn" onclick="switchTab('ct-autres',this)">Autres</button>
      </div>

      <div class="card">
        <div id="ct-all" class="tab-content active">
          <div class="table-wrap"><table>
            <thead><tr><th>Référence</th><th>Locataire</th><th>Unité</th><th>Immeuble</th><th>Loyer</th><th>Début</th><th>Statut</th></tr></thead>
            <tbody>
            <c:choose>
              <c:when test="${empty contrats}">
                <tr><td colspan="7" style="text-align:center;padding:40px;color:var(--text-muted)">Aucun contrat trouvé</td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="c" items="${contrats}">
                  <tr>
                    <td style="font-family:monospace;font-size:12px;font-weight:600">${c.reference}</td>
                    <td>
                      <div style="display:flex;align-items:center;gap:8px">
                        <div class="avatar">${c.locataire.prenom.charAt(0)}${c.locataire.nom.charAt(0)}</div>
                        <div>
                          <div style="font-weight:500">${c.locataire.prenom} ${c.locataire.nom}</div>
                          <div style="font-size:11px;color:var(--text-muted)">${c.locataire.email}</div>
                        </div>
                      </div>
                    </td>
                    <td>N° ${c.unite.numero}</td>
                    <td style="font-size:12.5px">${c.unite.immeuble.nom}</td>
                    <td style="font-weight:600"><fmt:formatNumber value="${c.loyerMensuel}" maxFractionDigits="0"/>€</td>
                    <td style="font-size:12px;color:var(--text-muted)">${c.dateDebut}</td>
                    <td>
                      <c:choose>
                        <c:when test="${c.statut == 'ACTIF'}">      <span class="badge badge-success"><span class="badge-dot"></span>Actif</span></c:when>
                        <c:when test="${c.statut == 'EN_ATTENTE'}"> <span class="badge badge-warning"><span class="badge-dot"></span>En attente</span></c:when>
                        <c:when test="${c.statut == 'RESILIE'}">    <span class="badge badge-danger"> <span class="badge-dot"></span>Résilié</span></c:when>
                        <c:otherwise>                               <span class="badge badge-navy">${c.statut}</span></c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
            </tbody>
          </table></div>
        </div>

        <div id="ct-actif" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>Référence</th><th>Locataire</th><th>Unité</th><th>Loyer</th><th>Début</th></tr></thead>
            <tbody>
            <c:set var="n" value="0"/>
            <c:forEach var="c" items="${contrats}">
              <c:if test="${c.statut == 'ACTIF'}">
                <c:set var="n" value="${n+1}"/>
                <tr>
                  <td style="font-family:monospace;font-size:12px">${c.reference}</td>
                  <td style="font-weight:500">${c.locataire.prenom} ${c.locataire.nom}</td>
                  <td>N° ${c.unite.numero} — ${c.unite.immeuble.nom}</td>
                  <td style="font-weight:600"><fmt:formatNumber value="${c.loyerMensuel}" maxFractionDigits="0"/>€</td>
                  <td style="font-size:12px;color:var(--text-muted)">${c.dateDebut}</td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${n==0}"><tr><td colspan="5" style="text-align:center;padding:36px;color:var(--text-muted)">Aucun contrat actif</td></tr></c:if>
            </tbody>
          </table></div>
        </div>

        <div id="ct-autres" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>Référence</th><th>Locataire</th><th>Unité</th><th>Fin</th><th>Statut</th></tr></thead>
            <tbody>
            <c:set var="n2" value="0"/>
            <c:forEach var="c" items="${contrats}">
              <c:if test="${c.statut != 'ACTIF' && c.statut != 'EN_ATTENTE'}">
                <c:set var="n2" value="${n2+1}"/>
                <tr>
                  <td style="font-family:monospace;font-size:12px">${c.reference}</td>
                  <td style="font-weight:500">${c.locataire.prenom} ${c.locataire.nom}</td>
                  <td>N° ${c.unite.numero} — ${c.unite.immeuble.nom}</td>
                  <td style="font-size:12px;color:var(--text-muted)">${c.dateFin}</td>
                  <td><span class="badge badge-navy">${c.statut}</span></td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${n2==0}"><tr><td colspan="5" style="text-align:center;padding:36px;color:var(--text-muted)">Aucun contrat terminé</td></tr></c:if>
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
