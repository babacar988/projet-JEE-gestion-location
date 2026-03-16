package com.gestionlocations.dao;

import com.gestionlocations.entities.UniteLocation;
import com.gestionlocations.entities.UniteLocation.StatutUnite;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

public class UniteLocationDAO extends GenericDAO<UniteLocation, Long> {

    public UniteLocationDAO() { super(UniteLocation.class); }

    public List<UniteLocation> findAll() {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT u FROM UniteLocation u " +
                "JOIN FETCH u.immeuble i " +
                "LEFT JOIN FETCH i.proprietaire " +
                "ORDER BY i.nom, u.numero",
                UniteLocation.class
            ).getResultList();
        } finally { em.close(); }
    }

    public List<UniteLocation> findDisponibles() {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT DISTINCT u FROM UniteLocation u " +
                "JOIN FETCH u.immeuble i " +
                "LEFT JOIN FETCH i.proprietaire " +
                "WHERE u.statut = :statut " +
                "ORDER BY u.loyerMensuel",
                UniteLocation.class
            ).setParameter("statut", StatutUnite.DISPONIBLE)
             .getResultList();
        } finally { em.close(); }
    }

    public List<UniteLocation> findByImmeuble(Long immeubleId) {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT u FROM UniteLocation u " +
                "JOIN FETCH u.immeuble " +
                "WHERE u.immeuble.id = :iid ORDER BY u.numero",
                UniteLocation.class
            ).setParameter("iid", immeubleId).getResultList();
        } finally { em.close(); }
    }

    public Optional<UniteLocation> findByIdWithImmeuble(Long id) {
        EntityManager em = getEM();
        try {
            List<UniteLocation> r = em.createQuery(
                "SELECT u FROM UniteLocation u " +
                "JOIN FETCH u.immeuble " +
                "WHERE u.id = :id",
                UniteLocation.class
            ).setParameter("id", id).getResultList();
            return r.isEmpty() ? Optional.empty() : Optional.of(r.get(0));
        } finally { em.close(); }
    }

    public List<UniteLocation> findDisponiblesWithFilters(Double maxLoyer, Integer minPieces, String ville) {
        EntityManager em = getEM();
        try {
            StringBuilder jpql = new StringBuilder(
                "SELECT DISTINCT u FROM UniteLocation u " +
                "JOIN FETCH u.immeuble i " +
                "WHERE u.statut = :statut"
            );
            if (maxLoyer  != null) jpql.append(" AND u.loyerMensuel <= :maxLoyer");
            if (minPieces != null) jpql.append(" AND u.nombrePieces >= :minPieces");
            if (ville != null && !ville.isEmpty()) jpql.append(" AND LOWER(i.ville) LIKE :ville");
            jpql.append(" ORDER BY u.loyerMensuel");

            var query = em.createQuery(jpql.toString(), UniteLocation.class)
                          .setParameter("statut", StatutUnite.DISPONIBLE);
            if (maxLoyer  != null) query.setParameter("maxLoyer",  maxLoyer);
            if (minPieces != null) query.setParameter("minPieces", minPieces);
            if (ville != null && !ville.isEmpty()) query.setParameter("ville", "%" + ville.toLowerCase() + "%");
            return query.getResultList();
        } finally { em.close(); }
    }

    public long countByStatut(StatutUnite statut) {
        EntityManager em = getEM();
        try {
            return em.createQuery(
                "SELECT COUNT(u) FROM UniteLocation u WHERE u.statut = :statut",
                Long.class
            ).setParameter("statut", statut).getSingleResult();
        } finally { em.close(); }
    }
}
