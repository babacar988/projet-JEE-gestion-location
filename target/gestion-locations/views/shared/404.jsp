<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html><html>
<head><title>Page introuvable — ImmoGest</title>
    <jsp:include page="head.jsp"/>
</head>
<body class="bg-default">
<div class="main-content">
    <div class="header bg-gradient-primary py-7 py-lg-8 pt-lg-9">
        <div class="container text-center">
            <h1 class="display-1 text-white font-weight-bold">404</h1>
            <h2 class="text-white">Page introuvable</h2>
            <p class="text-white opacity-8">La ressource demandée n'existe pas ou a été déplacée.</p>
            <a href="javascript:history.back()" class="btn btn-white mt-3">Retour</a>
        </div>
    </div>
</div>
<jsp:include page="scripts.jsp"/>
</body>
</html>
