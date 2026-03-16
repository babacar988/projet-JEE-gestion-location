<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><title>Demandes — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">&#9776;</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="demandes"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Demandes de location</h1>
      <div class="topbar-actions">
        <c:if test="${demandesEnAttente > 0}">
          <span class="badge badge-warning"><span class="badge-dot"></span>${demandesEnAttente} en attente</span>
        </c:if>
        <button class="btn-logout-topbar" onclick="openLogoutModal()">Déconnexion</button>
      </div>
    </div>
    <div class="page-content">

      <div class="tabs">
        <button class="tab-btn active" onclick="switchTab('tab-all',this)">Toutes</button>
        <button class="tab-btn" onclick="switchTab('tab-attente',this)">En attente</button>
        <button class="tab-btn" onclick="switchTab('tab-acceptee',this)">Acceptées</button>
        <button class="tab-btn" onclick="switchTab('tab-refusee',this)">Refusées</button>
      </div>

      <div class="card">
        <!-- Toutes -->
        <div id="tab-all" class="tab-content active">
          <div class="table-wrap"><table>
            <thead><tr><th>Locataire</th><th>Unité</th><th>Immeuble</th><th>Date</th><th>Statut</th><th>Actions</th></tr></thead>
            <tbody>
            <c:choose>
              <c:when test="${empty demandes}">
                <tr><td colspan="6" style="text-align:center;padding:40px;color:var(--text-muted)">Aucune demande</td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="d" items="${demandes}">
                  <tr>
                    <td>
                      <div style="display:flex;align-items:center;gap:10px">
                        <div class="avatar">
                          ${d.locataire.prenom.charAt(0)}${d.locataire.nom.charAt(0)}
                        </div>
                        <div>
                          <div style="font-weight:500">${d.locataire.prenom} ${d.locataire.nom}</div>
                          <div style="font-size:11px;color:var(--text-muted)">${d.locataire.email}</div>
                        </div>
                      </div>
                    </td>
                    <td>N° ${d.unite.numero}</td>
                    <td>
                      <div style="font-weight:500">${d.unite.immeuble.nom}</div>
                      <div style="font-size:11px;color:var(--text-muted)">${d.unite.immeuble.ville}</div>
                    </td>
                    <td style="font-size:12.5px;color:var(--text-muted)">${d.dateDemande}</td>
                    <td>
                      <c:choose>
                        <c:when test="${d.statut == 'EN_ATTENTE'}"> <span class="badge badge-warning"><span class="badge-dot"></span>En attente</span></c:when>
                        <c:when test="${d.statut == 'ACCEPTEE'}">   <span class="badge badge-success"><span class="badge-dot"></span>Acceptée</span></c:when>
                        <c:when test="${d.statut == 'REFUSEE'}">    <span class="badge badge-danger"> <span class="badge-dot"></span>Refusée</span></c:when>
                        <c:otherwise>                               <span class="badge badge-navy">${d.statut}</span></c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <c:if test="${d.statut == 'EN_ATTENTE'}">
                        <div style="display:flex;gap:6px">
                          <a href="${pageContext.request.contextPath}/admin/demandes?action=accepter&id=${d.id}"
                             class="btn btn-success btn-sm"
                             onclick="return confirm('Accepter cette demande ?')">Accepter</a>
                          <a href="${pageContext.request.contextPath}/admin/demandes?action=refuser&id=${d.id}"
                             class="btn btn-danger btn-sm"
                             onclick="return confirm('Refuser cette demande ?')">Refuser</a>
                        </div>
                      </c:if>
                      <c:if test="${d.statut != 'EN_ATTENTE'}">
                        <span style="font-size:12px;color:var(--text-muted)">Traité</span>
                      </c:if>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
            </tbody>
          </table></div>
        </div>

        <!-- En attente -->
        <div id="tab-attente" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>Locataire</th><th>Unité / Immeuble</th><th>Message</th><th>Date</th><th>Actions</th></tr></thead>
            <tbody>
            <c:set var="nb" value="0"/>
            <c:forEach var="d" items="${demandes}">
              <c:if test="${d.statut == 'EN_ATTENTE'}">
                <c:set var="nb" value="${nb+1}"/>
                <tr>
                  <td>
                    <div style="display:flex;align-items:center;gap:8px">
                      <div class="avatar">${d.locataire.prenom.charAt(0)}${d.locataire.nom.charAt(0)}</div>
                      <div>
                        <div style="font-weight:500">${d.locataire.prenom} ${d.locataire.nom}</div>
                        <div style="font-size:11px;color:var(--text-muted)">${d.locataire.email}</div>
                      </div>
                    </div>
                  </td>
                  <td>
                    <div style="font-weight:500">N° ${d.unite.numero}</div>
                    <div style="font-size:11px;color:var(--text-muted)">${d.unite.immeuble.nom}</div>
                  </td>
                  <td style="max-width:200px;font-size:12.5px;color:var(--text-secondary)">
                    <c:choose>
                      <c:when test="${not empty d.message}">${d.message}</c:when>
                      <c:otherwise><em style="color:var(--text-muted)">Aucun message</em></c:otherwise>
                    </c:choose>
                  </td>
                  <td style="font-size:12px;color:var(--text-muted)">${d.dateDemande}</td>
                  <td>
                    <div style="display:flex;gap:6px">
                      <a href="${pageContext.request.contextPath}/admin/demandes?action=accepter&id=${d.id}"
                         class="btn btn-success btn-sm"
                         onclick="return confirm('Accepter cette demande ?')">Accepter</a>
                      <a href="${pageContext.request.contextPath}/admin/demandes?action=refuser&id=${d.id}"
                         class="btn btn-danger btn-sm"
                         onclick="return confirm('Refuser ?')">Refuser</a>
                    </div>
                  </td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${nb == 0}">
              <tr><td colspan="5" style="text-align:center;padding:36px;color:var(--text-muted)">Aucune demande en attente</td></tr>
            </c:if>
            </tbody>
          </table></div>
        </div>

        <!-- Acceptées -->
        <div id="tab-acceptee" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>Locataire</th><th>Unité</th><th>Date réponse</th></tr></thead>
            <tbody>
            <c:set var="nba" value="0"/>
            <c:forEach var="d" items="${demandes}">
              <c:if test="${d.statut == 'ACCEPTEE'}">
                <c:set var="nba" value="${nba+1}"/>
                <tr>
                  <td style="font-weight:500">${d.locataire.prenom} ${d.locataire.nom}</td>
                  <td>N° ${d.unite.numero} — ${d.unite.immeuble.nom}</td>
                  <td style="font-size:12px;color:var(--text-muted)">${d.dateReponse}</td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${nba == 0}">
              <tr><td colspan="3" style="text-align:center;padding:36px;color:var(--text-muted)">Aucune demande acceptée</td></tr>
            </c:if>
            </tbody>
          </table></div>
        </div>

        <!-- Refusées -->
        <div id="tab-refusee" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>Locataire</th><th>Unité</th><th>Date réponse</th></tr></thead>
            <tbody>
            <c:set var="nbr" value="0"/>
            <c:forEach var="d" items="${demandes}">
              <c:if test="${d.statut == 'REFUSEE'}">
                <c:set var="nbr" value="${nbr+1}"/>
                <tr>
                  <td style="font-weight:500">${d.locataire.prenom} ${d.locataire.nom}</td>
                  <td>N° ${d.unite.numero} — ${d.unite.immeuble.nom}</td>
                  <td style="font-size:12px;color:var(--text-muted)">${d.dateReponse}</td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${nbr == 0}">
              <tr><td colspan="3" style="text-align:center;padding:36px;color:var(--text-muted)">Aucune demande refusée</td></tr>
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
