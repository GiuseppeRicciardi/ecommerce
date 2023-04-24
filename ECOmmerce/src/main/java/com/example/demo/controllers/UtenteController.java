package com.example.demo.controllers;

import com.example.demo.entities.Utente;
import com.example.demo.services.UtenteService;
import com.example.demo.support.ResponseMessage;
import com.example.demo.support.exceptions.MailInUso;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;


//controller per creare o recuperare utenti
@RestController
@RequestMapping("/utenti") //dov'è localizzata la risorsa sul server

public class UtenteController {

    @Autowired
    private UtenteService utenteService;

    @PostMapping("/registrazione")
    public ResponseEntity registrazione(@RequestBody @Valid Utente utente) {
        try{
            Utente registrato = utenteService.registraUtente(utente);
            return new ResponseEntity(registrato, HttpStatus.OK);
        }
        catch(MailInUso e){
            return new ResponseEntity<> (new ResponseMessage("ERRORE_MAIL_IN_USO"), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping
    public List<Utente> listaUtenti(){
        return utenteService.listaUtenti();
    }

    @RequestMapping("/trovaUtente")
    public List<Utente> trovaPerNome(@RequestBody String nome){
        return utenteService.findN(nome);

    }

    @GetMapping("/login")
    public ResponseEntity login(@RequestParam String mail, @RequestParam String password){
        if(utenteService.login(mail,password)){
            return new ResponseEntity(utenteService.findE(mail),HttpStatus.OK);
        }
        return new ResponseEntity<> (new ResponseMessage("ERRORE_CREDENZIALI_NON_CORRETTE"), HttpStatus.BAD_REQUEST);
    }

}
