package com.gestionlocations.dao;

import com.gestionlocations.entities.DemandeLocation;
import com.gestionlocations.entities.DemandeLocation.StatutDemande;
import jakarta.persistence.EntityManager;
import java.util.List;

public class DemandeLocationDAO extends GenericDAO<DemandeLocation, Long> {

    public DemandeLocationDAO() { super(DemandeLocation.class); }

    public List<DemandeLocation> findAll() {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT d FROM DemandeLocation d " +
                "JOIN FETCH d.locataire " +
                "JOIN FETCH d.unite u " +
                "JOIN FETCH u.immeuble " +
                "ORDER BY d.dateDemande DESC",
                DemandeLocation.class
            ).getResultList();
        } finally { em.close(); }
    }

    public List<DemandeLocation> findByLocataire(Long locataireId) {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT d FROM DemandeLocation d " +
                "JOIN FETCH d.locataire " +
                "JOIN FETCH d.unite u " +
                "JOIN FETCH u.immeuble " +
                "WHERE d.locataire.id = :lid ORDER BY d.dateDemande DESC",
                DemandeLocation.class
            ).setParameter("lid", locataireId).getResultList();
        } finally { em.close(); }
    }

    public List<DemandeLocation> findEnAttente() {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT d FROM DemandeLocation d " +
                "JOIN FETCH d.locataire " +
                "JOIN FETCH d.unite u " +
                "JOIN FETCH u.immeuble " +
                "WHERE d.statut = :statut ORDER BY d.dateDemande",
                DemandeLocation.class
            ).setParameter("statut", StatutDemande.EN_ATTENTE)
             .getResultList();
        } finally { em.close(); }
    }
}
