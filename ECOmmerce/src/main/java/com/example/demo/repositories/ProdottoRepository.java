package com.example.demo.repositories;

import com.example.demo.entities.Prodotto;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface ProdottoRepository extends JpaRepository<Prodotto, Integer>{

    List<Prodotto> findByNome(String nome);

    boolean existsByNome(String nome);




}
