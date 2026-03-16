package com.gestionlocations.servlets;
import com.gestionlocations.entities.*;
import com.gestionlocations.services.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet("/admin/rapports")
public class RapportServlet extends HttpServlet {
    private final UtilisateurService utilisateurService = new UtilisateurService();
    private final ImmeubleService immeubleService = new ImmeubleService();
    private final UniteLocationService uniteService = new UniteLocationService();
    private final ContratLocationService contratService = new ContratLocationService();
    private final PaiementService paiementService = new PaiementService();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("totalImmeubles", immeubleService.countActifs());
        req.setAttribute("totalUnites", uniteService.findDisponibles().size() + uniteService.countByStatut(UniteLocation.StatutUnite.OCCUPEE));
        req.setAttribute("unitesDisponibles", uniteService.countByStatut(UniteLocation.StatutUnite.DISPONIBLE));
        req.setAttribute("unitesOccupees", uniteService.countByStatut(UniteLocation.StatutUnite.OCCUPEE));
        req.setAttribute("unitesTravaux", uniteService.countByStatut(UniteLocation.StatutUnite.EN_TRAVAUX));
        req.setAttribute("contratsActifs", contratService.countActifs());
        req.setAttribute("totalRevenu", paiementService.getTotalPaye());
        req.setAttribute("nbAdmins", utilisateurService.countByRole(Utilisateur.RoleUtilisateur.ADMIN));
        req.setAttribute("nbProprietaires", utilisateurService.countByRole(Utilisateur.RoleUtilisateur.PROPRIETAIRE));
        req.setAttribute("nbLocataires", utilisateurService.countByRole(Utilisateur.RoleUtilisateur.LOCATAIRE));
        var paiements = paiementService.findAll();
        req.setAttribute("nbPaiementsPayes", paiements.stream().filter(p -> p.getStatut() == com.gestionlocations.entities.Paiement.StatutPaiement.PAYE).count());
        req.setAttribute("nbPaiementsAttente", paiements.stream().filter(p -> p.getStatut() == com.gestionlocations.entities.Paiement.StatutPaiement.EN_ATTENTE).count());
        req.setAttribute("nbPaiementsRetard", paiementService.findEnRetard().size());
        long occ = uniteService.countByStatut(UniteLocation.StatutUnite.OCCUPEE);
        long tot = occ + uniteService.countByStatut(UniteLocation.StatutUnite.DISPONIBLE);
        req.setAttribute("tauxOccupation", tot > 0 ? (int)((occ * 100) / tot) : 0);
        req.getRequestDispatcher("/views/admin/rapports.jsp").forward(req, resp);
    }
}
