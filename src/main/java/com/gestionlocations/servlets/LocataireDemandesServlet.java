//package com.gestionlocations.servlets;
//
//import com.gestionlocations.entities.Utilisateur;
//import com.gestionlocations.services.DemandeLocationService;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//
//@WebServlet("/locataire/mes-demandes")
//public class LocataireDemandesServlet extends HttpServlet {
//    private final DemandeLocationService service = new DemandeLocationService();
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//        Utilisateur user = (Utilisateur) req.getSession().getAttribute("utilisateur");
//        req.setAttribute("demandes", service.findByLocataire(user.getId()));
//        req.getRequestDispatcher("/views/locataire/mes-demandes.jsp").forward(req, resp);
//    }
//}
