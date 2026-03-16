package com.gestionlocations.servlets;

import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.ImmeubleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/proprietaire/immeuble-detail")
public class ProprietaireImmeubleDetailServlet extends HttpServlet {
    private final ImmeubleService service = new ImmeubleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) { resp.sendRedirect(req.getContextPath() + "/proprietaire/immeubles"); return; }
        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");
        service.findByIdWithUnites(Long.parseLong(idStr)).ifPresentOrElse(
            imm -> {
                if (!imm.getProprietaire().getId().equals(user.getId())) {
                    try { resp.sendError(403); } catch (Exception ignored) {}
                    return;
                }
                req.setAttribute("immeuble", imm);
                try { req.getRequestDispatcher("/views/proprietaire/immeuble-detail.jsp").forward(req, resp); }
                catch (Exception e) { throw new RuntimeException(e); }
            },
            () -> { try { resp.sendRedirect(req.getContextPath() + "/proprietaire/immeubles"); } catch (Exception ignored) {} }
        );
    }
}
