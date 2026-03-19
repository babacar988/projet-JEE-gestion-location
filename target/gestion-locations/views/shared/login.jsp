<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Connexion — ImmoGest</title>
    <jsp:include page="head.jsp"/>
</head>
<body class="bg-default">
<div class="main-content">
    <!-- Header -->
    <div class="header bg-gradient-primary py-7 py-lg-8 pt-lg-9">
        <div class="container">
            <div class="header-body text-center mb-7">
                <div class="row justify-content-center">
                    <div class="col-xl-5 col-lg-6 col-md-8 px-5">
                        <img src="${pageContext.request.contextPath}/argon-assets/img/brand/white.png"
                             style="height:48px;margin-bottom:20px" alt="ImmoGest">
                        <h1 class="text-white">ImmoGest</h1>
                        <p class="text-lead text-white">Plateforme de gestion locative</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="separator separator-bottom separator-skew zindex-100">
            <svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none"
                 version="1.1" xmlns="http://www.w3.org/2000/svg">
                <polygon class="fill-default" points="2560 0 2560 100 0 100"></polygon>
            </svg>
        </div>
    </div>
    <!-- Page content -->
    <div class="container mt--8 pb-5">
        <div class="row justify-content-center">
            <div class="col-lg-5 col-md-7">
                <div class="card bg-secondary border-0 mb-0">
                    <div class="card-body px-lg-5 py-lg-5">
                        <div class="text-center text-muted mb-4">
                            <small>Connectez-vous avec vos identifiants</small>
                        </div>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle mr-2"></i>${error}
                            </div>
                        </c:if>
                        <form method="post" action="${pageContext.request.contextPath}/login">
                            <div class="form-group mb-3">
                                <div class="input-group input-group-merge input-group-alternative">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="ni ni-email-83"></i></span>
                                    </div>
                                    <input class="form-control" placeholder="Email" type="email"
                                           name="email" required autofocus>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group input-group-merge input-group-alternative">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
                                    </div>
                                    <input class="form-control" placeholder="Mot de passe"
                                           type="password" name="password" required>
                                </div>
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary my-4 btn-block">
                                    Se connecter
                                </button>
                            </div>
                        </form>
                        <!-- Comptes démo -->
                        <hr>
                        <p class="text-center text-muted text-xs mb-2">Comptes de démonstration</p>
                        <div class="row text-center" style="font-size:11px">
                            <div class="col-4">
                                <div class="badge badge-primary p-2" style="cursor:pointer;width:100%"
                                     onclick="fillLogin('admin@immogest.fr')">
                                    <i class="ni ni-settings-gear-65"></i> Admin
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="badge badge-warning p-2" style="cursor:pointer;width:100%"
                                     onclick="fillLogin('proprio1@immogest.fr')">
                                    <i class="ni ni-building"></i> Proprio
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="badge badge-success p-2" style="cursor:pointer;width:100%"
                                     onclick="fillLogin('locataire1@immogest.fr')">
                                    <i class="ni ni-circle-08"></i> Locataire
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-6">
                        <a href="${pageContext.request.contextPath}/register" class="text-light">
                            <small>Créer un compte</small>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="scripts.jsp"/>
<script>
    function fillLogin(email) {
        document.querySelector('input[name="email"]').value = email;
        document.querySelector('input[name="password"]').value = 'passer123';
    }
</script>
</body>
</html>
