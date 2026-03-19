package com.gestionlocations.services;

import com.gestionlocations.dao.PaiementDAO;
import com.gestionlocations.entities.Paiement;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import java.util.Set;

public class PaiementService {
    private final PaiementDAO dao = new PaiementDAO();

    public Paiement creer(Paiement p)       { return dao.save(p); }
    public Paiement modifier(Paiement p)    { return dao.save(p); }

    /** Alias utilisé dans PaiementServlet */
    public Paiement enregistrer(Paiement p) { return dao.save(p); }

    public List<Paiement> findAll()         { return dao.findAll(); }
    public List<Paiement> findByLocataire(Long locataireId) { return dao.findByLocataire(locataireId); }
    public List<Paiement> findByImmeubles(Set<Long> ids)    { return dao.findByImmeubles(ids); }
    public List<Paiement> findByContrat(Long contratId)     { return dao.findByContrat(contratId); }
    public List<Paiement> findEnRetard()                    { return dao.findEnRetard(); }
    public Optional<Paiement> findById(Long id)             { return dao.findById(id); }

    /** Total encaissé — alias de sumMontantPaye() */
    public BigDecimal getTotalPaye()        { return dao.sumMontantPaye(); }
    public BigDecimal sumMontantPaye()      { return dao.sumMontantPaye(); }
}
