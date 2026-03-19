package com.gestionlocations.servlets;

import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.UtilisateurService;
import com.gestionlocations.utils.PasswordUtil;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet({"/profil", "/admin/profil", "/proprietaire/profil", "/locataire/profil"})
public class ProfilServlet extends HttpServlet {
    private final UtilisateurService service = new UtilisateurService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/shared/profil.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur u = (Utilisateur) req.getSession().getAttribute("utilisateur");
        if (u == null) { resp.sendRedirect(req.getContextPath() + "/login"); return; }
        try {
            u.setPrenom(req.getParameter("prenom"));
            u.setNom(req.getParameter("nom"));
            u.setEmail(req.getParameter("email"));
            u.setTelephone(req.getParameter("telephone"));
            String pwd = req.getParameter("password");
            if (pwd != null && !pwd.isBlank())
                u.setMotDePasse(PasswordUtil.hashPassword(pwd));
            Utilisateur updated = service.modifier(u);
            req.getSession().setAttribute("utilisateur", updated);
            req.setAttribute("success", "Profil mis à jour avec succès !");
        } catch (Exception e) {
            req.setAttribute("error", "Erreur : " + e.getMessage());
        }
        req.getRequestDispatcher("/views/shared/profil.jsp").forward(req, resp);
    }
}
