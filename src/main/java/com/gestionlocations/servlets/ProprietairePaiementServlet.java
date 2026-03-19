package com.gestionlocations.servlets;

import com.gestionlocations.entities.*;
import com.gestionlocations.services.ImmeubleService;
import com.gestionlocations.services.PaiementService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@WebServlet("/proprietaire/paiements")
public class ProprietairePaiementServlet extends HttpServlet {
    private final PaiementService paiementService = new PaiementService();
    private final ImmeubleService immService       = new ImmeubleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");

        Set<Long> immIds = immService.findByProprietaire(user.getId())
                                     .stream().map(Immeuble::getId)
                                     .collect(Collectors.toSet());

        // JOIN FETCH complet — pas de LazyInit
        List<Paiement> paiements = paiementService.findByImmeubles(immIds);

        BigDecimal total = paiements.stream()
            .filter(p -> p.getStatut() == Paiement.StatutPaiement.PAYE)
            .map(Paiement::getMontant)
            .reduce(BigDecimal.ZERO, BigDecimal::add);

        req.setAttribute("paiements",   paiements);
        req.setAttribute("totalPaye",   total);
        req.setAttribute("nbEnAttente", paiements.stream().filter(p -> p.getStatut() == Paiement.StatutPaiement.EN_ATTENTE).count());
        req.setAttribute("nbEnRetard",  paiements.stream().filter(p -> p.getStatut() == Paiement.StatutPaiement.EN_RETARD).count());
        req.getRequestDispatcher("/views/proprietaire/paiements.jsp").forward(req, resp);
    }
}
