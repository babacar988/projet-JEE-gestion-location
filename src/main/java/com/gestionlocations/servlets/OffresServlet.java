package com.gestionlocations.servlets;
import com.gestionlocations.services.UniteLocationService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet("/locataire/offres")
public class OffresServlet extends HttpServlet {
    private final UniteLocationService service = new UniteLocationService();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String maxLoyerStr = req.getParameter("maxLoyer");
        String minPiecesStr = req.getParameter("minPieces");
        String ville = req.getParameter("ville");
        Double maxLoyer = maxLoyerStr != null && !maxLoyerStr.isEmpty() ? Double.parseDouble(maxLoyerStr) : null;
        Integer minPieces = minPiecesStr != null && !minPiecesStr.isEmpty() ? Integer.parseInt(minPiecesStr) : null;
        req.setAttribute("unites", service.rechercherAvecFiltres(maxLoyer, minPieces, ville));
        req.getRequestDispatcher("/views/locataire/offres.jsp").forward(req, resp);
    }
}
