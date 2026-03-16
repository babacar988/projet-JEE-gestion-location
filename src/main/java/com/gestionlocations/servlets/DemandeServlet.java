package com.gestionlocations.servlets;

import com.gestionlocations.dao.DemandeLocationDAO;
import com.gestionlocations.entities.*;
import com.gestionlocations.services.UniteLocationService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet({"/locataire/demande", "/locataire/mes-demandes", "/admin/demandes"})
public class DemandeServlet extends HttpServlet {
    private final DemandeLocationDAO dao = new DemandeLocationDAO();
    private final UniteLocationService uniteService = new UniteLocationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String uri = req.getRequestURI();
        Utilisateur u = (Utilisateur) req.getSession().getAttribute("utilisateur");

        if (uri.contains("/admin/demandes")) {
            String action = req.getParameter("action");
            if ("accepter".equals(action) || "refuser".equals(action)) {
                Long id = Long.parseLong(req.getParameter("id"));
                dao.findById(id).ifPresent(d -> {
                    d.setStatut("accepter".equals(action)
                        ? DemandeLocation.StatutDemande.ACCEPTEE
                        : DemandeLocation.StatutDemande.REFUSEE);
                    d.setReponse(req.getParameter("reponse"));
                    d.setDateReponse(java.time.LocalDateTime.now());
                    dao.save(d);
                });
                resp.sendRedirect(req.getContextPath() + "/admin/demandes");
            } else {
                // JOIN FETCH dans findAll() — plus de LazyInitializationException
                var demandes = dao.findAll();
                req.setAttribute("demandes", demandes);
                req.setAttribute("demandesEnAttente",
                    demandes.stream()
                        .filter(d -> d.getStatut() == DemandeLocation.StatutDemande.EN_ATTENTE)
                        .count());
                req.getRequestDispatcher("/views/admin/demandes-list.jsp").forward(req, resp);
            }
        } else if (uri.contains("/mes-demandes")) {
            req.setAttribute("demandes", dao.findByLocataire(u.getId()));
            req.getRequestDispatcher("/views/locataire/mes-demandes.jsp").forward(req, resp);
        } else {
            String uniteId = req.getParameter("uniteId");
            if (uniteId != null)
                uniteService.findByIdWithImmeuble(Long.parseLong(uniteId))
                            .ifPresent(un -> req.setAttribute("unite", un));
            req.getRequestDispatcher("/views/locataire/demande-form.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur u = (Utilisateur) req.getSession().getAttribute("utilisateur");
        DemandeLocation d = new DemandeLocation();
        d.setLocataire(u);
        d.setMessage(req.getParameter("message"));
        uniteService.findById(Long.parseLong(req.getParameter("uniteId")))
                    .ifPresent(d::setUnite);
        dao.save(d);
        resp.sendRedirect(req.getContextPath() + "/locataire/mes-demandes");
    }
}
