package com.example.demo.controllers;

import com.example.demo.entities.Acquisto;
import com.example.demo.entities.Utente;
import com.example.demo.support.exceptions.QuantitaNonDisponibile;
import com.example.demo.support.exceptions.UtenteNonTrovato;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.demo.services.AcquistoService;
import org.springframework.web.server.ResponseStatusException;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/acquisti")
public class AcquistoController {

    @Autowired
    private AcquistoService acquistoService;

    @PostMapping("/aggiungiacquisto")
    public ResponseEntity aggiungiAcquisto(@RequestBody Acquisto acquisto){
        try{
            return new ResponseEntity(acquistoService.aggiungiAcquisto(acquisto), HttpStatus.OK);
        } catch(QuantitaNonDisponibile e){
            return new ResponseEntity("QUANTITÀ_NON_DISPONIBILE",null, HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/ricerca/utente")
    public List<Acquisto> acquistiUtente(@RequestBody @Valid Utente utente) {
        try {
            return acquistoService.acquistoPerAcquirente(utente);
        } catch (UtenteNonTrovato e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Utente non trovato :(", e);
        }
    }

    @GetMapping
    public List<Acquisto> listaAcquisti(){
        return acquistoService.listaAcquisti();
    }


}
