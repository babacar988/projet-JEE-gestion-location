package com.gestionlocations.entities;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "immeubles")
public class Immeuble {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String nom;

    @Column(nullable = false)
    private String adresse;

    private String ville;
    private String codePostal;
    private String pays = "France";

    @Column(columnDefinition = "TEXT")
    private String description;

    private Integer nombreEtages;
    private Integer anneeConstruction;

    @Enumerated(EnumType.STRING)
    private TypeImmeuble type = TypeImmeuble.RESIDENTIEL;

    private String equipements;
    private String photo;

    @Column(nullable = false)
    private boolean actif = true;

    @Column(name = "date_creation")
    private LocalDateTime dateCreation = LocalDateTime.now();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "proprietaire_id")
    private Utilisateur proprietaire;

    // ← EAGER : évite LazyInitializationException dans les JSP
    @OneToMany(mappedBy = "immeuble", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<UniteLocation> unites = new ArrayList<>();

    public enum TypeImmeuble { RESIDENTIEL, COMMERCIAL, MIXTE, INDUSTRIEL }

    // Getters / Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String n) { this.nom = n; }
    public String getAdresse() { return adresse; }
    public void setAdresse(String a) { this.adresse = a; }
    public String getVille() { return ville; }
    public void setVille(String v) { this.ville = v; }
    public String getCodePostal() { return codePostal; }
    public void setCodePostal(String c) { this.codePostal = c; }
    public String getPays() { return pays; }
    public void setPays(String p) { this.pays = p; }
    public String getDescription() { return description; }
    public void setDescription(String d) { this.description = d; }
    public Integer getNombreEtages() { return nombreEtages; }
    public void setNombreEtages(Integer n) { this.nombreEtages = n; }
    public Integer getAnneeConstruction() { return anneeConstruction; }
    public void setAnneeConstruction(Integer a) { this.anneeConstruction = a; }
    public TypeImmeuble getType() { return type; }
    public void setType(TypeImmeuble t) { this.type = t; }
    public String getEquipements() { return equipements; }
    public void setEquipements(String e) { this.equipements = e; }
    public String getPhoto() { return photo; }
    public void setPhoto(String p) { this.photo = p; }
    public boolean isActif() { return actif; }
    public void setActif(boolean a) { this.actif = a; }
    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime d) { this.dateCreation = d; }
    public Utilisateur getProprietaire() { return proprietaire; }
    public void setProprietaire(Utilisateur p) { this.proprietaire = p; }
    public List<UniteLocation> getUnites() { return unites; }
    public void setUnites(List<UniteLocation> u) { this.unites = u; }

    // Calcul dynamique — ne dépend plus de la liste lazy
    public int getNombreUnites() { return unites != null ? unites.size() : 0; }
}
