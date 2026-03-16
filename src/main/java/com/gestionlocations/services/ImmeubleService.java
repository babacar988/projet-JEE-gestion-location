package com.gestionlocations.services;

import com.gestionlocations.dao.ImmeubleDAO;
import com.gestionlocations.entities.Immeuble;
import com.gestionlocations.entities.Utilisateur;
import java.util.List;
import java.util.Optional;

public class ImmeubleService {
    private final ImmeubleDAO dao = new ImmeubleDAO();

    public Immeuble creer(Immeuble immeuble, Utilisateur proprietaire) {
        immeuble.setProprietaire(proprietaire);
        return dao.save(immeuble);
    }
    public Immeuble modifier(Immeuble immeuble) { return dao.save(immeuble); }
    public void supprimer(Long id) {
        dao.findById(id).ifPresent(i -> { i.setActif(false); dao.save(i); });
    }
    public Optional<Immeuble> findById(Long id)              { return dao.findById(id); }
    public Optional<Immeuble> findByIdWithUnites(Long id)   { return dao.findByIdWithUnites(id); }
    public List<Immeuble> findActifs()                        { return dao.findActifs(); }
    public List<Immeuble> findByProprietaire(Long propId)    { return dao.findByProprietaire(propId); }
    public long countActifs()                                 { return dao.countActifs(); }
}
