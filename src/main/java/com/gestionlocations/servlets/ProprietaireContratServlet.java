package com.gestionlocations.servlets;

import com.gestionlocations.entities.*;
import com.gestionlocations.services.ContratLocationService;
import com.gestionlocations.services.ImmeubleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@WebServlet("/proprietaire/contrats")
public class ProprietaireContratServlet extends HttpServlet {
    private final ContratLocationService contratService = new ContratLocationService();
    private final ImmeubleService        immService     = new ImmeubleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");

        // Récupérer les IDs des immeubles du propriétaire
        Set<Long> immIds = immService.findByProprietaire(user.getId())
                                     .stream().map(Immeuble::getId)
                                     .collect(Collectors.toSet());

        // JOIN FETCH complet via findByImmeubles — pas de LazyInit
        List<ContratLocation> contrats = contratService.findByImmeubles(immIds);

        req.setAttribute("contrats",         contrats);
        req.setAttribute("contratsActifs",   contrats.stream().filter(c -> c.getStatut() == ContratLocation.StatutContrat.ACTIF).count());
        req.setAttribute("contratsEnAttente",contrats.stream().filter(c -> c.getStatut() == ContratLocation.StatutContrat.EN_ATTENTE).count());
        req.getRequestDispatcher("/views/proprietaire/contrats.jsp").forward(req, resp);
    }
}
