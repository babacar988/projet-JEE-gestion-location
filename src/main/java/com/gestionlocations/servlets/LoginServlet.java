package com.gestionlocations.servlets;
import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.UtilisateurService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UtilisateurService service = new UtilisateurService();
    
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("utilisateur") != null) {
            redirectDashboard((Utilisateur) session.getAttribute("utilisateur"), req, resp);
            return;
        }
        req.getRequestDispatcher("/views/shared/login.jsp").forward(req, resp);
    }
    
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Optional<Utilisateur> opt = service.authentifier(email, password);
        if (opt.isPresent()) {
            HttpSession session = req.getSession(true);
            session.setAttribute("utilisateur", opt.get());
            session.setMaxInactiveInterval(3600);
            redirectDashboard(opt.get(), req, resp);
        } else {
            req.setAttribute("error", "Email ou mot de passe incorrect");
            req.getRequestDispatcher("/views/shared/login.jsp").forward(req, resp);
        }
    }
    
    private void redirectDashboard(Utilisateur u, HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String base = req.getContextPath();
        switch (u.getRole()) {
            case ADMIN -> resp.sendRedirect(base + "/admin/dashboard");
            case PROPRIETAIRE -> resp.sendRedirect(base + "/proprietaire/dashboard");
            case LOCATAIRE -> resp.sendRedirect(base + "/locataire/dashboard");
        }
    }
}
