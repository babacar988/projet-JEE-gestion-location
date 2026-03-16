package com.gestionlocations.servlets;
import com.gestionlocations.entities.*;
import com.gestionlocations.services.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

@WebServlet("/admin/paiements")
public class PaiementServlet extends HttpServlet {
    private final PaiementService service = new PaiementService();
    private final ContratLocationService contratService = new ContratLocationService();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("nouveau".equals(action)) {
            req.setAttribute("contrats", contratService.findActifs());
            req.getRequestDispatcher("/views/admin/paiement-form.jsp").forward(req, resp);
        } else {
            var paiements = service.findAll();
            req.setAttribute("paiements", paiements);
            req.setAttribute("totalPaye", service.getTotalPaye());
            req.setAttribute("nbEnAttente", paiements.stream().filter(p -> p.getStatut() == Paiement.StatutPaiement.EN_ATTENTE).count());
            req.setAttribute("nbEnRetard", service.findEnRetard().size());
            req.getRequestDispatcher("/views/admin/paiements-list.jsp").forward(req, resp);
        }
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Paiement p = new Paiement();
            p.setMontant(new BigDecimal(req.getParameter("montant")));
            p.setDateEcheance(LocalDate.parse(req.getParameter("dateEcheance")));
            String mode = req.getParameter("modePaiement");
            if (mode != null && !mode.isEmpty()) p.setModePaiement(Paiement.ModePaiement.valueOf(mode));
            p.setNotes(req.getParameter("notes"));
            contratService.findById(Long.parseLong(req.getParameter("contratId"))).ifPresent(p::setContrat);
            service.enregistrer(p);
            resp.sendRedirect(req.getContextPath() + "/admin/paiements");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("contrats", contratService.findActifs());
            req.getRequestDispatcher("/views/admin/paiement-form.jsp").forward(req, resp);
        }
    }
}
