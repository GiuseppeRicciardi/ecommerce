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
@Table(name = "utente")

public class Utente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;

    @Basic
    @Column(name = "nome", nullable = false)
    private String nome;

    @Basic
    @Column(name = "cognome", nullable = false)
    private String cognome;

    @Basic
    @Column(name = "mail", nullable = false)
    private String mail;

    @Basic
    @Column(name = "password", nullable = false)
    private String password;

    @Basic
    @Column(name = "indirizzo", nullable = false)
    private String indirizzo;

    @Basic
    @Column(name = "telefono")
    private String telefono;

    @OneToMany(mappedBy = "acquirente", cascade = CascadeType.MERGE)
    @JsonIgnore
    private List<Acquisto> acquisti;


}
