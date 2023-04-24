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
@Table(name = "prodotto")

public class Prodotto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;

    @Basic
    @Column(name = "nome", nullable = false)
    private String nome;

    @Basic
    @Column(name = "prezzo", nullable = false)
    private float prezzo;

    @Basic
    @Column(name = "quantita", nullable = false)
    private int quantita;

    @Basic
    @Column(name = "descrizione")
    private String descrizione;

    @Basic
    @Column(name = "url")
    private String url;

    @Version //per i lock ottimistici
    @Column(name = "version", nullable = false)
    @JsonIgnore
    private long version;

    @OneToMany(targetEntity = ProdottoInAcquisto.class, mappedBy = "prodotto", cascade = CascadeType.MERGE)
    @JsonIgnore
    @ToString.Exclude
    private List<ProdottoInAcquisto> prodottiInAcquisto;


}
