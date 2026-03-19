package com.gestionlocations.services;

import com.gestionlocations.dao.UniteLocationDAO;
import com.gestionlocations.entities.UniteLocation;
import java.util.List;
import java.util.Optional;
import java.util.Set;

public class UniteLocationService {
    private final UniteLocationDAO dao = new UniteLocationDAO();

    public UniteLocation creer(UniteLocation u)    { return dao.save(u); }
    public UniteLocation modifier(UniteLocation u) { return dao.save(u); }
    public void supprimer(Long id)                 { dao.delete(id); }

    public List<UniteLocation> findAll()                       { return dao.findAll(); }
    public List<UniteLocation> findDisponibles()               { return dao.findDisponibles(); }
    public List<UniteLocation> findByImmeuble(Long immeubleId) { return dao.findByImmeuble(immeubleId); }
    public List<UniteLocation> findByProprietaire(Long propId) { return dao.findByProprietaire(propId); }
    public List<UniteLocation> findByImmeubles(Set<Long> ids)  { return dao.findByImmeubles(ids); }

    /** Alias utilisé dans OffresServlet */
    public List<UniteLocation> rechercherAvecFiltres(Double maxLoyer, Integer minPieces, String ville) {
        return dao.findDisponiblesWithFilters(maxLoyer, minPieces, ville);
    }

    public List<UniteLocation> findDisponiblesWithFilters(Double maxLoyer, Integer minPieces, String ville) {
        return dao.findDisponiblesWithFilters(maxLoyer, minPieces, ville);
    }

    public Optional<UniteLocation> findById(Long id)             { return dao.findById(id); }
    public Optional<UniteLocation> findByIdWithImmeuble(Long id) { return dao.findByIdWithImmeuble(id); }
    public long countByStatut(UniteLocation.StatutUnite statut)  { return dao.countByStatut(statut); }
}
