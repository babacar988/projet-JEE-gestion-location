package com.gestionlocations.dao;

import com.gestionlocations.entities.ContratLocation;
import com.gestionlocations.entities.ContratLocation.StatutContrat;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;
import java.util.Set;

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
                "ORDER BY c.dateDebut DESC",
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
                "WHERE c.statut = :statut ORDER BY c.dateDebut DESC",
                ContratLocation.class
            ).setParameter("statut", StatutContrat.ACTIF).getResultList();
        } finally { em.close(); }
    }

    /** Contrats d'un locataire donné */
    public List<ContratLocation> findByLocataire(Long locataireId) {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT c FROM ContratLocation c " +
                "JOIN FETCH c.locataire l " +
                "JOIN FETCH c.unite u " +
                "JOIN FETCH u.immeuble " +
                "WHERE l.id = :lid ORDER BY c.dateDebut DESC",
                ContratLocation.class
            ).setParameter("lid", locataireId).getResultList();
        } finally { em.close(); }
    }

    /** Contrats filtrés par ensemble d'IDs d'immeubles (pour propriétaire) */
    public List<ContratLocation> findByImmeubles(Set<Long> immeubleIds) {
        if (immeubleIds == null || immeubleIds.isEmpty()) return List.of();
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT c FROM ContratLocation c " +
                "JOIN FETCH c.locataire " +
                "JOIN FETCH c.unite u " +
                "JOIN FETCH u.immeuble i " +
                "WHERE i.id IN :ids ORDER BY c.dateDebut DESC",
                ContratLocation.class
            ).setParameter("ids", immeubleIds).getResultList();
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
            ).setParameter("statut", StatutContrat.ACTIF).getSingleResult();
        } finally { em.close(); }
    }
}
