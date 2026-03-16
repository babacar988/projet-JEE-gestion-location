package com.gestionlocations.services;
import com.gestionlocations.dao.ContratLocationDAO;
import com.gestionlocations.dao.UniteLocationDAO;
import com.gestionlocations.entities.ContratLocation;
import com.gestionlocations.entities.UniteLocation;
import com.gestionlocations.utils.ReferenceGenerator;
import java.util.List;
import java.util.Optional;

public class ContratLocationService {
    private final ContratLocationDAO dao = new ContratLocationDAO();
    private final UniteLocationDAO uniteDAO = new UniteLocationDAO();
    
    public ContratLocation creer(ContratLocation contrat) {
        contrat.setReference(ReferenceGenerator.generateContratRef());
        contrat.setStatut(ContratLocation.StatutContrat.ACTIF);
        UniteLocation unite = contrat.getUnite();
        unite.setStatut(UniteLocation.StatutUnite.OCCUPEE);
        uniteDAO.save(unite);
        return dao.save(contrat);
    }
    
    public ContratLocation modifier(ContratLocation contrat) { return dao.save(contrat); }
    
    public void resilier(Long id) {
        dao.findById(id).ifPresent(c -> {
            c.setStatut(ContratLocation.StatutContrat.RESILIE);
            c.getUnite().setStatut(UniteLocation.StatutUnite.DISPONIBLE);
            uniteDAO.save(c.getUnite());
            dao.save(c);
        });
    }
    
    public Optional<ContratLocation> findById(Long id) { return dao.findById(id); }
    public List<ContratLocation> findAll() { return dao.findAll(); }
    public List<ContratLocation> findActifs() { return dao.findActifs(); }
    public List<ContratLocation> findByLocataire(Long locataireId) { return dao.findByLocataire(locataireId); }
    public long countActifs() { return dao.countActifs(); }
}
