package com.gestionlocations.utils;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class HibernateUtil {
    private static final EntityManagerFactory emf;
    static {
        try {
            emf = Persistence.createEntityManagerFactory("gestionLocationsPU");
        } catch (Exception e) {
            throw new ExceptionInInitializerError(e);
        }
    }
    public static EntityManagerFactory getEntityManagerFactory() { return emf; }
    public static void shutdown() { if (emf != null) emf.close(); }
}
