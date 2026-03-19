package com.gestionlocations.servlets;

import com.gestionlocations.entities.*;
import com.gestionlocations.services.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/locataire/dashboard")
public class LocataireDashboardServlet extends HttpServlet {
    private final ContratLocationService contratService  = new ContratLocationService();
    private final DemandeLocationService demandeService  = new DemandeLocationService();
    private final PaiementService        paiementService = new PaiementService();
    private final UniteLocationService   uniteService    = new UniteLocationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        Long uid = user.getId();

        // ── Contrats ──────────────────────────────────────────────────────
        long contratsActifs = 0;
        try {
            List<ContratLocation> contrats = contratService.findByLocataire(uid);
            contratsActifs = contrats.stream()
                .filter(c -> c.getStatut() == ContratLocation.StatutContrat.ACTIF)
                .count();
            // Contrat actif courant (pour la card récapitulative)
            contrats.stream()
                .filter(c -> c.getStatut() == ContratLocation.StatutContrat.ACTIF)
                .findFirst()
                .ifPresent(c -> req.setAttribute("contratActif", c));
        } catch (Exception e) {
            // log silencieux — on affiche 0
        }

        // ── Demandes ──────────────────────────────────────────────────────
        long demandesAttente = 0;
        try {
            demandesAttente = demandeService.findByLocataire(uid).stream()
                .filter(d -> d.getStatut() == DemandeLocation.StatutDemande.EN_ATTENTE)
                .count();
        } catch (Exception e) { }

        // ── Paiements en retard ───────────────────────────────────────────
        long paiementsRetard = 0;
        try {
            paiementsRetard = paiementService.findByLocataire(uid).stream()
                .filter(p -> p.getStatut() == Paiement.StatutPaiement.EN_RETARD)
                .count();
        } catch (Exception e) { }

        // ── Offres disponibles ────────────────────────────────────────────
        long offres = 0;
        try {
            offres = uniteService.countByStatut(UniteLocation.StatutUnite.DISPONIBLE);
        } catch (Exception e) { }

        req.setAttribute("contratsActifs",    contratsActifs);
        req.setAttribute("demandesEnAttente", demandesAttente);
        req.setAttribute("paiementsEnRetard", paiementsRetard);
        req.setAttribute("offresDisponibles", offres);

        req.getRequestDispatcher("/views/locataire/dashboard.jsp").forward(req, resp);
    }
}
