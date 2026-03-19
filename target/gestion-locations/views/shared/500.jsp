<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html><html>
<head><title>Erreur serveur — ImmoGest</title>
    <jsp:include page="head.jsp"/>
</head>
<body class="bg-default">
<div class="main-content">
    <div class="header bg-gradient-danger py-7 py-lg-8 pt-lg-9">
        <div class="container text-center">
            <h1 class="display-1 text-white font-weight-bold">500</h1>
            <h2 class="text-white">Erreur serveur</h2>
            <p class="text-white opacity-8">Une erreur inattendue s'est produite. Réessayez ou contactez
                l'administrateur.</p>
            <a href="javascript:history.back()" class="btn btn-white mt-3">Retour</a>
        </div>
    </div>
</div>
<jsp:include page="scripts.jsp"/>
</body>
</html>
