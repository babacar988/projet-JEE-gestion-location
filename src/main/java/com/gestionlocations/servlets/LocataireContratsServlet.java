package com.gestionlocations.servlets;
import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet({"/locataire/mes-contrats", "/locataire/mes-paiements"})
public class LocataireContratsServlet extends HttpServlet {
    private final ContratLocationService contratService = new ContratLocationService();
    private final PaiementService paiementService = new PaiementService();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utilisateur u = (Utilisateur) req.getSession().getAttribute("utilisateur");
        String uri = req.getRequestURI();
        if (uri.contains("mes-paiements")) {
            var contrats = contratService.findByLocataire(u.getId());
            var paiements = new java.util.ArrayList<com.gestionlocations.entities.Paiement>();
            contrats.forEach(c -> paiements.addAll(paiementService.findByContrat(c.getId())));
            req.setAttribute("paiements", paiements);
            req.setAttribute("nbPayes", paiements.stream().filter(p -> p.getStatut() == com.gestionlocations.entities.Paiement.StatutPaiement.PAYE).count());
            req.setAttribute("nbEnAttente", paiements.stream().filter(p -> p.getStatut() == com.gestionlocations.entities.Paiement.StatutPaiement.EN_ATTENTE).count());
            req.setAttribute("nbEnRetard", paiements.stream().filter(p -> p.getStatut() == com.gestionlocations.entities.Paiement.StatutPaiement.EN_RETARD).count());
            req.getRequestDispatcher("/views/locataire/mes-paiements.jsp").forward(req, resp);
        } else {
            req.setAttribute("contrats", contratService.findByLocataire(u.getId()));
            req.getRequestDispatcher("/views/locataire/mes-contrats.jsp").forward(req, resp);
        }
    }
}
