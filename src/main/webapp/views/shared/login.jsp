<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Connexion — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>
<div class="auth-wrapper">
  <!-- Gauche -->
  <div class="auth-left">
    <div class="auth-logo">
      <div class="auth-logo-icon">
        <svg viewBox="0 0 24 24" fill="white"><path d="M1 22V9.5l10-8 10 8V22H15v-7h-6v7H1z"/></svg>
      </div>
      <span class="auth-logo-text">ImmoGest</span>
    </div>
    <div class="auth-headline">
      Gérez votre<br>patrimoine<br><span>immobilier.</span>
    </div>
    <p class="auth-tagline">
      Plateforme complète de gestion locative — immeubles, contrats, paiements et locataires en un seul endroit.
    </p>
    <div class="auth-features">
      <div class="auth-feature">
        <div class="auth-feature-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="rgba(255,255,255,0.7)" stroke-width="2"><rect x="4" y="2" width="16" height="20" rx="2"/><path d="M9 22v-4h6v4M8 6h.01M16 6h.01M8 10h.01M16 10h.01"/></svg>
        </div>
        Gestion multi-immeubles
      </div>
      <div class="auth-feature">
        <div class="auth-feature-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="rgba(255,255,255,0.7)" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></svg>
        </div>
        Contrats automatisés
      </div>
      <div class="auth-feature">
        <div class="auth-feature-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="rgba(255,255,255,0.7)" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
        </div>
        Suivi des paiements
      </div>
      <div class="auth-feature">
        <div class="auth-feature-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="rgba(255,255,255,0.7)" stroke-width="2"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/><line x1="2" y1="20" x2="22" y2="20"/></svg>
        </div>
        Rapports détaillés
      </div>
    </div>
  </div>

  <!-- Droite -->
  <div class="auth-right">
    <div class="auth-card">
      <h1 class="auth-card-title">Connexion</h1>
      <p class="auth-card-sub">Accédez à votre espace de gestion</p>

      <c:if test="${not empty error}">
        <div class="alert alert-danger" data-dismiss>${error}</div>
      </c:if>

      <form method="post" action="${pageContext.request.contextPath}/login">
        <div class="form-group">
          <label class="form-label" for="email">Adresse email</label>
          <input type="email" id="email" name="email" class="form-control"
                 placeholder="vous@exemple.fr" required autocomplete="email">
        </div>
        <div class="form-group">
          <label class="form-label" for="password">Mot de passe</label>
          <input type="password" id="password" name="password" class="form-control"
                 placeholder="••••••••" required autocomplete="current-password">
        </div>
        <button type="submit" class="btn btn-primary btn-lg" style="width:100%;justify-content:center;margin-top:4px">
          Se connecter
        </button>
      </form>

      <div class="demo-accounts">
        <div class="demo-title">Comptes de démonstration</div>
        <div class="demo-row" onclick="fillLogin('admin@immogest.fr','passer123')">
          <div>
            <div class="demo-role">Administrateur</div>
            <div class="demo-email">admin@immogest.fr</div>
          </div>
          <span class="demo-use">Utiliser</span>
        </div>
        <div class="demo-row" onclick="fillLogin('proprio1@immogest.fr','passer123')">
          <div>
            <div class="demo-role">Propriétaire</div>
            <div class="demo-email">proprio1@immogest.fr</div>
          </div>
          <span class="demo-use">Utiliser</span>
        </div>
        <div class="demo-row" onclick="fillLogin('locataire1@immogest.fr','passer123')">
          <div>
            <div class="demo-role">Locataire</div>
            <div class="demo-email">locataire1@immogest.fr</div>
          </div>
          <span class="demo-use">Utiliser</span>
        </div>
      </div>

      <p style="text-align:center;margin-top:18px;font-size:13px;color:var(--text-muted)">
        Pas encore de compte ?
        <a href="${pageContext.request.contextPath}/register" style="color:var(--navy);font-weight:600">S'inscrire</a>
      </p>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
