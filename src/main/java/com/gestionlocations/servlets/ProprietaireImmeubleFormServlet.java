package com.gestionlocations.servlets;

import com.gestionlocations.entities.Immeuble;
import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.ImmeubleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/proprietaire/immeuble-form")
public class ProprietaireImmeubleFormServlet extends HttpServlet {
    private final ImmeubleService service = new ImmeubleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            service.findById(Long.parseLong(idStr)).ifPresent(i -> req.setAttribute("immeuble", i));
        }
        req.getRequestDispatcher("/views/proprietaire/immeuble-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");
        try {
            String idStr = req.getParameter("id");
            Immeuble imm = (idStr != null && !idStr.isEmpty())
                ? service.findById(Long.parseLong(idStr)).orElse(new Immeuble())
                : new Immeuble();
            imm.setNom(req.getParameter("nom"));
            imm.setAdresse(req.getParameter("adresse"));
            imm.setVille(req.getParameter("ville"));
            imm.setCodePostal(req.getParameter("codePostal"));
            imm.setPays(req.getParameter("pays") != null ? req.getParameter("pays") : "France");
            imm.setDescription(req.getParameter("description"));
            imm.setEquipements(req.getParameter("equipements"));
            String ne = req.getParameter("nombreEtages");
            if (ne != null && !ne.isEmpty()) imm.setNombreEtages(Integer.parseInt(ne));
            String ac = req.getParameter("anneeConstruction");
            if (ac != null && !ac.isEmpty()) imm.setAnneeConstruction(Integer.parseInt(ac));
            String type = req.getParameter("type");
            if (type != null) imm.setType(Immeuble.TypeImmeuble.valueOf(type));
            imm.setActif(true);
            if (idStr == null || idStr.isEmpty()) {
                service.creer(imm, user);
            } else {
                service.modifier(imm);
            }
            resp.sendRedirect(req.getContextPath() + "/proprietaire/immeubles");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/views/proprietaire/immeuble-form.jsp").forward(req, resp);
        }
    }
}
