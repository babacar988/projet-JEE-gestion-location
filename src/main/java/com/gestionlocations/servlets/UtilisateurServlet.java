package com.gestionlocations.servlets;
import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.UtilisateurService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet("/admin/utilisateurs")
public class UtilisateurServlet extends HttpServlet {
    private final UtilisateurService service = new UtilisateurService();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("nouveau".equals(action) || "modifier".equals(action)) {
            if ("modifier".equals(action))
                service.findById(Long.parseLong(req.getParameter("id"))).ifPresent(u -> req.setAttribute("utilisateur", u));
            req.getRequestDispatcher("/views/admin/utilisateur-form.jsp").forward(req, resp);
        } else if ("desactiver".equals(action)) {
            service.desactiver(Long.parseLong(req.getParameter("id")));
            resp.sendRedirect(req.getContextPath() + "/admin/utilisateurs");
        } else {
            req.setAttribute("utilisateurs", service.findAll());
            req.getRequestDispatcher("/views/admin/utilisateurs-list.jsp").forward(req, resp);
        }
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                service.findById(Long.parseLong(idStr)).ifPresent(u -> {
                    u.setPrenom(req.getParameter("prenom")); u.setNom(req.getParameter("nom"));
                    u.setEmail(req.getParameter("email")); u.setTelephone(req.getParameter("telephone"));
                    u.setAdresse(req.getParameter("adresse"));
                    u.setRole(Utilisateur.RoleUtilisateur.valueOf(req.getParameter("role")));
                    service.modifier(u);
                });
            } else {
                service.inscrire(req.getParameter("email"), req.getParameter("password"),
                    req.getParameter("nom"), req.getParameter("prenom"),
                    req.getParameter("telephone"), Utilisateur.RoleUtilisateur.valueOf(req.getParameter("role")));
            }
            resp.sendRedirect(req.getContextPath() + "/admin/utilisateurs");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/views/admin/utilisateur-form.jsp").forward(req, resp);
        }
    }
}
