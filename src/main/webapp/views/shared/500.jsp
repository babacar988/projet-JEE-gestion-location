<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html><html lang="fr">
<head><meta charset="UTF-8"><title>Erreur serveur — ImmoGest</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"></head>
<body>
<div style="min-height:100vh;background:var(--navy);display:flex;align-items:center;justify-content:center;flex-direction:column;text-align:center;padding:20px">
  <div style="font-size:80px;margin-bottom:16px">⚠️</div>
  <h1 style="font-family:'Playfair Display',serif;font-size:80px;color:var(--danger);margin:0;line-height:1">500</h1>
  <p style="color:rgba(255,255,255,0.7);font-size:18px;margin:16px 0 8px">Une erreur serveur s'est produite</p>
  <p style="color:rgba(255,255,255,0.4);font-size:14px;margin-bottom:32px">${pageContext.exception != null ? pageContext.exception.message : 'Erreur interne'}</p>
  <a href="javascript:history.back()" class="btn btn-gold">← Retour</a>
</div>
</body></html>
