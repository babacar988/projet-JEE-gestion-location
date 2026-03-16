<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><title>Unités — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">&#9776;</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="unites"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Gestion des unités</h1>
      <div class="topbar-actions">
        <a href="${pageContext.request.contextPath}/admin/unites?action=nouveau" class="btn btn-primary">
          + Nouvelle unité
        </a>
        <button class="btn-logout-topbar" onclick="openLogoutModal()">Déconnexion</button>
      </div>
    </div>
    <div class="page-content">
      <c:if test="${not empty success}">
        <div class="alert alert-success" data-dismiss>${success}</div>
      </c:if>

      <!-- Tabs statut -->
      <div class="tabs">
        <button class="tab-btn active" onclick="switchTab('tab-all',this)">Toutes</button>
        <button class="tab-btn" onclick="switchTab('tab-dispo',this)">Disponibles</button>
        <button class="tab-btn" onclick="switchTab('tab-occ',this)">Occupées</button>
        <button class="tab-btn" onclick="switchTab('tab-autre',this)">Autres</button>
      </div>

      <c:set var="all"    value="${unites}"/>
      <c:set var="dispo"  value="${unites}"/>
      <c:set var="occ"    value="${unites}"/>
      <c:set var="autre"  value="${unites}"/>

      <div class="card">
        <!-- Toutes -->
        <div id="tab-all" class="tab-content active">
          <div class="table-wrap">
            <table>
              <thead><tr>
                <th>N° / Étage</th><th>Immeuble</th><th>Type</th>
                <th>Pièces</th><th>Surface</th><th>Loyer</th><th>Statut</th><th>Actions</th>
              </tr></thead>
              <tbody>
              <c:choose>
                <c:when test="${empty unites}">
                  <tr><td colspan="8" style="text-align:center;padding:40px;color:var(--text-muted)">Aucune unité enregistrée</td></tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="u" items="${unites}">
                    <tr>
                      <td>
                        <strong>N° ${u.numero}</strong>
                        <div style="font-size:11px;color:var(--text-muted)">
                          <c:choose>
                            <c:when test="${u.etage != null}">Étage ${u.etage}</c:when>
                            <c:otherwise>RDC</c:otherwise>
                          </c:choose>
                        </div>
                      </td>
                      <td>
                        <div style="font-weight:500">${u.immeuble.nom}</div>
                        <div style="font-size:11px;color:var(--text-muted)">${u.immeuble.ville}</div>
                      </td>
                      <td><span class="badge badge-navy">${u.type}</span></td>
                      <td><c:choose><c:when test="${u.nombrePieces != null}">${u.nombrePieces} p.</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                      <td><c:choose><c:when test="${u.superficie != null}">${u.superficie} m²</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                      <td style="font-weight:600">
                        <fmt:formatNumber value="${u.loyerMensuel}" maxFractionDigits="0"/>€
                        <div style="font-size:11px;font-weight:400;color:var(--text-muted)">
                          +<fmt:formatNumber value="${u.charges}" maxFractionDigits="0"/>€ ch.
                        </div>
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${u.statut == 'DISPONIBLE'}">  <span class="badge badge-success"><span class="badge-dot"></span>Disponible</span></c:when>
                          <c:when test="${u.statut == 'OCCUPEE'}">     <span class="badge badge-danger"> <span class="badge-dot"></span>Occupée</span></c:when>
                          <c:when test="${u.statut == 'EN_TRAVAUX'}">  <span class="badge badge-warning"><span class="badge-dot"></span>Travaux</span></c:when>
                          <c:otherwise>                                <span class="badge badge-info">   <span class="badge-dot"></span>${u.statut}</span></c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <div style="display:flex;gap:6px">
                          <a href="${pageContext.request.contextPath}/admin/unites?action=modifier&id=${u.id}" class="btn btn-outline btn-sm">Modifier</a>
                          <a href="${pageContext.request.contextPath}/admin/unites?action=supprimer&id=${u.id}" class="btn btn-danger btn-sm"
                             onclick="return confirmDelete('Supprimer cette unité ?')">Supprimer</a>
                        </div>
                      </td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Disponibles -->
        <div id="tab-dispo" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>N°</th><th>Immeuble</th><th>Type</th><th>Surface</th><th>Loyer</th><th>Actions</th></tr></thead>
            <tbody>
            <c:set var="found" value="false"/>
            <c:forEach var="u" items="${unites}">
              <c:if test="${u.statut == 'DISPONIBLE'}">
                <c:set var="found" value="true"/>
                <tr>
                  <td><strong>N° ${u.numero}</strong></td>
                  <td>${u.immeuble.nom} — ${u.immeuble.ville}</td>
                  <td><span class="badge badge-navy">${u.type}</span></td>
                  <td><c:choose><c:when test="${u.superficie != null}">${u.superficie} m²</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                  <td style="font-weight:600"><fmt:formatNumber value="${u.loyerMensuel}" maxFractionDigits="0"/>€</td>
                  <td><a href="${pageContext.request.contextPath}/admin/unites?action=modifier&id=${u.id}" class="btn btn-outline btn-sm">Modifier</a></td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${!found}">
              <tr><td colspan="6" style="text-align:center;padding:32px;color:var(--text-muted)">Aucune unité disponible</td></tr>
            </c:if>
            </tbody>
          </table></div>
        </div>

        <!-- Occupées -->
        <div id="tab-occ" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>N°</th><th>Immeuble</th><th>Type</th><th>Loyer</th><th>Actions</th></tr></thead>
            <tbody>
            <c:set var="found2" value="false"/>
            <c:forEach var="u" items="${unites}">
              <c:if test="${u.statut == 'OCCUPEE'}">
                <c:set var="found2" value="true"/>
                <tr>
                  <td><strong>N° ${u.numero}</strong></td>
                  <td>${u.immeuble.nom} — ${u.immeuble.ville}</td>
                  <td><span class="badge badge-navy">${u.type}</span></td>
                  <td style="font-weight:600"><fmt:formatNumber value="${u.loyerMensuel}" maxFractionDigits="0"/>€</td>
                  <td><a href="${pageContext.request.contextPath}/admin/unites?action=modifier&id=${u.id}" class="btn btn-outline btn-sm">Modifier</a></td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${!found2}">
              <tr><td colspan="5" style="text-align:center;padding:32px;color:var(--text-muted)">Aucune unité occupée</td></tr>
            </c:if>
            </tbody>
          </table></div>
        </div>

        <!-- Autres -->
        <div id="tab-autre" class="tab-content">
          <div class="table-wrap"><table>
            <thead><tr><th>N°</th><th>Immeuble</th><th>Type</th><th>Statut</th><th>Actions</th></tr></thead>
            <tbody>
            <c:set var="found3" value="false"/>
            <c:forEach var="u" items="${unites}">
              <c:if test="${u.statut != 'DISPONIBLE' && u.statut != 'OCCUPEE'}">
                <c:set var="found3" value="true"/>
                <tr>
                  <td><strong>N° ${u.numero}</strong></td>
                  <td>${u.immeuble.nom} — ${u.immeuble.ville}</td>
                  <td><span class="badge badge-navy">${u.type}</span></td>
                  <td><span class="badge badge-warning">${u.statut}</span></td>
                  <td><a href="${pageContext.request.contextPath}/admin/unites?action=modifier&id=${u.id}" class="btn btn-outline btn-sm">Modifier</a></td>
                </tr>
              </c:if>
            </c:forEach>
            <c:if test="${!found3}">
              <tr><td colspan="5" style="text-align:center;padding:32px;color:var(--text-muted)">Aucune unité dans d'autres états</td></tr>
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
