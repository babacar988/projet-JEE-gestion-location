package com.gestionlocations.servlets;

import com.gestionlocations.entities.*;
import com.gestionlocations.services.ImmeubleService;
import com.gestionlocations.services.UniteLocationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/proprietaire/unites")
public class ProprietaireUniteServlet extends HttpServlet {
    private final ImmeubleService      immService   = new ImmeubleService();
    private final UniteLocationService uniteService = new UniteLocationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");
        Long uid = user.getId();

        // Une seule requête JOIN FETCH — pas de boucle N+1
        req.setAttribute("unites",    uniteService.findByProprietaire(uid));
        req.setAttribute("immeubles", immService.findByProprietaire(uid));
        req.getRequestDispatcher("/views/proprietaire/unites.jsp").forward(req, resp);
    }
}
