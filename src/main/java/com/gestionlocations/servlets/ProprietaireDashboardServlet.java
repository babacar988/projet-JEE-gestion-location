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

        var immeubles = immService.findByProprietaire(user.getId());
        Set<Long> immIds = immeubles.stream().map(Immeuble::getId).collect(Collectors.toSet());

        // Unités
        List<UniteLocation> unites = new ArrayList<>();
        for (var imm : immeubles) unites.addAll(uniteService.findByImmeuble(imm.getId()));
        long occ  = unites.stream().filter(u -> u.getStatut() == UniteLocation.StatutUnite.OCCUPEE).count();
        long dispo = unites.stream().filter(u -> u.getStatut() == UniteLocation.StatutUnite.DISPONIBLE).count();

        // Contrats
        var contrats = contratService.findAll().stream()
            .filter(c -> immIds.contains(c.getUnite().getImmeuble().getId()))
            .collect(Collectors.toList());
        long actifs = contrats.stream().filter(c -> c.getStatut() == ContratLocation.StatutContrat.ACTIF).count();

        // Locataires uniques
        long nbLocataires = contrats.stream()
            .filter(c -> c.getStatut() == ContratLocation.StatutContrat.ACTIF)
            .map(c -> c.getLocataire().getId()).distinct().count();

        // Paiements
        var paiements = paiementService.findAll().stream()
            .filter(p -> immIds.contains(p.getContrat().getUnite().getImmeuble().getId()))
            .collect(Collectors.toList());
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
