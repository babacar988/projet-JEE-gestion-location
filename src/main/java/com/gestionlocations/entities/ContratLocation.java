package com.gestionlocations.entities;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity @Table(name = "contrats_location")
public class ContratLocation {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Column(unique = true, nullable = false) private String reference;
    @Column(name = "date_debut", nullable = false) private LocalDate dateDebut;
    @Column(name = "date_fin") private LocalDate dateFin;
    @Column(name = "loyer_mensuel", precision = 10, scale = 2, nullable = false) private BigDecimal loyerMensuel;
    @Column(name = "charges_mensuelles", precision = 10, scale = 2) private BigDecimal chargesMensuelles;
    @Column(name = "depot_garantie", precision = 10, scale = 2) private BigDecimal depotGarantie;
    @Enumerated(EnumType.STRING) private StatutContrat statut = StatutContrat.ACTIF;
    @Column(columnDefinition = "TEXT") private String conditions;
    @Column(name = "date_creation") private LocalDateTime dateCreation = LocalDateTime.now();
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "unite_id", nullable = false) private UniteLocation unite;
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "locataire_id", nullable = false) private Utilisateur locataire;
    @OneToMany(mappedBy = "contrat", cascade = CascadeType.ALL, fetch = FetchType.LAZY) private List<Paiement> paiements = new ArrayList<>();
    public enum StatutContrat { ACTIF, TERMINE, RESILIE, EN_ATTENTE }
    public Long getId() { return id; } public void setId(Long id) { this.id = id; }
    public String getReference() { return reference; } public void setReference(String r) { this.reference = r; }
    public LocalDate getDateDebut() { return dateDebut; } public void setDateDebut(LocalDate d) { this.dateDebut = d; }
    public LocalDate getDateFin() { return dateFin; } public void setDateFin(LocalDate d) { this.dateFin = d; }
    public BigDecimal getLoyerMensuel() { return loyerMensuel; } public void setLoyerMensuel(BigDecimal l) { this.loyerMensuel = l; }
    public BigDecimal getChargesMensuelles() { return chargesMensuelles; } public void setChargesMensuelles(BigDecimal c) { this.chargesMensuelles = c; }
    public BigDecimal getDepotGarantie() { return depotGarantie; } public void setDepotGarantie(BigDecimal d) { this.depotGarantie = d; }
    public StatutContrat getStatut() { return statut; } public void setStatut(StatutContrat s) { this.statut = s; }
    public String getConditions() { return conditions; } public void setConditions(String c) { this.conditions = c; }
    public LocalDateTime getDateCreation() { return dateCreation; } public void setDateCreation(LocalDateTime d) { this.dateCreation = d; }
    public UniteLocation getUnite() { return unite; } public void setUnite(UniteLocation u) { this.unite = u; }
    public Utilisateur getLocataire() { return locataire; } public void setLocataire(Utilisateur l) { this.locataire = l; }
    public List<Paiement> getPaiements() { return paiements; } public void setPaiements(List<Paiement> p) { this.paiements = p; }
}
