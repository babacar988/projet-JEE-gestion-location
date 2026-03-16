package com.gestionlocations.services;

import com.gestionlocations.dao.UniteLocationDAO;
import com.gestionlocations.entities.UniteLocation;
import java.util.List;
import java.util.Optional;

public class UniteLocationService {
    private final UniteLocationDAO dao = new UniteLocationDAO();

    public UniteLocation creer(UniteLocation unite) { return dao.save(unite); }
    public UniteLocation modifier(UniteLocation unite) { return dao.save(unite); }
    public void supprimer(Long id) { dao.delete(id); }

    public Optional<UniteLocation> findById(Long id) { return dao.findById(id); }
    public Optional<UniteLocation> findByIdWithImmeuble(Long id) { return dao.findByIdWithImmeuble(id); }

    /** Toutes les unités avec immeuble chargé — utilisé dans les listes admin */
    public List<UniteLocation> findAll() { return dao.findAll(); }
    public List<UniteLocation> findDisponibles() { return dao.findDisponibles(); }
    public List<UniteLocation> findByImmeuble(Long immeubleId) { return dao.findByImmeuble(immeubleId); }
    public List<UniteLocation> rechercherAvecFiltres(Double maxLoyer, Integer minPieces, String ville) {
        return dao.findDisponiblesWithFilters(maxLoyer, minPieces, ville);
    }
    public long countByStatut(UniteLocation.StatutUnite statut) { return dao.countByStatut(statut); }
}
