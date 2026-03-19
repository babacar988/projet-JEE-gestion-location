package com.gestionlocations.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/proprietaire/*", "/locataire/*", "/profil"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        // 1. Non connecté → login
        boolean isLoggedIn = session != null && session.getAttribute("utilisateur") != null;
        if (!isLoggedIn) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        var user = (com.gestionlocations.entities.Utilisateur) session.getAttribute("utilisateur");
        String role = user.getRole().name().toLowerCase();
        String uri  = request.getRequestURI();

        // 2. /profil → accessible par TOUS les rôles connectés
        if (uri.endsWith("/profil")) {
            chain.doFilter(req, res);
            return;
        }

        // 3. Vérification des accès par rôle
        if (uri.contains("/admin/") && !role.equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/" + role + "/dashboard");
            return;
        }
        if (uri.contains("/proprietaire/") && !role.equals("proprietaire") && !role.equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/" + role + "/dashboard");
            return;
        }
        if (uri.contains("/locataire/") && !role.equals("locataire") && !role.equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/" + role + "/dashboard");
            return;
        }

        chain.doFilter(req, res);
    }
}
