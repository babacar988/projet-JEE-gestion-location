package com.gestionlocations.servlets;

import com.gestionlocations.entities.UniteLocation;
import com.gestionlocations.services.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final ImmeubleService       immeubleService = new ImmeubleService();
    private final UniteLocationService  uniteService    = new UniteLocationService();
    private final ContratLocationService contratService = new ContratLocationService();
    private final PaiementService       paiementService = new PaiementService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try { req.setAttribute("totalImmeubles", immeubleService.countActifs()); }
        catch (Exception e) { req.setAttribute("totalImmeubles", 0L); }

        try {
            long dispo = uniteService.countByStatut(UniteLocation.StatutUnite.DISPONIBLE);
            long occ   = uniteService.countByStatut(UniteLocation.StatutUnite.OCCUPEE);
            req.setAttribute("totalUnites",      dispo + occ);
            req.setAttribute("unitesDisponibles", dispo);
            req.setAttribute("unitesOccupees",    occ);
        } catch (Exception e) {
            req.setAttribute("totalUnites", 0L);
            req.setAttribute("unitesDisponibles", 0L);
            req.setAttribute("unitesOccupees", 0L);
        }

        try { req.setAttribute("contratsActifs", contratService.countActifs()); }
        catch (Exception e) { req.setAttribute("contratsActifs", 0L); }

        try { req.setAttribute("paiementsEnRetard", (long) paiementService.findEnRetard().size()); }
        catch (Exception e) { req.setAttribute("paiementsEnRetard", 0L); }

        try {
            BigDecimal rev = paiementService.getTotalPaye();
            req.setAttribute("totalRevenu", rev != null ? rev : BigDecimal.ZERO);
        } catch (Exception e) { req.setAttribute("totalRevenu", BigDecimal.ZERO); }

        req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);
    }
}
