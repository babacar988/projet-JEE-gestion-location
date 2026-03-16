<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><title>${immeuble.nom} — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">&#9776;</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="immeubles"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">${immeuble.nom}</h1>
      <div class="topbar-actions">
        <a href="${pageContext.request.contextPath}/proprietaire/immeuble-form?id=${immeuble.id}" class="btn btn-primary">Modifier</a>
        <a href="${pageContext.request.contextPath}/proprietaire/immeubles" class="btn btn-outline">Retour</a>
        <button class="btn-logout-topbar" onclick="openLogoutModal()">Déconnexion</button>
      </div>
    </div>
    <div class="page-content">

      <!-- Infos immeuble -->
      <div style="display:grid;grid-template-columns:1fr 1fr;gap:20px;margin-bottom:24px">
        <div class="card">
          <div class="card-header"><span class="card-title">Informations générales</span></div>
          <div class="card-body">
            <table style="width:100%;border-collapse:collapse;font-size:13.5px">
              <tr><td style="padding:8px 0;color:var(--text-muted);width:140px">Adresse</td>
                  <td style="font-weight:500">${immeuble.adresse}</td></tr>
              <tr><td style="padding:8px 0;color:var(--text-muted)">Ville</td>
                  <td style="font-weight:500">${immeuble.ville}<c:if test="${not empty immeuble.codePostal}"> — ${immeuble.codePostal}</c:if></td></tr>
              <tr><td style="padding:8px 0;color:var(--text-muted)">Type</td>
                  <td><span class="badge badge-navy">${immeuble.type}</span></td></tr>
              <c:if test="${immeuble.nombreEtages != null}">
              <tr><td style="padding:8px 0;color:var(--text-muted)">Étages</td>
                  <td style="font-weight:500">${immeuble.nombreEtages}</td></tr>
              </c:if>
              <c:if test="${immeuble.anneeConstruction != null}">
              <tr><td style="padding:8px 0;color:var(--text-muted)">Année</td>
                  <td style="font-weight:500">${immeuble.anneeConstruction}</td></tr>
              </c:if>
              <tr><td style="padding:8px 0;color:var(--text-muted)">Statut</td>
                  <td><span class="badge ${immeuble.actif ? 'badge-success' : 'badge-danger'}">
                    <span class="badge-dot"></span>${immeuble.actif ? 'Actif' : 'Inactif'}</span></td></tr>
            </table>
            <c:if test="${not empty immeuble.description}">
              <hr class="divider">
              <p style="font-size:13px;color:var(--text-secondary);line-height:1.7">${immeuble.description}</p>
            </c:if>
          </div>
        </div>

        <!-- Stats unités -->
        <div>
          <div class="stats-grid" style="grid-template-columns:1fr 1fr;margin-bottom:16px">
            <div class="stat-card">
              <div class="stat-icon navy">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
              </div>
              <div class="stat-value">${immeuble.nombreUnites}</div>
              <div class="stat-label">Unités total</div>
            </div>
            <div class="stat-card">
              <div class="stat-icon green">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
              </div>
              <%-- Compte les dispo --%>
              <c:set var="nbDispo" value="0"/>
              <c:forEach var="u" items="${immeuble.unites}">
                <c:if test="${u.statut == 'DISPONIBLE'}"><c:set var="nbDispo" value="${nbDispo+1}"/></c:if>
              </c:forEach>
              <div class="stat-value">${nbDispo}</div>
              <div class="stat-label">Disponibles</div>
            </div>
          </div>
          <c:if test="${not empty immeuble.equipements}">
            <div class="card">
              <div class="card-header"><span class="card-title">Équipements</span></div>
              <div class="card-body" style="font-size:13.5px;color:var(--text-secondary);line-height:1.8">${immeuble.equipements}</div>
            </div>
          </c:if>
        </div>
      </div>

      <!-- Liste des unités -->
      <div class="card">
        <div class="card-header">
          <span class="card-title">Unités de l'immeuble</span>
          <a href="${pageContext.request.contextPath}/proprietaire/unite-form?immeubleId=${immeuble.id}" class="btn btn-outline btn-sm">+ Nouvelle unité</a>
        </div>
        <c:choose>
          <c:when test="${empty immeuble.unites}">
            <div class="empty-state">
              <div class="empty-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg></div>
              <div class="empty-title">Aucune unité</div>
              <div class="empty-sub">Aucune unité enregistrée pour cet immeuble.</div>
            </div>
          </c:when>
          <c:otherwise>
            <div class="table-wrap">
              <table>
                <thead><tr><th>N°</th><th>Type</th><th>Étage</th><th>Pièces</th><th>Surface</th><th>Loyer</th><th>Statut</th></tr></thead>
                <tbody>
                <c:forEach var="u" items="${immeuble.unites}">
                  <tr>
                    <td style="font-weight:600">N° ${u.numero}</td>
                    <td><span class="badge badge-navy">${u.type}</span></td>
                    <td style="color:var(--text-muted)">
                      <c:choose><c:when test="${u.etage != null}">Étage ${u.etage}</c:when><c:otherwise>RDC</c:otherwise></c:choose>
                    </td>
                    <td><c:choose><c:when test="${u.nombrePieces != null}">${u.nombrePieces} p.</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                    <td><c:choose><c:when test="${u.superficie != null}">${u.superficie} m²</c:when><c:otherwise>—</c:otherwise></c:choose></td>
                    <td style="font-weight:600"><fmt:formatNumber value="${u.loyerMensuel}" maxFractionDigits="0"/>€</td>
                    <td>
                      <c:choose>
                        <c:when test="${u.statut == 'DISPONIBLE'}"><span class="badge badge-success"><span class="badge-dot"></span>Disponible</span></c:when>
                        <c:when test="${u.statut == 'OCCUPEE'}">   <span class="badge badge-danger"> <span class="badge-dot"></span>Occupée</span></c:when>
                        <c:when test="${u.statut == 'EN_TRAVAUX'}"><span class="badge badge-warning"><span class="badge-dot"></span>Travaux</span></c:when>
                        <c:otherwise>                              <span class="badge badge-navy">${u.statut}</span></c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
                </tbody>
              </table>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
