<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Inscription — ImmoGest</title>
    <jsp:include page="head.jsp"/>
</head>
<body class="bg-default">
<div class="main-content">
    <div class="header bg-gradient-primary py-7 py-lg-8 pt-lg-9">
        <div class="container">
            <div class="header-body text-center mb-7">
                <div class="row justify-content-center">
                    <div class="col-xl-5 col-lg-6 col-md-8 px-5">
                        <img src="${pageContext.request.contextPath}/argon-assets/img/brand/white.png"
                             style="height:48px;margin-bottom:20px" alt="ImmoGest">
                        <h1 class="text-white">Créer un compte</h1>
                        <p class="text-lead text-white">Rejoignez ImmoGest dès aujourd'hui</p>
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
    <div class="container mt--8 pb-5">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="card bg-secondary border-0">
                    <div class="card-body px-lg-5 py-lg-5">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger"><i class="fas fa-exclamation-circle mr-2"></i>${error}</div>
                        </c:if>
                        <form method="post" action="${pageContext.request.contextPath}/register">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="input-group input-group-merge input-group-alternative mb-3">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="ni ni-hat-3"></i></span>
                                            </div>
                                            <input class="form-control" placeholder="Prénom" type="text"
                                                   name="prenom" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <div class="input-group input-group-merge input-group-alternative mb-3">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text"><i class="ni ni-hat-3"></i></span>
                                            </div>
                                            <input class="form-control" placeholder="Nom" type="text"
                                                   name="nom" required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group input-group-merge input-group-alternative mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="ni ni-email-83"></i></span>
                                    </div>
                                    <input class="form-control" placeholder="Email" type="email"
                                           name="email" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group input-group-merge input-group-alternative mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="ni ni-mobile-button"></i></span>
                                    </div>
                                    <input class="form-control" placeholder="Téléphone (optionnel)"
                                           type="tel" name="telephone">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group input-group-merge input-group-alternative mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
                                    </div>
                                    <input class="form-control" placeholder="Mot de passe"
                                           type="password" name="password" required minlength="6">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-control-label">Je suis</label>
                                <select name="role" class="form-control">
                                    <option value="LOCATAIRE">Locataire</option>
                                    <option value="PROPRIETAIRE">Propriétaire</option>
                                </select>
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary mt-4 btn-block">
                                    Créer mon compte
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12 text-center">
                        <a href="${pageContext.request.contextPath}/login" class="text-light">
                            <small>Déjà inscrit ? Se connecter</small>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="scripts.jsp"/>
</body>
</html>
