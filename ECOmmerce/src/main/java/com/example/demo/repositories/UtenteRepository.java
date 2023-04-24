package com.example.demo.repositories;

import com.example.demo.entities.Utente;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UtenteRepository extends JpaRepository<Utente, Integer> {

    List<Utente> findByNome(String nome);
    List<Utente> findByCognome(String cognome);
    Utente findByMail(String mail);

    boolean existsByMail(String mail);
    boolean existsByMailAndPassword(String mail, String password);


}
