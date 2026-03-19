package com.gestionlocations.servlets;

import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.UtilisateurService;
import com.gestionlocations.utils.PasswordUtil;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet("/admin/utilisateurs")
public class UtilisateurServlet extends HttpServlet {
    private final UtilisateurService service = new UtilisateurService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("nouveau".equals(action)) {
            // NE PAS mettre editUser → JSP affiche mode création
            req.setAttribute("editUser", null);
            req.getRequestDispatcher("/views/admin/utilisateur-form.jsp").forward(req, resp);

        } else if ("modifier".equals(action)) {
            try {
                Long id = Long.parseLong(req.getParameter("id"));
                // Mettre dans "editUser" — différent de la session "utilisateur"
                service.findById(id).ifPresent(u -> req.setAttribute("editUser", u));
            } catch (Exception ignored) {}
            req.getRequestDispatcher("/views/admin/utilisateur-form.jsp").forward(req, resp);

        } else if ("desactiver".equals(action)) {
            try { service.desactiver(Long.parseLong(req.getParameter("id"))); }
            catch (Exception ignored) {}
            resp.sendRedirect(req.getContextPath() + "/admin/utilisateurs");

        } else {
            req.setAttribute("utilisateurs", service.findAll());
            req.getRequestDispatcher("/views/admin/utilisateurs-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String idStr   = req.getParameter("id");
            String prenom  = req.getParameter("prenom");
            String nom     = req.getParameter("nom");
            String email   = req.getParameter("email");
            String tel     = req.getParameter("telephone");
            String roleStr = req.getParameter("role");
            String pwd     = req.getParameter("password");
            boolean actif  = !"false".equals(req.getParameter("actif"));

            if (idStr != null && !idStr.isEmpty()) {
                // ── Modification ──
                service.findById(Long.parseLong(idStr)).ifPresent(u -> {
                    u.setPrenom(prenom);
                    u.setNom(nom);
                    u.setEmail(email);
                    u.setTelephone(tel);
                    u.setRole(Utilisateur.RoleUtilisateur.valueOf(roleStr));
                    u.setActif(actif);
                    if (pwd != null && !pwd.isBlank())
                        u.setMotDePasse(PasswordUtil.hashPassword(pwd));
                    service.modifier(u);
                });
            } else {
                // ── Création ──
                Utilisateur u = service.inscrire(
                    email, pwd, nom, prenom, tel,
                    Utilisateur.RoleUtilisateur.valueOf(roleStr)
                );
                if (!actif) { u.setActif(false); service.modifier(u); }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/utilisateurs");

        } catch (Exception e) {
            req.setAttribute("error", "Erreur : " + e.getMessage());
            req.getRequestDispatcher("/views/admin/utilisateur-form.jsp").forward(req, resp);
        }
    }
}
