package com.gestionlocations.servlets;

import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.ImmeubleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/proprietaire/immeubles")
public class ProprietaireImmeubleServlet extends HttpServlet {

    private final ImmeubleService service = new ImmeubleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");
        req.setAttribute("immeubles", service.findByProprietaire(user.getId()));
        req.getRequestDispatcher("/views/proprietaire/immeubles-liste.jsp").forward(req, resp);
    }
}
