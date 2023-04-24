import 'package:flutter_eco_mmerce/model/objects/Product.dart';
import 'package:flutter_eco_mmerce/model/objects/Purchase.dart';

class ProductInPurchase {

  int id;
  int quantita;
  Product prodotto;
  Purchase acquistorelativo;

  ProductInPurchase({this.id, this.acquistorelativo, this.quantita, this.prodotto});

  factory ProductInPurchase.fromJson(Map<String, dynamic> json) {
    return ProductInPurchase(
        id: json['id'],
        acquistorelativo: json['acquistorelativo'],
        quantita: json['quantita'],
        prodotto: Product.fromJson(json['prodotto'])

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'acquistorelativo' : acquistorelativo,
    'quantita' : quantita,
    'prodotto' : prodotto.toJson()
  };

  @override
  String toString() {
    return '${id}';
  }

}