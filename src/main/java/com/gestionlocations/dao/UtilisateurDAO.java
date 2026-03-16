package com.gestionlocations.dao;
import com.gestionlocations.entities.Utilisateur;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

public class UtilisateurDAO extends GenericDAO<Utilisateur, Long> {
    public UtilisateurDAO() { super(Utilisateur.class); }
    
    public Optional<Utilisateur> findByEmail(String email) {
        EntityManager em = getEM();
        try {
            return em.createQuery("FROM Utilisateur u WHERE u.email = :email", Utilisateur.class)
                .setParameter("email", email).getResultStream().findFirst();
        } finally { em.close(); }
    }
    
    public List<Utilisateur> findByRole(Utilisateur.RoleUtilisateur role) {
        EntityManager em = getEM();
        try {
            return em.createQuery("FROM Utilisateur u WHERE u.role = :role", Utilisateur.class)
                .setParameter("role", role).getResultList();
        } finally { em.close(); }
    }
    
    public long countByRole(Utilisateur.RoleUtilisateur role) {
        EntityManager em = getEM();
        try {
            return em.createQuery("SELECT COUNT(u) FROM Utilisateur u WHERE u.role = :role", Long.class)
                .setParameter("role", role).getSingleResult();
        } finally { em.close(); }
    }
}
