package com.gestionlocations.servlets;

import com.gestionlocations.entities.*;
import com.gestionlocations.services.PaiementService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/locataire/mes-paiements")
public class LocatairePaiementsServlet extends HttpServlet {
    private final PaiementService service = new PaiementService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");

        // Utilise findByLocataire : JOIN FETCH complet, pas de LazyInit
        List<Paiement> paiements = service.findByLocataire(user.getId());

        req.setAttribute("paiements",   paiements);
        req.setAttribute("nbPayes",     paiements.stream().filter(p -> p.getStatut() == Paiement.StatutPaiement.PAYE).count());
        req.setAttribute("nbEnAttente", paiements.stream().filter(p -> p.getStatut() == Paiement.StatutPaiement.EN_ATTENTE).count());
        req.setAttribute("nbEnRetard",  paiements.stream().filter(p -> p.getStatut() == Paiement.StatutPaiement.EN_RETARD).count());
        req.getRequestDispatcher("/views/locataire/mes-paiements.jsp").forward(req, resp);
    }
}
