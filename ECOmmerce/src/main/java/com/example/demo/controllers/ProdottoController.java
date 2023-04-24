package com.example.demo.controllers;

import com.example.demo.entities.Prodotto;
import com.example.demo.services.ProdottoService;
import com.example.demo.support.ResponseMessage;
import com.example.demo.support.exceptions.ProdottoEsistente;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/prodotti")
public class ProdottoController {

    @Autowired
    private ProdottoService prodottoService;

    @PostMapping("/aggiungiprodotto")
    public ResponseEntity aggiungiProdotto(@RequestBody Prodotto prodotto){
        try{
            Prodotto aggiunto = prodottoService.aggiungiProdotto(prodotto);
            return new ResponseEntity(aggiunto, HttpStatus.OK);
        } catch(ProdottoEsistente e){
            return new ResponseEntity("ERRORE_PRODOTTO_ESISTENTE",HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/ricerca/nome")
    public ResponseEntity getByName(@RequestParam(required = false) String nome) {
        List<Prodotto> result = prodottoService.selezioneNome(nome);
        if ( result.size() <= 0 ) {
            return new ResponseEntity<>(new ResponseMessage("Nessuna corrispondenza :("), HttpStatus.OK);
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping
    public List<Prodotto> listaProdotti(){
        return prodottoService.listaProdotti();
    }


}
