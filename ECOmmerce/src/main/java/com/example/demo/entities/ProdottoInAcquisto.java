package com.example.demo.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import javax.persistence.*;

@Getter
@Setter
@EqualsAndHashCode
@ToString
@Entity
@Table(name = "prodottoinacquisto")

public class ProdottoInAcquisto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;

    @ManyToOne
    @JoinColumn(name = "acquistorelativo", nullable = true)
    @JsonIgnore
    @ToString.Exclude
    private Acquisto acquisto;

    @Basic
    @Column(name = "quantita", nullable = false)
    private int quantita;

    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "prodotto")
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Prodotto prodotto;

}
