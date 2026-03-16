package com.gestionlocations.servlets;

import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.ImmeubleService;
import com.gestionlocations.services.UniteLocationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import com.gestionlocations.entities.UniteLocation;

@WebServlet("/proprietaire/unites")
public class ProprietaireUniteServlet extends HttpServlet {
    private final ImmeubleService    immService  = new ImmeubleService();
    private final UniteLocationService uniteService = new UniteLocationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");
        // Récupérer toutes les unités de tous les immeubles du propriétaire
        var immeubles = immService.findByProprietaire(user.getId());
        List<UniteLocation> unites = new ArrayList<>();
        for (var imm : immeubles) {
            unites.addAll(uniteService.findByImmeuble(imm.getId()));
        }
        req.setAttribute("immeubles", immeubles);
        req.setAttribute("unites", unites);
        req.getRequestDispatcher("/views/proprietaire/unites.jsp").forward(req, resp);
    }
}
