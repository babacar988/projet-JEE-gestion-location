<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Inscription — ImmoGest</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
  <style>
    .auth-center { display:flex;align-items:center;justify-content:center;min-height:100vh;padding:40px; }
    .register-card {
      background: rgba(22, 33, 62, 0.9);
      border: 1px solid var(--glass-border);
      border-radius: 24px;
      padding: 48px;
      width: 100%;
      max-width: 560px;
      backdrop-filter: blur(20px);
    }
    .back-link { display:inline-flex;align-items:center;gap:8px;color:var(--text-secondary);text-decoration:none;font-size:14px;margin-bottom:32px; }
    .back-link:hover { color:var(--accent-light); }
  </style>
</head>
<body>
<div class="auth-center">
  <div class="register-card fade-in">
    <a href="${pageContext.request.contextPath}/login" class="back-link">← Retour à la connexion</a>

    <div style="text-align:center;margin-bottom:36px;">
      <div style="width:56px;height:56px;background:linear-gradient(135deg,var(--accent),var(--gold));border-radius:16px;display:flex;align-items:center;justify-content:center;font-size:24px;margin:0 auto 16px;box-shadow:0 8px 30px rgba(233,69,96,0.3);">👤</div>
      <h2 style="font-family:'Syne',sans-serif;font-size:26px;font-weight:800;margin-bottom:6px;">Créer un compte</h2>
      <p style="font-size:14px;color:var(--text-secondary);">Rejoignez ImmoGest en tant que locataire</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
      <div class="alert alert-danger"><span>⚠️</span> ${error}</div>
    <% } %>

    <form action="${pageContext.request.contextPath}/inscription" method="post" data-validate>
      <div class="form-grid">
        <div class="form-group">
          <label class="form-label">Prénom *</label>
          <input type="text" name="prenom" class="form-control" placeholder="Jean" required value="${prenom}">
        </div>
        <div class="form-group">
          <label class="form-label">Nom *</label>
          <input type="text" name="nom" class="form-control" placeholder="Dupont" required value="${nom}">
        </div>
      </div>

      <div class="form-group">
        <label class="form-label">Email *</label>
        <input type="email" name="email" class="form-control" placeholder="jean.dupont@email.com" required value="${email}">
      </div>

      <div class="form-group">
        <label class="form-label">Téléphone</label>
        <input type="tel" name="telephone" class="form-control" placeholder="06 12 34 56 78">
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label class="form-label">Mot de passe *</label>
          <input type="password" name="motDePasse" class="form-control" placeholder="Min. 6 caractères" required minlength="6">
        </div>
        <div class="form-group">
          <label class="form-label">Confirmer *</label>
          <input type="password" name="confirmMdp" class="form-control" placeholder="Répéter le mot de passe" required>
        </div>
      </div>

      <button type="submit" class="btn btn-primary" style="width:100%;justify-content:center;padding:14px;font-size:15px;margin-top:8px;">
        Créer mon compte →
      </button>
    </form>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
