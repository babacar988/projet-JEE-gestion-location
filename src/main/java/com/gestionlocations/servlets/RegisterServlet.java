package com.gestionlocations.servlets;
import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.UtilisateurService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UtilisateurService service = new UtilisateurService();
    
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/shared/register.jsp").forward(req, resp);
    }
    
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String nom = req.getParameter("nom");
            String prenom = req.getParameter("prenom");
            String telephone = req.getParameter("telephone");
            Utilisateur u = service.inscrire(email, password, nom, prenom, telephone, Utilisateur.RoleUtilisateur.LOCATAIRE);
            req.getSession(true).setAttribute("utilisateur", u);
            resp.sendRedirect(req.getContextPath() + "/locataire/dashboard");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/views/shared/register.jsp").forward(req, resp);
        }
    }
}
