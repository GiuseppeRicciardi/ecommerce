package com.example.demo.repositories;

import com.example.demo.entities.ProdottoInAcquisto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProdottoInAcquistoRepository extends JpaRepository<ProdottoInAcquisto, Integer> {
}
