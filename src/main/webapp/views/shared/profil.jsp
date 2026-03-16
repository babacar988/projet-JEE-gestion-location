<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
  com.gestionlocations.entities.Utilisateur u =
    (com.gestionlocations.entities.Utilisateur) session.getAttribute("utilisateur");
  String role = u != null ? u.getRole().name().toLowerCase() : "locataire";
  pageContext.setAttribute("userRole", role);
%>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>Mon profil — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="navbar.jsp"><jsp:param name="page" value="profil"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">Mon Profil</h1>
      <a href="${pageContext.request.contextPath}/logout" class="topbar-logout" onclick="return confirm('Déconnecter ?')">⏻ Déconnexion</a>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/${userRole}/dashboard">Dashboard</a>
        <span class="breadcrumb-sep">›</span><span>Mon profil</span>
      </div>
      <c:if test="${not empty success}"><div class="alert alert-success" data-auto-dismiss>✅ ${success}</div></c:if>
      <c:if test="${not empty error}"><div class="alert alert-danger">⚠️ ${error}</div></c:if>

      <div style="display:grid;grid-template-columns:1fr 2fr;gap:24px;max-width:900px">
        <!-- Avatar card -->
        <div class="card" style="text-align:center;padding:32px 20px">
          <div style="width:80px;height:80px;border-radius:50%;background:linear-gradient(135deg,var(--gold),var(--gold-light));display:flex;align-items:center;justify-content:center;font-size:28px;font-weight:700;color:var(--navy);margin:0 auto 16px">
            ${sessionScope.utilisateur.prenom.charAt(0)}${sessionScope.utilisateur.nom.charAt(0)}
          </div>
          <div style="font-family:'Playfair Display',serif;font-size:20px;font-weight:700;color:var(--navy)">${sessionScope.utilisateur.nomComplet}</div>
          <div style="margin-top:8px">
            <c:choose>
              <c:when test="${userRole=='admin'}"><span class="badge badge-navy">👔 Administrateur</span></c:when>
              <c:when test="${userRole=='proprietaire'}"><span class="badge badge-gold">🏗️ Propriétaire</span></c:when>
              <c:otherwise><span class="badge badge-info">🏠 Locataire</span></c:otherwise>
            </c:choose>
          </div>
          <div style="margin-top:16px;font-size:13px;color:var(--text-muted)">${sessionScope.utilisateur.email}</div>
          <div style="margin-top:24px;padding-top:16px;border-top:1px solid var(--border)">
            <a href="${pageContext.request.contextPath}/logout" class="btn-deconnexion" onclick="return confirm('Confirmer la déconnexion ?')">
              ⏻ Se déconnecter
            </a>
          </div>
        </div>

        <!-- Edit form -->
        <div class="card">
          <div class="card-header"><h2 class="card-title">✏️ Modifier mes informations</h2></div>
          <div class="card-body">
            <form action="${pageContext.request.contextPath}/${userRole}/profil" method="post">
              <div class="form-grid" style="margin-bottom:20px">
                <div class="form-group">
                  <label>Prénom</label>
                  <input type="text" name="prenom" class="form-control" value="${sessionScope.utilisateur.prenom}" required>
                </div>
                <div class="form-group">
                  <label>Nom</label>
                  <input type="text" name="nom" class="form-control" value="${sessionScope.utilisateur.nom}" required>
                </div>
                <div class="form-group">
                  <label>Email</label>
                  <input type="email" name="email" class="form-control" value="${sessionScope.utilisateur.email}" required>
                </div>
                <div class="form-group">
                  <label>Téléphone</label>
                  <input type="tel" name="telephone" class="form-control" value="${sessionScope.utilisateur.telephone}">
                </div>
                <div class="form-group full">
                  <label>Adresse</label>
                  <input type="text" name="adresse" class="form-control" value="${sessionScope.utilisateur.adresse}">
                </div>
              </div>

              <div class="section-divider">Changer le mot de passe</div>
              <div class="form-grid" style="margin-bottom:20px">
                <div class="form-group">
                  <label>Nouveau mot de passe</label>
                  <input type="password" name="newPassword" class="form-control" placeholder="Laisser vide = inchangé">
                </div>
                <div class="form-group">
                  <label>Confirmer le mot de passe</label>
                  <input type="password" name="confirmPassword" class="form-control" placeholder="Répéter le mot de passe">
                </div>
              </div>

              <div style="display:flex;gap:12px">
                <button type="submit" class="btn btn-gold">💾 Enregistrer les modifications</button>
                <a href="${pageContext.request.contextPath}/${userRole}/dashboard" class="btn btn-outline">Annuler</a>
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
