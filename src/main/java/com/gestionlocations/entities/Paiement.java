package com.gestionlocations.entities;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity @Table(name = "paiements")
public class Paiement {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Column(unique = true, nullable = false) private String reference;
    @Column(precision = 10, scale = 2, nullable = false) private BigDecimal montant;
    @Column(name = "date_paiement") private LocalDate datePaiement;
    @Column(name = "date_echeance") private LocalDate dateEcheance;
    @Enumerated(EnumType.STRING) private StatutPaiement statut = StatutPaiement.EN_ATTENTE;
    @Enumerated(EnumType.STRING) @Column(name = "mode_paiement") private ModePaiement modePaiement;
    private String notes;
    @Column(name = "date_creation") private LocalDateTime dateCreation = LocalDateTime.now();
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "contrat_id", nullable = false) private ContratLocation contrat;
    public enum StatutPaiement { PAYE, EN_ATTENTE, EN_RETARD, ANNULE }
    public enum ModePaiement { VIREMENT, CHEQUE, ESPECES, PRELEVEMENT, CARTE }
    public Long getId() { return id; } public void setId(Long id) { this.id = id; }
    public String getReference() { return reference; } public void setReference(String r) { this.reference = r; }
    public BigDecimal getMontant() { return montant; } public void setMontant(BigDecimal m) { this.montant = m; }
    public LocalDate getDatePaiement() { return datePaiement; } public void setDatePaiement(LocalDate d) { this.datePaiement = d; }
    public LocalDate getDateEcheance() { return dateEcheance; } public void setDateEcheance(LocalDate d) { this.dateEcheance = d; }
    public StatutPaiement getStatut() { return statut; } public void setStatut(StatutPaiement s) { this.statut = s; }
    public ModePaiement getModePaiement() { return modePaiement; } public void setModePaiement(ModePaiement m) { this.modePaiement = m; }
    public String getNotes() { return notes; } public void setNotes(String n) { this.notes = n; }
    public LocalDateTime getDateCreation() { return dateCreation; } public void setDateCreation(LocalDateTime d) { this.dateCreation = d; }
    public ContratLocation getContrat() { return contrat; } public void setContrat(ContratLocation c) { this.contrat = c; }
}
