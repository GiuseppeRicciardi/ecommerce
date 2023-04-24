package com.example.demo.repositories;

import com.example.demo.entities.Acquisto;
import com.example.demo.entities.Utente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AcquistoRepository extends JpaRepository<Acquisto, Integer> {

    List<Acquisto> findByAcquirente(Utente utente);
}
