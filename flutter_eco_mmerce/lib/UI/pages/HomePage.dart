import 'package:flutter/material.dart';
import 'package:flutter_eco_mmerce/UI/pages/Login.dart';
import 'package:flutter_eco_mmerce/UI/widgets/SchedaProdotto.dart';
import 'package:flutter_eco_mmerce/UI/pages/ShoppingCart.dart';
import 'package:flutter_eco_mmerce/model/Model.dart';
import 'package:flutter_eco_mmerce/model/objects/Product.dart';
import 'package:flutter_eco_mmerce/model/objects/User.dart';
import 'package:flutter_eco_mmerce/model/support/Global.dart';
import '../widgets/InputField.dart';
import '../widgets/SquareButton.dart';

class HomePage extends StatefulWidget {

  final List<Product> carrello;

  final User loggedIn;
  const HomePage(this.loggedIn, this.carrello, {Key key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _searchFieldController = TextEditingController();

  List<Product> _products;
  List<Product> _carrello = [];
  List<Product> _searchedProducts;

  bool _isLoading = true;

  bool _neverSearched = true;

  @override
  void initState(){
    super.initState();

    getProducts();
  }

  Future<void> getProducts() async{
    _products = await Model.sharedInstance.showProducts();
    setState(() {
      _isLoading = false;
    });
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
            _return();
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              var snackBar = SnackBar(
                duration: Duration(milliseconds: 800),
                content: Text('Arrivederci ${loggedIn}'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              //print(loggedIn);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Login()),);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
             //print(loggedIn);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCart(widget.carrello, loggedIn)),).then((value) => setState(() {}));
            },
          ),
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
               Row(
                children: [
                  Flexible(
                    child: InputField(
                      labelText: "Cerca utilizzando il nome corretto",
                      controller: _searchFieldController,
                      onSubmit: (value) {
                        _search();
                      },
                    ),
                  ),
                  SquareButton(
                    text: "Trova",
                    onPressed: () {
                      _search();
                    },
                  ),
                ],
              ),

            _neverSearched ?
                _isLoading ?
            Center(child: CircularProgressIndicator()) :
            Expanded(
                child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  // vertical spacing between the items
                  mainAxisSpacing: 20,
                  // horizontal spacing between the items
                  crossAxisSpacing: 20,

                  childAspectRatio: 0.8,
                ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return SchedaProdotto(
                        product: _products[index],
                        onPressed: (){ _aggiungiAlCarrello(_products[index]);},
                      );
                    })
            ) :
             _searchedProducts != null ?
             Expanded(
                 child: GridView.builder(gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                     maxCrossAxisExtent: 300,
                     childAspectRatio: 0.8,
                     crossAxisSpacing: 20,
                     mainAxisSpacing: 20),
                     itemCount: _searchedProducts.length,
                     itemBuilder: (context, index) {
                       return SchedaProdotto(
                         product: _searchedProducts[index],
                         //list: _carrello,
                         onPressed: (){ _aggiungiAlCarrello(_searchedProducts[index]);},
                       );
                     })
             ):
              Text("Nessun prodotto corrispondente trovato")

          ],
        ),
      ),
    );
  }

  void _search() {
    setState(() {
      _searchedProducts = null;
    });
    Model.sharedInstance.searchProduct(_searchFieldController.text).then((result) {
      setState(() {
        _searchedProducts = result;
      });
    });
    _neverSearched = false;
  }

  void _return() {
    setState(() {
      _neverSearched = true;
      _searchedProducts = null;
    });
  }

 void _aggiungiAlCarrello(Product product) {
    if(!widget.carrello.contains(product)){
      if(product.quantita > 0){
        widget.carrello.add(product);
        var snackBar = SnackBar(
          duration: Duration(milliseconds: 800),
          content: Text('${product} aggiunto correttamente al carrello'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {

        });
      }
      else {
        var snackBar = SnackBar(
          duration: Duration(milliseconds: 800),
          backgroundColor: Colors.red,
          content: Text('${product} esaurito'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    print(widget.carrello);
    }
  }



}