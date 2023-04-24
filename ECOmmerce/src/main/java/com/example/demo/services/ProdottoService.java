package com.example.demo.services;

import com.example.demo.support.exceptions.ProdottoEsistente;
import com.example.demo.repositories.ProdottoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.demo.entities.Prodotto;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProdottoService {

    @Autowired
    private ProdottoRepository prodottoRepo;

    @Transactional(readOnly = false, propagation = Propagation.REQUIRED) //aggiunta prodotto
    public Prodotto aggiungiProdotto(Prodotto prodotto) throws ProdottoEsistente {
        if (prodottoRepo.existsByNome(prodotto.getNome())) {
            throw new ProdottoEsistente();
        }
        return prodottoRepo.save(prodotto);
    }

    @Transactional(readOnly = true) //ricerca per nome
    public List<Prodotto> selezioneNome(String nome) {
        return prodottoRepo.findByNome(nome);
    }

    @Transactional(readOnly = true) //restituisce la lista di tutti i prodotti
    public List<Prodotto> listaProdotti() {
        return prodottoRepo.findAll();
    }


}
