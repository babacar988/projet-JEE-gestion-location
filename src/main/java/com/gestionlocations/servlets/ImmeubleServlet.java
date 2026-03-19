package com.gestionlocations.servlets;

import com.gestionlocations.entities.*;
import com.gestionlocations.services.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;

@WebServlet("/admin/immeubles")
public class ImmeubleServlet extends HttpServlet {
    private final ImmeubleService    service              = new ImmeubleService();
    private final UtilisateurService utilisateurService   = new UtilisateurService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("nouveau".equals(action)) {
                req.setAttribute("proprietaires",
                    utilisateurService.findByRole(Utilisateur.RoleUtilisateur.PROPRIETAIRE));
                req.getRequestDispatcher("/views/admin/immeuble-form.jsp").forward(req, resp);

            } else if ("modifier".equals(action)) {
                Long id = Long.parseLong(req.getParameter("id"));
                service.findById(id).ifPresent(i -> req.setAttribute("immeuble", i));
                req.setAttribute("proprietaires",
                    utilisateurService.findByRole(Utilisateur.RoleUtilisateur.PROPRIETAIRE));
                req.getRequestDispatcher("/views/admin/immeuble-form.jsp").forward(req, resp);

            } else if ("supprimer".equals(action)) {
                service.supprimer(Long.parseLong(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/admin/immeubles");

            } else {
                req.setAttribute("immeubles", service.findActifs());
                req.getRequestDispatcher("/views/admin/immeubles-list.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Erreur : " + e.getMessage());
            req.setAttribute("immeubles", java.util.Collections.emptyList());
            req.getRequestDispatcher("/views/admin/immeubles-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String idStr = req.getParameter("id");
            Immeuble immeuble = (idStr != null && !idStr.isEmpty())
                ? service.findById(Long.parseLong(idStr)).orElse(new Immeuble())
                : new Immeuble();

            immeuble.setNom(req.getParameter("nom"));
            immeuble.setAdresse(req.getParameter("adresse"));
            immeuble.setVille(req.getParameter("ville"));
            immeuble.setCodePostal(req.getParameter("codePostal"));
            immeuble.setDescription(req.getParameter("description"));
            immeuble.setEquipements(req.getParameter("equipements"));

            String etages = req.getParameter("nombreEtages");
            if (etages != null && !etages.isEmpty())
                immeuble.setNombreEtages(Integer.parseInt(etages));

            String annee = req.getParameter("anneeConstruction");
            if (annee != null && !annee.isEmpty())
                immeuble.setAnneeConstruction(Integer.parseInt(annee));

            String typeStr = req.getParameter("type");
            if (typeStr != null && !typeStr.isEmpty())
                immeuble.setType(Immeuble.TypeImmeuble.valueOf(typeStr));

            String propId = req.getParameter("proprietaireId");
            Utilisateur proprietaire = null;
            if (propId != null && !propId.isEmpty())
                proprietaire = utilisateurService.findById(Long.parseLong(propId)).orElse(null);

            if (proprietaire == null)
                proprietaire = (Utilisateur) req.getSession().getAttribute("utilisateur");

            service.creer(immeuble, proprietaire);
            resp.sendRedirect(req.getContextPath() + "/admin/immeubles");

        } catch (Exception e) {
            req.setAttribute("error", "Erreur lors de la sauvegarde : " + e.getMessage());
            req.setAttribute("proprietaires",
                utilisateurService.findByRole(Utilisateur.RoleUtilisateur.PROPRIETAIRE));
            req.getRequestDispatcher("/views/admin/immeuble-form.jsp").forward(req, resp);
        }
    }
}
