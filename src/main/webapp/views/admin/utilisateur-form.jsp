<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>${utilisateur!=null?'Modifier':'Ajouter'} utilisateur — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<button class="mobile-menu-btn" onclick="toggleSidebar()">☰</button>
<div class="app-wrapper">
  <jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="utilisateurs"/></jsp:include>
  <div class="main-content">
    <div class="topbar">
      <h1 class="page-title">${utilisateur!=null?'Modifier l\'utilisateur':'Nouvel utilisateur'}</h1>
      <a href="${pageContext.request.contextPath}/logout" class="topbar-logout" onclick="return confirm('Déconnecter ?')">⏻ Déconnexion</a>
    </div>
    <div class="page-content">
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <span class="breadcrumb-sep">›</span>
        <a href="${pageContext.request.contextPath}/admin/utilisateurs">Utilisateurs</a>
        <span class="breadcrumb-sep">›</span><span>${utilisateur!=null?'Modifier':'Ajouter'}</span>
      </div>
      <c:if test="${not empty error}"><div class="alert alert-danger">⚠️ ${error}</div></c:if>
      <div class="card" style="max-width:700px">
        <div class="card-header"><h2 class="card-title">👤 Informations de l'utilisateur</h2></div>
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/admin/utilisateurs" method="post">
            <c:if test="${utilisateur!=null}"><input type="hidden" name="id" value="${utilisateur.id}"></c:if>
            <div class="form-grid" style="margin-bottom:20px">
              <div class="form-group">
                <label>Prénom *</label>
                <input type="text" name="prenom" class="form-control" value="${utilisateur.prenom}" required>
              </div>
              <div class="form-group">
                <label>Nom *</label>
                <input type="text" name="nom" class="form-control" value="${utilisateur.nom}" required>
              </div>
              <div class="form-group">
                <label>Email *</label>
                <input type="email" name="email" class="form-control" value="${utilisateur.email}" required>
              </div>
              <div class="form-group">
                <label>Téléphone</label>
                <input type="tel" name="telephone" class="form-control" value="${utilisateur.telephone}">
              </div>
              <div class="form-group">
                <label>Rôle *</label>
                <select name="role" class="form-control" required>
                  <option value="LOCATAIRE" ${utilisateur.role=='LOCATAIRE'?'selected':''}>🏠 Locataire</option>
                  <option value="PROPRIETAIRE" ${utilisateur.role=='PROPRIETAIRE'?'selected':''}>🏗️ Propriétaire</option>
                  <option value="ADMIN" ${utilisateur.role=='ADMIN'?'selected':''}>👔 Administrateur</option>
                </select>
              </div>
              <div class="form-group">
                <label>${utilisateur!=null?'Nouveau mot de passe (laisser vide = inchangé)':'Mot de passe *'}</label>
                <input type="password" name="password" class="form-control" ${utilisateur==null?'required':''} placeholder="••••••••">
              </div>
              <div class="form-group full">
                <label>Adresse</label>
                <input type="text" name="adresse" class="form-control" value="${utilisateur.adresse}" placeholder="15 rue de la Paix, Paris">
              </div>
            </div>
            <div style="display:flex;gap:12px">
              <button type="submit" class="btn btn-gold">${utilisateur!=null?'💾 Enregistrer':'＋ Créer'}</button>
              <a href="${pageContext.request.contextPath}/admin/utilisateurs" class="btn btn-outline">Annuler</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- MODALE DÉCO (incluse via navbar.jsp) -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body></html>
