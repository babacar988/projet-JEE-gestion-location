package com.gestionlocations.entities;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "utilisateurs")
public class Utilisateur {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false, unique = true) private String email;
    @Column(nullable = false) private String motDePasse;
    @Column(nullable = false) private String nom;
    @Column(nullable = false) private String prenom;
    private String telephone;
    private String adresse;
    @Enumerated(EnumType.STRING) @Column(nullable = false)
    private RoleUtilisateur role;
    @Column(nullable = false) private boolean actif = true;
    @Column(name = "date_creation") private LocalDateTime dateCreation = LocalDateTime.now();
    @Column(name = "date_modification") private LocalDateTime dateModification;
    public enum RoleUtilisateur { ADMIN, PROPRIETAIRE, LOCATAIRE }
    public Long getId() { return id; } public void setId(Long id) { this.id = id; }
    public String getEmail() { return email; } public void setEmail(String e) { this.email = e; }
    public String getMotDePasse() { return motDePasse; } public void setMotDePasse(String m) { this.motDePasse = m; }
    public String getNom() { return nom; } public void setNom(String n) { this.nom = n; }
    public String getPrenom() { return prenom; } public void setPrenom(String p) { this.prenom = p; }
    public String getTelephone() { return telephone; } public void setTelephone(String t) { this.telephone = t; }
    public String getAdresse() { return adresse; } public void setAdresse(String a) { this.adresse = a; }
    public RoleUtilisateur getRole() { return role; } public void setRole(RoleUtilisateur r) { this.role = r; }
    public boolean isActif() { return actif; } public void setActif(boolean a) { this.actif = a; }
    public LocalDateTime getDateCreation() { return dateCreation; } public void setDateCreation(LocalDateTime d) { this.dateCreation = d; }
    public LocalDateTime getDateModification() { return dateModification; } public void setDateModification(LocalDateTime d) { this.dateModification = d; }
    public String getNomComplet() { return prenom + " " + nom; }
}
