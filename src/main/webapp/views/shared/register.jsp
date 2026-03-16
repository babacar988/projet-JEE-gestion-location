<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Inscription — ImmoGest</title>
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
      Rejoignez<br>la plateforme<br><span>immobilière.</span>
    </div>
    <p class="auth-tagline">
      Créez votre compte locataire gratuitement et accédez à toutes les offres disponibles.
    </p>
    <div class="auth-features">
      <div class="auth-feature">
        <div class="auth-feature-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="rgba(255,255,255,0.7)" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        </div>
        Parcourir les offres disponibles
      </div>
      <div class="auth-feature">
        <div class="auth-feature-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="rgba(255,255,255,0.7)" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
        </div>
        Soumettre des demandes de location
      </div>
      <div class="auth-feature">
        <div class="auth-feature-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="rgba(255,255,255,0.7)" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
        </div>
        Suivre vos paiements en ligne
      </div>
    </div>
  </div>

  <!-- Droite -->
  <div class="auth-right">
    <div class="auth-card">
      <h1 class="auth-card-title">Créer un compte</h1>
      <p class="auth-card-sub">Rejoignez notre plateforme de gestion locative</p>

      <c:if test="${not empty error}">
        <div class="alert alert-danger" data-dismiss>${error}</div>
      </c:if>

      <form method="post" action="${pageContext.request.contextPath}/register">

        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="prenom">Prénom</label>
            <input type="text" id="prenom" name="prenom" class="form-control"
                   placeholder="Jean" required autocomplete="given-name">
          </div>
          <div class="form-group">
            <label class="form-label" for="nom">Nom</label>
            <input type="text" id="nom" name="nom" class="form-control"
                   placeholder="Dupont" required autocomplete="family-name">
          </div>
        </div>

        <div class="form-group">
          <label class="form-label" for="email">Adresse email</label>
          <input type="email" id="email" name="email" class="form-control"
                 placeholder="jean.dupont@exemple.fr" required autocomplete="email">
        </div>

        <div class="form-group">
          <label class="form-label" for="telephone">Téléphone</label>
          <input type="tel" id="telephone" name="telephone" class="form-control"
                 placeholder="06 12 34 56 78" autocomplete="tel">
        </div>

        <div class="form-group">
          <label class="form-label" for="password">Mot de passe</label>
          <input type="password" id="password" name="password" class="form-control"
                 placeholder="8 caractères minimum" required autocomplete="new-password" minlength="6">
          <div class="form-hint">Au moins 6 caractères</div>
        </div>

        <button type="submit" class="btn btn-primary btn-lg"
                style="width:100%;justify-content:center;margin-top:8px">
          Créer mon compte
        </button>
      </form>

      <p style="text-align:center;margin-top:18px;font-size:13px;color:var(--text-muted)">
        Déjà inscrit ?
        <a href="${pageContext.request.contextPath}/login"
           style="color:var(--navy);font-weight:600">Se connecter</a>
      </p>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
