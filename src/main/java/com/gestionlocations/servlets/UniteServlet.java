package com.gestionlocations.servlets;

import com.gestionlocations.entities.*;
import com.gestionlocations.services.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/unites")
public class UniteServlet extends HttpServlet {
    private final UniteLocationService service = new UniteLocationService();
    private final ImmeubleService immeubleService = new ImmeubleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        req.setAttribute("immeubles", immeubleService.findActifs());

        if ("nouveau".equals(action)) {
            req.getRequestDispatcher("/views/admin/unite-form.jsp").forward(req, resp);
        } else if ("modifier".equals(action)) {
            service.findByIdWithImmeuble(Long.parseLong(req.getParameter("id")))
                   .ifPresent(u -> req.setAttribute("unite", u));
            req.getRequestDispatcher("/views/admin/unite-form.jsp").forward(req, resp);
        } else if ("supprimer".equals(action)) {
            service.supprimer(Long.parseLong(req.getParameter("id")));
            resp.sendRedirect(req.getContextPath() + "/admin/unites");
        } else {
            // findAll() avec JOIN FETCH immeuble — évite LazyInitializationException
            req.setAttribute("unites", service.findAll());
            req.getRequestDispatcher("/views/admin/unites-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String idStr = req.getParameter("id");
            UniteLocation u = (idStr != null && !idStr.isEmpty())
                ? service.findByIdWithImmeuble(Long.parseLong(idStr)).orElse(new UniteLocation())
                : new UniteLocation();
            u.setNumero(req.getParameter("numero"));
            u.setType(UniteLocation.TypeUnite.valueOf(req.getParameter("type")));
            u.setStatut(UniteLocation.StatutUnite.valueOf(req.getParameter("statut")));
            String np = req.getParameter("nombrePieces");
            if (np != null && !np.isEmpty()) u.setNombrePieces(Integer.parseInt(np));
            String sup = req.getParameter("superficie");
            if (sup != null && !sup.isEmpty()) u.setSuperficie(Double.parseDouble(sup));
            String et = req.getParameter("etage");
            if (et != null && !et.isEmpty()) u.setEtage(Integer.parseInt(et));
            u.setLoyerMensuel(new BigDecimal(req.getParameter("loyerMensuel")));
            String ch = req.getParameter("charges");
            if (ch != null && !ch.isEmpty()) u.setCharges(new BigDecimal(ch));
            String dep = req.getParameter("depot");
            if (dep != null && !dep.isEmpty()) u.setDepot(new BigDecimal(dep));
            u.setEquipements(req.getParameter("equipements"));
            u.setDescription(req.getParameter("description"));
            String immId = req.getParameter("immeubleId");
            if (immId != null && !immId.isEmpty())
                immeubleService.findById(Long.parseLong(immId)).ifPresent(u::setImmeuble);
            service.creer(u);
            resp.sendRedirect(req.getContextPath() + "/admin/unites");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("immeubles", immeubleService.findActifs());
            req.getRequestDispatcher("/views/admin/unite-form.jsp").forward(req, resp);
        }
    }
}
