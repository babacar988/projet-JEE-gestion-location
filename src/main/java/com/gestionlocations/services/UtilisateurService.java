package com.gestionlocations.services;
import com.gestionlocations.dao.UtilisateurDAO;
import com.gestionlocations.entities.Utilisateur;
import com.gestionlocations.utils.PasswordUtil;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class UtilisateurService {
    private final UtilisateurDAO dao = new UtilisateurDAO();
    
    public Utilisateur inscrire(String email, String motDePasse, String nom, String prenom,
                                 String telephone, Utilisateur.RoleUtilisateur role) {
        if (dao.findByEmail(email).isPresent()) throw new RuntimeException("Email déjà utilisé");
        Utilisateur u = new Utilisateur();
        u.setEmail(email);
        u.setMotDePasse(PasswordUtil.hashPassword(motDePasse));
        u.setNom(nom); u.setPrenom(prenom);
        u.setTelephone(telephone); u.setRole(role);
        return dao.save(u);
    }
    
    public Optional<Utilisateur> authentifier(String email, String motDePasse) {
        return dao.findByEmail(email)
            .filter(u -> u.isActif() && PasswordUtil.checkPassword(motDePasse, u.getMotDePasse()));
    }
    
    public Utilisateur modifier(Utilisateur u) {
        u.setDateModification(LocalDateTime.now());
        return dao.save(u);
    }
    
    public void desactiver(Long id) {
        dao.findById(id).ifPresent(u -> { u.setActif(false); dao.save(u); });
    }
    
    public Optional<Utilisateur> findById(Long id) { return dao.findById(id); }
    public List<Utilisateur> findAll() { return dao.findAll(); }
    public List<Utilisateur> findByRole(Utilisateur.RoleUtilisateur role) { return dao.findByRole(role); }
    public long countByRole(Utilisateur.RoleUtilisateur role) { return dao.countByRole(role); }
}
