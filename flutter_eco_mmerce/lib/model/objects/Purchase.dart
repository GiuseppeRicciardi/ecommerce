import 'package:flutter_eco_mmerce/model/objects/ProductInPurchase.dart';
import 'package:flutter_eco_mmerce/model/objects/User.dart';

class Purchase {
  int id;
  double prezzototale;
  int idutente;
  int data;
  User acquirente;
  List<ProductInPurchase> prodottiInAcquisto;

  Purchase({this.id, this.prezzototale, this.idutente, this.data, this.acquirente, this.prodottiInAcquisto});

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
        id: json['id'],
        prezzototale: json['prezzo_totale'],
        idutente: json['id_utente'],
        data: json['data'],
        acquirente: User.fromJson(json["utente"]),
        prodottiInAcquisto: List<ProductInPurchase>.from(json["prodottiInAcquisto"].map((x) => ProductInPurchase.fromJson(x)))
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'prezzo_totale' : prezzototale,
    'id_utente' : idutente,
    'data' : data,
    'acquirente' : acquirente.toJson(),
    'prodottiInAcquisto' : List<dynamic>.from(prodottiInAcquisto.map((x) => x.toJson()))
  };

  @override
  String toString() {
    return id.toString();
  }

}