package com.gestionlocations.dao;

import com.gestionlocations.entities.Immeuble;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

public class ImmeubleDAO extends GenericDAO<Immeuble, Long> {

    public ImmeubleDAO() { super(Immeuble.class); }

    /** Charge immeubles + proprietaire + unites en une seule requête */
    public List<Immeuble> findActifs() {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT i FROM Immeuble i " +
                "LEFT JOIN FETCH i.proprietaire " +
                "LEFT JOIN FETCH i.unites " +
                "WHERE i.actif = true ORDER BY i.dateCreation DESC",
                Immeuble.class
            ).getResultList();
        } finally { em.close(); }
    }

    public List<Immeuble> findByProprietaire(Long proprietaireId) {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT i FROM Immeuble i " +
                "LEFT JOIN FETCH i.unites " +
                "WHERE i.proprietaire.id = :pid AND i.actif = true",
                Immeuble.class
            ).setParameter("pid", proprietaireId).getResultList();
        } finally { em.close(); }
    }

    /** Cherche un immeuble avec ses unités chargées */
    public Optional<Immeuble> findByIdWithUnites(Long id) {
        EntityManager em = getEM();
        try {
            List<Immeuble> result = em.createQuery(
                "SELECT DISTINCT i FROM Immeuble i " +
                "LEFT JOIN FETCH i.proprietaire " +
                "LEFT JOIN FETCH i.unites u " +
                "WHERE i.id = :id AND i.actif = true",
                Immeuble.class
            ).setParameter("id", id).getResultList();
            return result.isEmpty() ? Optional.empty() : Optional.of(result.get(0));
        } finally { em.close(); }
    }

    public long countActifs() {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT COUNT(i) FROM Immeuble i WHERE i.actif = true",
                Long.class
            ).getSingleResult();
        } finally { em.close(); }
    }
}
