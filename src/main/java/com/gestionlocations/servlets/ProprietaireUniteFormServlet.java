package com.gestionlocations.servlets;

import com.gestionlocations.entities.*;
import com.gestionlocations.services.ImmeubleService;
import com.gestionlocations.services.UniteLocationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/proprietaire/unite-form")
public class ProprietaireUniteFormServlet extends HttpServlet {

    private final UniteLocationService uniteService = new UniteLocationService();
    private final ImmeubleService      immService   = new ImmeubleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");

        // Pré-sélection immeuble si passé en paramètre
        String immIdStr = req.getParameter("immeubleId");

        // Édition ?
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isBlank()) {
            uniteService.findByIdWithImmeuble(Long.parseLong(idStr))
                        .ifPresent(u -> req.setAttribute("unite", u));
        }

        req.setAttribute("immeubles",    immService.findByProprietaire(user.getId()));
        req.setAttribute("preselImmeuble", immIdStr);
        req.getRequestDispatcher("/views/proprietaire/unite-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");

        try {
            String idStr = req.getParameter("id");
            UniteLocation unite = (idStr != null && !idStr.isBlank())
                ? uniteService.findByIdWithImmeuble(Long.parseLong(idStr)).orElse(new UniteLocation())
                : new UniteLocation();

            // Immeuble
            Long immId = Long.parseLong(req.getParameter("immeubleId"));
            Immeuble imm = immService.findById(immId).orElseThrow();
            // Vérification appartenance
            if (!imm.getProprietaire().getId().equals(user.getId())) {
                resp.sendError(403); return;
            }
            unite.setImmeuble(imm);

            // Champs
            unite.setNumero(req.getParameter("numero"));

            String type = req.getParameter("type");
            if (type != null && !type.isBlank())
                unite.setType(UniteLocation.TypeUnite.valueOf(type));

            String statut = req.getParameter("statut");
            if (statut != null && !statut.isBlank())
                unite.setStatut(UniteLocation.StatutUnite.valueOf(statut));

            String etage = req.getParameter("etage");
            if (etage != null && !etage.isBlank()) unite.setEtage(Integer.parseInt(etage));

            String pieces = req.getParameter("nombrePieces");
            if (pieces != null && !pieces.isBlank()) unite.setNombrePieces(Integer.parseInt(pieces));

            String surface = req.getParameter("superficie");
            if (surface != null && !surface.isBlank()) unite.setSuperficie(Double.parseDouble(surface));

            String loyer = req.getParameter("loyerMensuel");
            if (loyer != null && !loyer.isBlank()) unite.setLoyerMensuel(new BigDecimal(loyer));

            String charges = req.getParameter("charges");
            if (charges != null && !charges.isBlank()) unite.setCharges(new BigDecimal(charges));

            String depot = req.getParameter("depot");
            if (depot != null && !depot.isBlank()) unite.setDepot(new BigDecimal(depot));

            unite.setDescription(req.getParameter("description"));
            unite.setEquipements(req.getParameter("equipements"));

            if (idStr == null || idStr.isBlank()) uniteService.creer(unite);
            else                                   uniteService.modifier(unite);

            resp.sendRedirect(req.getContextPath() + "/proprietaire/unites");

        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("immeubles", immService.findByProprietaire(user.getId()));
            req.getRequestDispatcher("/views/proprietaire/unite-form.jsp").forward(req, resp);
        }
    }
}
