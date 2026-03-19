package com.gestionlocations.servlets;

import com.gestionlocations.entities.*;
import com.gestionlocations.services.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/proprietaire/dashboard")
public class ProprietaireDashboardServlet extends HttpServlet {
    private final ImmeubleService        immService      = new ImmeubleService();
    private final UniteLocationService   uniteService    = new UniteLocationService();
    private final ContratLocationService contratService  = new ContratLocationService();
    private final PaiementService        paiementService = new PaiementService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");

        // 1. Immeubles du propriétaire
        var immeubles = immService.findByProprietaire(user.getId());
        Set<Long> immIds = immeubles.stream().map(Immeuble::getId).collect(Collectors.toSet());

        // 2. Unités (déjà chargées via EAGER sur Immeuble.unites)
        List<UniteLocation> unites = immeubles.stream()
            .flatMap(i -> i.getUnites().stream())
            .collect(Collectors.toList());
        long occ   = unites.stream().filter(u -> u.getStatut() == UniteLocation.StatutUnite.OCCUPEE).count();
        long dispo = unites.stream().filter(u -> u.getStatut() == UniteLocation.StatutUnite.DISPONIBLE).count();

        // 3. Contrats — findByImmeubles : JOIN FETCH complet
        List<ContratLocation> contrats = contratService.findByImmeubles(immIds);
        long actifs = contrats.stream()
            .filter(c -> c.getStatut() == ContratLocation.StatutContrat.ACTIF).count();
        long nbLocataires = contrats.stream()
            .filter(c -> c.getStatut() == ContratLocation.StatutContrat.ACTIF)
            .map(c -> c.getLocataire().getId()).distinct().count();

        // 4. Paiements — findByImmeubles : JOIN FETCH complet
        List<Paiement> paiements = paiementService.findByImmeubles(immIds);
        BigDecimal totalPaye = paiements.stream()
            .filter(p -> p.getStatut() == Paiement.StatutPaiement.PAYE)
            .map(Paiement::getMontant).reduce(BigDecimal.ZERO, BigDecimal::add);
        long enRetard = paiements.stream()
            .filter(p -> p.getStatut() == Paiement.StatutPaiement.EN_RETARD).count();

        req.setAttribute("totalImmeubles",    (long) immeubles.size());
        req.setAttribute("totalUnites",       (long) unites.size());
        req.setAttribute("unitesOccupees",    occ);
        req.setAttribute("unitesDisponibles", dispo);
        req.setAttribute("contratsActifs",    actifs);
        req.setAttribute("totalLocataires",   nbLocataires);
        req.setAttribute("totalRevenu",       totalPaye);
        req.setAttribute("paiementsEnRetard", enRetard);

        req.getRequestDispatcher("/views/proprietaire/dashboard.jsp").forward(req, resp);
    }
}
