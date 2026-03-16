package com.gestionlocations.dao;

import com.gestionlocations.entities.ContratLocation;
import com.gestionlocations.entities.ContratLocation.StatutContrat;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

public class ContratLocationDAO extends GenericDAO<ContratLocation, Long> {

    public ContratLocationDAO() { super(ContratLocation.class); }

    public List<ContratLocation> findAll() {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT c FROM ContratLocation c " +
                "JOIN FETCH c.locataire " +
                "JOIN FETCH c.unite u " +
                "JOIN FETCH u.immeuble " +
                "ORDER BY c.dateCreation DESC",
                ContratLocation.class
            ).getResultList();
        } finally { em.close(); }
    }

    public List<ContratLocation> findActifs() {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT c FROM ContratLocation c " +
                "JOIN FETCH c.locataire " +
                "JOIN FETCH c.unite u " +
                "JOIN FETCH u.immeuble " +
                "WHERE c.statut = :statut " +
                "ORDER BY c.dateCreation DESC",
                ContratLocation.class
            ).setParameter("statut", StatutContrat.ACTIF)
             .getResultList();
        } finally { em.close(); }
    }

    public List<ContratLocation> findByLocataire(Long locataireId) {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT c FROM ContratLocation c " +
                "JOIN FETCH c.locataire " +
                "JOIN FETCH c.unite u " +
                "JOIN FETCH u.immeuble " +
                "WHERE c.locataire.id = :lid ORDER BY c.dateCreation DESC",
                ContratLocation.class
            ).setParameter("lid", locataireId).getResultList();
        } finally { em.close(); }
    }

    public Optional<ContratLocation> findByIdWithDetails(Long id) {
        EntityManager em = getEM();
        try {
            List<ContratLocation> r = em.createQuery(
                "SELECT DISTINCT c FROM ContratLocation c " +
                "JOIN FETCH c.locataire " +
                "JOIN FETCH c.unite u " +
                "JOIN FETCH u.immeuble " +
                "LEFT JOIN FETCH c.paiements " +
                "WHERE c.id = :id",
                ContratLocation.class
            ).setParameter("id", id).getResultList();
            return r.isEmpty() ? Optional.empty() : Optional.of(r.get(0));
        } finally { em.close(); }
    }

    public long countActifs() {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT COUNT(c) FROM ContratLocation c WHERE c.statut = :statut",
                Long.class
            ).setParameter("statut", StatutContrat.ACTIF)
             .getSingleResult();
        } finally { em.close(); }
    }
}
