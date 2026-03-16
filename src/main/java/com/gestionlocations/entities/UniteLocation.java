package com.gestionlocations.entities;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity @Table(name = "unites_location")
public class UniteLocation {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Column(nullable = false) private String numero;
    private Integer nombrePieces;
    private Double superficie;
    @Column(precision = 10, scale = 2) private BigDecimal loyerMensuel;
    @Column(precision = 10, scale = 2) private BigDecimal charges;
    @Column(precision = 10, scale = 2) private BigDecimal depot;
    private Integer etage;
    @Enumerated(EnumType.STRING) private TypeUnite type = TypeUnite.APPARTEMENT;
    @Enumerated(EnumType.STRING) private StatutUnite statut = StatutUnite.DISPONIBLE;
    @Column(columnDefinition = "TEXT") private String description;
    private String equipements;
    private String photo;
    @Column(name = "date_creation") private LocalDateTime dateCreation = LocalDateTime.now();
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "immeuble_id", nullable = false) private Immeuble immeuble;
    @OneToMany(mappedBy = "unite", cascade = CascadeType.ALL, fetch = FetchType.LAZY) private List<ContratLocation> contrats = new ArrayList<>();
    public enum TypeUnite { STUDIO, APPARTEMENT, MAISON, BUREAU, COMMERCE, ENTREPOT }
    public enum StatutUnite { DISPONIBLE, OCCUPEE, EN_TRAVAUX, RESERVEE }
    public Long getId() { return id; } public void setId(Long id) { this.id = id; }
    public String getNumero() { return numero; } public void setNumero(String n) { this.numero = n; }
    public Integer getNombrePieces() { return nombrePieces; } public void setNombrePieces(Integer n) { this.nombrePieces = n; }
    public Double getSuperficie() { return superficie; } public void setSuperficie(Double s) { this.superficie = s; }
    public BigDecimal getLoyerMensuel() { return loyerMensuel; } public void setLoyerMensuel(BigDecimal l) { this.loyerMensuel = l; }
    public BigDecimal getCharges() { return charges; } public void setCharges(BigDecimal c) { this.charges = c; }
    public BigDecimal getDepot() { return depot; } public void setDepot(BigDecimal d) { this.depot = d; }
    public Integer getEtage() { return etage; } public void setEtage(Integer e) { this.etage = e; }
    public TypeUnite getType() { return type; } public void setType(TypeUnite t) { this.type = t; }
    public StatutUnite getStatut() { return statut; } public void setStatut(StatutUnite s) { this.statut = s; }
    public String getDescription() { return description; } public void setDescription(String d) { this.description = d; }
    public String getEquipements() { return equipements; } public void setEquipements(String e) { this.equipements = e; }
    public String getPhoto() { return photo; } public void setPhoto(String p) { this.photo = p; }
    public LocalDateTime getDateCreation() { return dateCreation; } public void setDateCreation(LocalDateTime d) { this.dateCreation = d; }
    public Immeuble getImmeuble() { return immeuble; } public void setImmeuble(Immeuble i) { this.immeuble = i; }
    public List<ContratLocation> getContrats() { return contrats; } public void setContrats(List<ContratLocation> c) { this.contrats = c; }
}
