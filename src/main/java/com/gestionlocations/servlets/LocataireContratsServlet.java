package com.gestionlocations.servlets;

import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.ContratLocationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/locataire/mes-contrats")
public class LocataireContratsServlet extends HttpServlet {
    private final ContratLocationService service = new ContratLocationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");
        req.setAttribute("contrats", service.findByLocataire(user.getId()));
        req.getRequestDispatcher("/views/locataire/mes-contrats.jsp").forward(req, resp);
    }
}
