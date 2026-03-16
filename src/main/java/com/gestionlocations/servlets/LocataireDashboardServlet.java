package com.gestionlocations.servlets;
import com.gestionlocations.entities.*;
import com.gestionlocations.services.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/locataire/dashboard")
public class LocataireDashboardServlet extends HttpServlet {
    private final ContratLocationService contratService = new ContratLocationService();
    private final PaiementService paiementService = new PaiementService();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Utilisateur u = (Utilisateur) req.getSession().getAttribute("utilisateur");
        List<ContratLocation> contrats = contratService.findByLocataire(u.getId());
        long actifs = contrats.stream().filter(c -> c.getStatut() == ContratLocation.StatutContrat.ACTIF).count();
        req.setAttribute("contratsActifs", actifs);
        req.setAttribute("demandesEnCours", 0);
        req.setAttribute("paiementsEffectues", 0);
        req.setAttribute("paiementsEnAttente", 0);
        req.getRequestDispatcher("/views/locataire/dashboard.jsp").forward(req, resp);
    }
}
