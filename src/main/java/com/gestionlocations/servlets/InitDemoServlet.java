package com.gestionlocations.servlets;

import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.services.UtilisateurService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet d'initialisation des données de démo.
 * URL : http://localhost:8080/gestion-locations/init-demo
 * À UTILISER UNE SEULE FOIS puis supprimer ou sécuriser.
 */
@WebServlet("/init-demo")
public class InitDemoServlet extends HttpServlet {

    private final UtilisateurService service = new UtilisateurService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        out.println("<!DOCTYPE html><html><head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>Initialisation ImmoGest</title>");
        out.println("<style>body{font-family:Arial,sans-serif;max-width:600px;margin:40px auto;padding:20px;}");
        out.println(".ok{color:#2D7A4F;background:#E6F4EC;padding:10px;border-radius:6px;margin:8px 0;}");
        out.println(".err{color:#C0392B;background:#FDE8E6;padding:10px;border-radius:6px;margin:8px 0;}");
        out.println(".info{color:#1A6B9A;background:#E3F2FA;padding:12px;border-radius:6px;margin:16px 0;}");
        out.println("h1{color:#0F1B2D;}h2{color:#C9A84C;}</style></head><body>");
        out.println("<h1>🏢 ImmoGest — Initialisation des données de démo</h1>");

        StringBuilder log = new StringBuilder();
        int created = 0;
        int skipped = 0;

        // Compte 1 : Admin
        try {
            service.inscrire(
                "admin@immogest.fr",
                "admin123",
                "Administrateur", "Super",
                "01 00 00 00 00",
                Utilisateur.RoleUtilisateur.ADMIN
            );
            log.append("<div class='ok'>✅ Admin créé : admin@immogest.fr / admin123</div>");
            created++;
        } catch (Exception e) {
            log.append("<div class='err'>⚠️ Admin : " + e.getMessage() + " (peut-être déjà existant)</div>");
            skipped++;
        }

        // Compte 2 : Propriétaire
        try {
            service.inscrire(
                "proprio@immogest.fr",
                "proprio123",
                "Dupont", "Pierre",
                "06 10 20 30 40",
                Utilisateur.RoleUtilisateur.PROPRIETAIRE
            );
            log.append("<div class='ok'>✅ Propriétaire créé : proprio@immogest.fr / proprio123</div>");
            created++;
        } catch (Exception e) {
            log.append("<div class='err'>⚠️ Propriétaire : " + e.getMessage() + " (peut-être déjà existant)</div>");
            skipped++;
        }

        // Compte 3 : Locataire
        try {
            service.inscrire(
                "locataire@immogest.fr",
                "locataire123",
                "Martin", "Sophie",
                "06 50 60 70 80",
                Utilisateur.RoleUtilisateur.LOCATAIRE
            );
            log.append("<div class='ok'>✅ Locataire créé : locataire@immogest.fr / locataire123</div>");
            created++;
        } catch (Exception e) {
            log.append("<div class='err'>⚠️ Locataire : " + e.getMessage() + " (peut-être déjà existant)</div>");
            skipped++;
        }

        out.println("<h2>Résultat</h2>");
        out.println(log.toString());
        out.println("<div class='info'>");
        out.println("<strong>" + created + " compte(s) créé(s)</strong>, " + skipped + " ignoré(s).");
        out.println("</div>");

        if (created > 0) {
            out.println("<h2>🔑 Comptes disponibles</h2>");
            out.println("<table border='1' cellpadding='8' style='border-collapse:collapse;width:100%'>");
            out.println("<tr style='background:#0F1B2D;color:white'><th>Rôle</th><th>Email</th><th>Mot de passe</th></tr>");
            out.println("<tr><td>👔 Admin</td><td>admin@immogest.fr</td><td>admin123</td></tr>");
            out.println("<tr><td>🏗️ Propriétaire</td><td>proprio@immogest.fr</td><td>proprio123</td></tr>");
            out.println("<tr><td>🏠 Locataire</td><td>locataire@immogest.fr</td><td>locataire123</td></tr>");
            out.println("</table>");
        }

        out.println("<br><a href='" + req.getContextPath() + "/login' ");
        out.println("style='background:#C9A84C;color:#0F1B2D;padding:12px 24px;");
        out.println("text-decoration:none;border-radius:6px;font-weight:bold;display:inline-block;margin-top:16px'>");
        out.println("→ Aller à la page de connexion</a>");

        out.println("<p style='color:#aaa;font-size:12px;margin-top:32px'>⚠️ Pensez à supprimer ou sécuriser ");
        out.println("ce servlet (InitDemoServlet.java) en production.</p>");
        out.println("</body></html>");
    }
}
