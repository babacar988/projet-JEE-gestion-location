package com.gestionlocations.services;
import com.gestionlocations.dao.PaiementDAO;
import com.gestionlocations.entities.Paiement;
import com.gestionlocations.utils.ReferenceGenerator;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public class PaiementService {
    private final PaiementDAO dao = new PaiementDAO();
    
    public Paiement enregistrer(Paiement paiement) {
        paiement.setReference(ReferenceGenerator.generatePaiementRef());
        paiement.setStatut(Paiement.StatutPaiement.PAYE);
        paiement.setDatePaiement(LocalDate.now());
        return dao.save(paiement);
    }
    
    public List<Paiement> findByContrat(Long contratId) { return dao.findByContrat(contratId); }
    public List<Paiement> findEnRetard() { return dao.findEnRetard(); }
    public BigDecimal getTotalPaye() { return dao.sumMontantPaye(); }
    public Optional<Paiement> findById(Long id) { return dao.findById(id); }
    public List<Paiement> findAll() { return dao.findAll(); }
}
