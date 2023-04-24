class User {
  int id;
  String nome;
  String cognome;
  String telefono;
  String mail;
  String indirizzo;
  String password;


  User({this.id, this.nome, this.cognome, this.telefono, this.mail, this.indirizzo, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nome: json['nome'],
      cognome: json['cognome'],
      telefono: json['telefono'],
      mail: json['mail'],
      indirizzo: json['indirizzo'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'cognome': cognome,
    'telefono': telefono,
    'mail': mail,
    'indirizzo': indirizzo,
    'password' : password,
  };

  @override
  String toString() {
    return nome + " " + cognome;
  }


}