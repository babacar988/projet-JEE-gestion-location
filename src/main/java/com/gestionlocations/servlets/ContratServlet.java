package com.gestionlocations.servlets;
import com.gestionlocations.entities.*;
import com.gestionlocations.services.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

@WebServlet("/admin/contrats")
public class ContratServlet extends HttpServlet {
    private final ContratLocationService service = new ContratLocationService();
    private final UtilisateurService utilisateurService = new UtilisateurService();
    private final UniteLocationService uniteService = new UniteLocationService();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("nouveau".equals(action)) {
            req.setAttribute("locataires", utilisateurService.findByRole(Utilisateur.RoleUtilisateur.LOCATAIRE));
            req.setAttribute("unites", uniteService.findDisponibles());
            req.getRequestDispatcher("/views/admin/contrat-form.jsp").forward(req, resp);
        } else if ("modifier".equals(action)) {
            service.findById(Long.parseLong(req.getParameter("id"))).ifPresent(c -> req.setAttribute("contrat", c));
            req.setAttribute("locataires", utilisateurService.findByRole(Utilisateur.RoleUtilisateur.LOCATAIRE));
            req.setAttribute("unites", uniteService.findDisponibles());
            req.getRequestDispatcher("/views/admin/contrat-form.jsp").forward(req, resp);
        } else if ("resilier".equals(action)) {
            service.resilier(Long.parseLong(req.getParameter("id")));
            resp.sendRedirect(req.getContextPath() + "/admin/contrats");
        } else {
            var contrats = service.findAll();
            req.setAttribute("contrats", contrats);
            req.setAttribute("contratsActifs", contrats.stream().filter(c -> c.getStatut() == ContratLocation.StatutContrat.ACTIF).count());
            req.setAttribute("contratsEnAttente", contrats.stream().filter(c -> c.getStatut() == ContratLocation.StatutContrat.EN_ATTENTE).count());
            req.setAttribute("contratsResilies", contrats.stream().filter(c -> c.getStatut() == ContratLocation.StatutContrat.RESILIE).count());
            req.getRequestDispatcher("/views/admin/contrats-list.jsp").forward(req, resp);
        }
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idStr = req.getParameter("id");
            ContratLocation c = idStr != null && !idStr.isEmpty()
                ? service.findById(Long.parseLong(idStr)).orElse(new ContratLocation()) : new ContratLocation();
            c.setDateDebut(LocalDate.parse(req.getParameter("dateDebut")));
            String df = req.getParameter("dateFin"); if (df != null && !df.isEmpty()) c.setDateFin(LocalDate.parse(df));
            c.setLoyerMensuel(new BigDecimal(req.getParameter("loyerMensuel")));
            String ch = req.getParameter("chargesMensuelles"); if (ch != null && !ch.isEmpty()) c.setChargesMensuelles(new BigDecimal(ch));
            String dep = req.getParameter("depotGarantie"); if (dep != null && !dep.isEmpty()) c.setDepotGarantie(new BigDecimal(dep));
            c.setConditions(req.getParameter("conditions"));
            c.setStatut(ContratLocation.StatutContrat.valueOf(req.getParameter("statut")));
            utilisateurService.findById(Long.parseLong(req.getParameter("locataireId"))).ifPresent(c::setLocataire);
            uniteService.findById(Long.parseLong(req.getParameter("uniteId"))).ifPresent(c::setUnite);
            if (idStr == null || idStr.isEmpty()) service.creer(c); else service.modifier(c);
            resp.sendRedirect(req.getContextPath() + "/admin/contrats");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("locataires", utilisateurService.findByRole(Utilisateur.RoleUtilisateur.LOCATAIRE));
            req.setAttribute("unites", uniteService.findDisponibles());
            req.getRequestDispatcher("/views/admin/contrat-form.jsp").forward(req, resp);
        }
    }
}
