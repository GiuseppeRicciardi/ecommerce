class Product {
  int id;
  String nome;
  String descrizione;
  String url;
  double prezzo;
  int quantita;


  Product({this.id, this.nome, this.descrizione, this.url, this.prezzo, this.quantita});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nome: json['nome'],
      descrizione: json['descrizione'],
      url: json['url'],
      prezzo: json['prezzo'],
      quantita: json['quantita']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'descrizione': descrizione,
    'url': url,
    'prezzo' : prezzo,
    'quantita' : quantita
  };

  @override
  String toString() {
    return nome;
  }


}