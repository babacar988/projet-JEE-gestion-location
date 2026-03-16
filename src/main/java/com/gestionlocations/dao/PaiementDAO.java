package com.gestionlocations.dao;

import com.gestionlocations.entities.Paiement;
import com.gestionlocations.entities.Paiement.StatutPaiement;
import jakarta.persistence.EntityManager;
import java.math.BigDecimal;
import java.util.List;

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

    public List<Paiement> findByContrat(Long contratId) {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT p FROM Paiement p " +
                "JOIN FETCH p.contrat " +
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
            ).setParameter("statut", StatutPaiement.PAYE)
             .getSingleResult();
            return r != null ? r : BigDecimal.ZERO;
        } finally { em.close(); }
    }
}
