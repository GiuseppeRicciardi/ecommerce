package com.example.demo.services;

//NOTA ANDRÀ MODIFICATO DOPO AVER DEFINITO IL FRONTEND
import com.example.demo.entities.*;
import com.example.demo.repositories.AcquistoRepository;
import com.example.demo.repositories.ProdottoInAcquistoRepository;
import com.example.demo.repositories.UtenteRepository;
import com.example.demo.support.exceptions.QuantitaNonDisponibile;
import com.example.demo.support.exceptions.UtenteNonTrovato;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.Arrays;
import java.util.List;

@Service
public class AcquistoService {

    @Autowired
    private AcquistoRepository acquistoRepo;

    @Autowired
    private ProdottoInAcquistoRepository prodottoInAcquistoRepo;

    @Autowired
    private UtenteRepository utenteRepo;

    @Autowired
    private EntityManager entityManager;

    @Transactional(readOnly = false)
    public Acquisto aggiungiAcquisto(Acquisto acquisto) throws QuantitaNonDisponibile { //aggiunta di un acquisto
        Acquisto risultato_1 = acquistoRepo.save(acquisto);

        for(ProdottoInAcquisto p_1 : risultato_1.getProdottiInAcquisto()){
            p_1.setAcquisto(risultato_1);
            ProdottoInAcquisto aggiunta_1 = prodottoInAcquistoRepo.save(p_1);
            entityManager.refresh(aggiunta_1);
            Prodotto prodotto = aggiunta_1.getProdotto();
            int quantitaAggiornata_1 = prodotto.getQuantita() - p_1.getQuantita();
            if (quantitaAggiornata_1 < 0) {
                acquistoRepo.delete(acquisto);
                throw new QuantitaNonDisponibile();
            }
            prodotto.setQuantita(quantitaAggiornata_1);
            entityManager.refresh(p_1);
        }

        entityManager.refresh(risultato_1); //ripesca l'oggetto e l'aggiorna
        return risultato_1;

    }

    @Transactional(readOnly = true) //selezione tramite acquirente può essere aggiunto il rollback
    public List<Acquisto> acquistoPerAcquirente (Utente utente) throws UtenteNonTrovato {
        if ( !utenteRepo.existsById(utente.getId()) ) {
            throw new UtenteNonTrovato();
        }
        return acquistoRepo.findByAcquirente(utente);
    }

    @Transactional(readOnly = true) //restituisce tutti gli acquisti
    public List<Acquisto> listaAcquisti() {
        return acquistoRepo.findAll();
    }



}
