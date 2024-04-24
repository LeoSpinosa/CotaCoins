import 'package:flutter/material.dart';
import '../services/request_http.dart';

class Favorites extends StatefulWidget {
  List favorites;
  Favorites({super.key, required this.favorites});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Favoritos',
            style: TextStyle(color: Colors.yellow),
          ),
        ),
        body: FutureBuilder(
          future: widget.favorites.length > 0
              ? getEspecifyCotacao(widget.favorites)
              : null,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              List<String> indexMoedas =
                  snapshot.data != null ? snapshot.data.keys.toList() : [];
              return ListView.builder(
                itemCount: indexMoedas.length,
                itemBuilder: (context, index) {
                  var moeda = snapshot.data[indexMoedas[index]];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 10,
                      color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '${moeda['name']}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.yellow),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '${moeda['code']}-${moeda['codein']}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.yellow),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Valor na baixa: R\$ ${moeda['low']}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.yellow),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Valor na alta: R\$ ${moeda['high']}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.yellow),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Valor Atual: R\$ ${moeda['bid']}',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.yellow),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
