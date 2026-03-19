package com.gestionlocations.services;

import com.gestionlocations.dao.DemandeLocationDAO;
import com.gestionlocations.entities.DemandeLocation;
import java.util.List;
import java.util.Optional;

public class DemandeLocationService {
    private final DemandeLocationDAO dao = new DemandeLocationDAO();

    public DemandeLocation creer(DemandeLocation d) { return dao.save(d); }
    public DemandeLocation modifier(DemandeLocation d) { return dao.save(d); }
    public List<DemandeLocation> findAll() { return dao.findAll(); }
    public List<DemandeLocation> findByLocataire(Long id) { return dao.findByLocataire(id); }
    public List<DemandeLocation> findEnAttente() { return dao.findEnAttente(); }
    public Optional<DemandeLocation> findById(Long id) { return dao.findById(id); }
}
