package com.gestionlocations.entities;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity @Table(name = "demandes_location")
public class DemandeLocation {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "locataire_id", nullable = false) private Utilisateur locataire;
    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "unite_id", nullable = false) private UniteLocation unite;
    @Enumerated(EnumType.STRING) private StatutDemande statut = StatutDemande.EN_ATTENTE;
    @Column(columnDefinition = "TEXT") private String message;
    @Column(columnDefinition = "TEXT") private String reponse;
    @Column(name = "date_demande") private LocalDateTime dateDemande = LocalDateTime.now();
    @Column(name = "date_reponse") private LocalDateTime dateReponse;
    public enum StatutDemande { EN_ATTENTE, ACCEPTEE, REFUSEE, ANNULEE }
    public Long getId() { return id; } public void setId(Long id) { this.id = id; }
    public Utilisateur getLocataire() { return locataire; } public void setLocataire(Utilisateur l) { this.locataire = l; }
    public UniteLocation getUnite() { return unite; } public void setUnite(UniteLocation u) { this.unite = u; }
    public StatutDemande getStatut() { return statut; } public void setStatut(StatutDemande s) { this.statut = s; }
    public String getMessage() { return message; } public void setMessage(String m) { this.message = m; }
    public String getReponse() { return reponse; } public void setReponse(String r) { this.reponse = r; }
    public LocalDateTime getDateDemande() { return dateDemande; } public void setDateDemande(LocalDateTime d) { this.dateDemande = d; }
    public LocalDateTime getDateReponse() { return dateReponse; } public void setDateReponse(LocalDateTime d) { this.dateReponse = d; }
}
