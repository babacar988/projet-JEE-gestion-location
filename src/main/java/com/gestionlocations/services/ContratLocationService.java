package com.gestionlocations.services;

import com.gestionlocations.dao.ContratLocationDAO;
import com.gestionlocations.entities.ContratLocation;
import com.gestionlocations.entities.ContratLocation.StatutContrat;
import java.util.List;
import java.util.Optional;
import java.util.Set;

public class ContratLocationService {
    private final ContratLocationDAO dao = new ContratLocationDAO();

    public ContratLocation creer(ContratLocation c)    { return dao.save(c); }
    public ContratLocation modifier(ContratLocation c) { return dao.save(c); }

    /** Résilie un contrat (statut → RESILIE) */
    public void resilier(Long id) {
        dao.findById(id).ifPresent(c -> {
            c.setStatut(StatutContrat.RESILIE);
            dao.save(c);
        });
    }

    public List<ContratLocation> findAll()          { return dao.findAll(); }
    public List<ContratLocation> findActifs()        { return dao.findActifs(); }
    public List<ContratLocation> findByLocataire(Long locataireId) { return dao.findByLocataire(locataireId); }
    public List<ContratLocation> findByImmeubles(Set<Long> ids)    { return dao.findByImmeubles(ids); }
    public Optional<ContratLocation> findById(Long id)             { return dao.findById(id); }
    public Optional<ContratLocation> findByIdWithDetails(Long id)  { return dao.findByIdWithDetails(id); }
    public long countActifs()                                       { return dao.countActifs(); }
}
