import 'package:flutter/material.dart';
import 'package:flutter_eco_mmerce/UI/pages/HomePage.dart';
import 'package:flutter_eco_mmerce/UI/widgets/CartCard.dart';
import 'package:flutter_eco_mmerce/model/Model.dart';
import 'package:flutter_eco_mmerce/model/objects/Product.dart';
import 'package:flutter_eco_mmerce/model/objects/ProductInPurchase.dart';
import 'package:flutter_eco_mmerce/model/objects/Purchase.dart';
import 'package:flutter_eco_mmerce/model/objects/User.dart';
import 'package:flutter_eco_mmerce/model/support/Global.dart';


class ShoppingCart extends StatefulWidget {
  final List<Product> carrello;
  final User loggedIn;
  const ShoppingCart(this.carrello, this.loggedIn, {Key key}) : super(key: key);


  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  final scaffoldKey = GlobalKey<ScaffoldState>();


  bool _purchasing = false;
  Purchase _justAddedPurchase;

  List<int> _listaQ = [];
  bool _isLoading = true;


  @override
  void initState(){
    super.initState();

    _generaQ();
  }




    @override
    Widget build(BuildContext context) {
      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFFD6D6D6),
          automaticallyImplyLeading: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(loggedIn, widget.carrello),
                ),
              );
            }, // Image tapped
            child: Image.asset(
              'img/logo4.png',
              fit: BoxFit.cover, // Fixes border issues
              width: 110.0,
              height: 110.0,
            ),
          ),
          title: Text(
            'Feel your ART beating',
            style: TextStyle(
              color: Color(0xFFF5F5F5),
            ),
          ),
          centerTitle: true,
          elevation: 4,
        ),
        backgroundColor: Color(0xFFF5F5F5),
        body: Container(
          width: MediaQuery
              .of(context).size.width,
          height: MediaQuery
              .of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [

              (widget.carrello == null || widget.carrello.length == 0) ? Expanded(child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text( "Il carrello è vuoto",
                          style: TextStyle(
                              fontSize: 20),
                ),
              )
              ) :
              Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: widget.carrello.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CartCard(
                          product: widget.carrello[index],
                          quantity: _listaQ[index],
                          onPressed1: (){ _increment(index);},
                          onPressed2: (){ _decrement(index);},
                        );
                      }
                  )
              ),

              BottomAppBar(
                child: ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    Text('Totale: ${totale()}€'),

                    TextButton(
                      child: Text("Prosegui con l'acquisto"),
                      onPressed: () {
                        _purchase();
                      },
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      );
    }

    double totale() {
    double tot = 0;
    for(int i = 0; i < widget.carrello.length; i++){
      tot += widget.carrello[i].prezzo * _listaQ[i];
    }
    return tot;

    }

  void _purchase() {

    setState(() {
      _purchasing = true;
      _justAddedPurchase = null;
    });

    List<ProductInPurchase> prodotti = [];



    Purchase purchase = Purchase(
        prezzototale: totale(),
        idutente: 0,
        data: 0,
        acquirente: loggedIn,
        prodottiInAcquisto: prodotti
    );

    for(int i = 0; i < widget.carrello.length; i++){
      ProductInPurchase p = ProductInPurchase(
          quantita: _listaQ[i],
          prodotto: widget.carrello[i]
      );
      prodotti.add(p);
      setState(() {

      });

    }

    Model.sharedInstance.addPurchase(purchase).then((result) async {
      setState(() {
        _purchasing = false;
        _justAddedPurchase = result;
      });

      print(_justAddedPurchase);

      //if(_justAddedPurchase != null){
      var snackBar = SnackBar(
        duration: Duration(milliseconds: 800),
        content: Text('Acquisto registrato correttamente'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(widget.loggedIn, []),
        ),
      );
    //}

      /*else{
      var snackBar = SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(milliseconds: 800),
      content: Text('Quantità non disponibile'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }*/


    });
  }

  void _increment(int i) {
    //if (_listaQ[i] < widget.carrello[i].quantita) {
      _listaQ[i] ++;
      setState(() {

      });
      print(_listaQ);
    //}
  }

  void _decrement(int i) {
      if(_listaQ[i] != 1) {
        _listaQ[i] --;
        setState(() {

        });
        print(_listaQ);
      }
      else{
        widget.carrello.removeAt(i);
        _listaQ.removeAt(i);
        var snackBar = SnackBar(
          duration: Duration(milliseconds: 800),
          content: Text('Prodotto eliminato dal carrello'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {

        });
        print(widget.carrello);
        print(_listaQ);
      }
    }

    void _generaQ(){
      for(int i = 0; i < widget.carrello.length; i++){
        _listaQ.add(1);
      }
      print(_listaQ);
    }


}

