package com.gestionlocations.dao;

import com.gestionlocations.entities.Paiement;
import com.gestionlocations.entities.Paiement.StatutPaiement;
import jakarta.persistence.EntityManager;
import java.math.BigDecimal;
import java.util.List;
import java.util.Set;

public class PaiementDAO extends GenericDAO<Paiement, Long> {

    public PaiementDAO() { super(Paiement.class); }

    public List<Paiement> findAll() {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT p FROM Paiement p " +
                "JOIN FETCH p.contrat c " +
                "JOIN FETCH c.locataire " +
                "JOIN FETCH c.unite u " +
                "JOIN FETCH u.immeuble " +
                "ORDER BY p.dateEcheance DESC",
                Paiement.class
            ).getResultList();
        } finally { em.close(); }
    }

    /** Paiements d'un locataire donné */
    public List<Paiement> findByLocataire(Long locataireId) {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT p FROM Paiement p " +
                "JOIN FETCH p.contrat c " +
                "JOIN FETCH c.locataire l " +
                "JOIN FETCH c.unite u " +
                "JOIN FETCH u.immeuble " +
                "WHERE l.id = :lid ORDER BY p.dateEcheance DESC",
                Paiement.class
            ).setParameter("lid", locataireId).getResultList();
        } finally { em.close(); }
    }

    /** Paiements filtrés par ensemble d'IDs d'immeubles (pour propriétaire) */
    public List<Paiement> findByImmeubles(Set<Long> immeubleIds) {
        if (immeubleIds == null || immeubleIds.isEmpty()) return List.of();
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT p FROM Paiement p " +
                "JOIN FETCH p.contrat c " +
                "JOIN FETCH c.locataire " +
                "JOIN FETCH c.unite u " +
                "JOIN FETCH u.immeuble i " +
                "WHERE i.id IN :ids ORDER BY p.dateEcheance DESC",
                Paiement.class
            ).setParameter("ids", immeubleIds).getResultList();
        } finally { em.close(); }
    }

    public List<Paiement> findByContrat(Long contratId) {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT p FROM Paiement p " +
                "JOIN FETCH p.contrat c " +
                "JOIN FETCH c.locataire " +
                "JOIN FETCH c.unite u " +
                "JOIN FETCH u.immeuble " +
                "WHERE p.contrat.id = :cid ORDER BY p.dateEcheance DESC",
                Paiement.class
            ).setParameter("cid", contratId).getResultList();
        } finally { em.close(); }
    }

    public List<Paiement> findEnRetard() {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT p FROM Paiement p " +
                "JOIN FETCH p.contrat c " +
                "JOIN FETCH c.locataire " +
                "JOIN FETCH c.unite u " +
                "JOIN FETCH u.immeuble " +
                "WHERE p.statut = :retard " +
                "OR (p.statut = :attente AND p.dateEcheance < CURRENT_DATE)",
                Paiement.class
            ).setParameter("retard",  StatutPaiement.EN_RETARD)
             .setParameter("attente", StatutPaiement.EN_ATTENTE)
             .getResultList();
        } finally { em.close(); }
    }

    public BigDecimal sumMontantPaye() {
        EntityManager em = getEM();
        try {
            BigDecimal r = em.createQuery(
                "SELECT SUM(p.montant) FROM Paiement p WHERE p.statut = :statut",
                BigDecimal.class
            ).setParameter("statut", StatutPaiement.PAYE).getSingleResult();
            return r != null ? r : BigDecimal.ZERO;
        } finally { em.close(); }
    }
}
