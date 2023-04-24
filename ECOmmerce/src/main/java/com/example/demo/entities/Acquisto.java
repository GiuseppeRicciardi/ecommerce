package com.example.demo.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import javax.persistence.*;
import java.util.List;

@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
@Table(name = "acquisto")

public class Acquisto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;

    @Basic
    @Column(name = "prezzo_totale", nullable = false)
    private float prezzo_totale;

    @Basic
    @Column(name = "id_utente", nullable = true)
    private int id_utente;

    @Basic
    @Column(name = "data", nullable = true)
    private int data;


    @ManyToOne
    @JoinColumn(name = "acquirente", nullable = true)
    private Utente acquirente;

    @OneToMany(mappedBy = "acquisto", cascade = CascadeType.MERGE)
    private List<ProdottoInAcquisto> prodottiInAcquisto;





}
