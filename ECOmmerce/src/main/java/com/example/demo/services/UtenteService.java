package com.example.demo.services;

import com.example.demo.repositories.UtenteRepository;
import com.example.demo.support.exceptions.MailInUso;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.demo.entities.Utente;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UtenteService {

    @Autowired
    private UtenteRepository utenteRepo;

    @Transactional(readOnly = false, propagation = Propagation.REQUIRED) //aggiunta di un utente nel database
    public Utente registraUtente(Utente utente) throws MailInUso {
        if(utenteRepo.existsByMail(utente.getMail())){
            throw new MailInUso();
        }
        return utenteRepo.save(utente);
    }

    @Transactional(readOnly = true) //restituzione di tutti gli utenti
    public List<Utente> listaUtenti(){
        return utenteRepo.findAll();
    }

    @Transactional(readOnly = true) //trova tramite mail
    public Utente findE(String mail) {
        return utenteRepo.findByMail(mail);
    }

    @Transactional(readOnly = true) //trova tramite nome
    public List<Utente> findN(String nome) {
        return utenteRepo.findByNome(nome);
    }

    @Transactional(readOnly = true) //trova tramite cognome
    public List<Utente> findC(String cognome) {
        return utenteRepo.findByCognome(cognome);
    }

    @Transactional(readOnly = true) //ricerca per dati di login
    public boolean login(String mail, String password) {

        return utenteRepo.existsByMailAndPassword(mail, password);
    }


}
