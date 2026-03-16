package com.gestionlocations.servlets;
import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.UtilisateurService;
import com.gestionlocations.utils.PasswordUtil;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet({"/admin/profil", "/proprietaire/profil", "/locataire/profil"})
public class ProfilServlet extends HttpServlet {
    private final UtilisateurService service = new UtilisateurService();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/shared/profil.jsp").forward(req, resp);
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utilisateur u = (Utilisateur) req.getSession().getAttribute("utilisateur");
        String action = req.getParameter("action");
        try {
            if ("password".equals(action)) {
                String ancien = req.getParameter("ancienMdp");
                String nouveau = req.getParameter("nouveauMdp");
                if (!PasswordUtil.checkPassword(ancien, u.getMotDePasse())) throw new Exception("Mot de passe actuel incorrect");
                u.setMotDePasse(PasswordUtil.hashPassword(nouveau));
                service.modifier(u);
                req.setAttribute("success", "Mot de passe modifié avec succès");
            } else {
                u.setPrenom(req.getParameter("prenom")); u.setNom(req.getParameter("nom"));
                u.setEmail(req.getParameter("email")); u.setTelephone(req.getParameter("telephone"));
                u.setAdresse(req.getParameter("adresse"));
                Utilisateur updated = service.modifier(u);
                req.getSession().setAttribute("utilisateur", updated);
                req.setAttribute("success", "Profil mis à jour avec succès");
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
        }
        req.getRequestDispatcher("/views/shared/profil.jsp").forward(req, resp);
    }
}
