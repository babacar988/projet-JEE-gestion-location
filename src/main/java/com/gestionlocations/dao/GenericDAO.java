package com.gestionlocations.dao;
import com.gestionlocations.utils.HibernateUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;
import java.util.Optional;

public abstract class GenericDAO<T, ID> {
    protected Class<T> entityClass;
    
    public GenericDAO(Class<T> entityClass) {
        this.entityClass = entityClass;
    }
    
    protected EntityManager getEM() {
        return HibernateUtil.getEntityManagerFactory().createEntityManager();
    }
    
    public T save(T entity) {
        EntityManager em = getEM();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            T saved = em.merge(entity);
            tx.commit();
            return saved;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally { em.close(); }
    }
    
    public void delete(ID id) {
        EntityManager em = getEM();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            T entity = em.find(entityClass, id);
            if (entity != null) em.remove(entity);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally { em.close(); }
    }
    
    public Optional<T> findById(ID id) {
        EntityManager em = getEM();
        try {
            return Optional.ofNullable(em.find(entityClass, id));
        } finally { em.close(); }
    }
    
    public List<T> findAll() {
        EntityManager em = getEM();
        try {
            return em.createQuery("FROM " + entityClass.getSimpleName(), entityClass).getResultList();
        } finally { em.close(); }
    }
}
