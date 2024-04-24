import 'package:flutter_application_5/views/favorites.dart';
import 'package:flutter/material.dart';
import '../services/request_http.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List favorites = [];
  TextEditingController filterController = TextEditingController();

  void addFavorite(String code) {
    if (favorites.contains(code)) {
      setState(() => {favorites.remove(code)});
    } else {
      setState(() => {favorites.add(code)});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Cotação',
          style: TextStyle(color: Colors.yellow),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: filterController,
              decoration: InputDecoration(
                labelText: 'Filtrar',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (String filtro) async {
                setState(() => {});
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getCotacao(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  List<String> indexMoedas = snapshot.data.keys.toList();
                  List<String> moedasFiltradas = indexMoedas
                      .where((moeda) => moeda.contains(filterController.text))
                      .toList();
                  return ListView.builder(
                    itemCount: moedasFiltradas.length,
                    itemBuilder: (context, index) {
                      var moeda = snapshot.data[moedasFiltradas[index]];

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Card(
                                elevation: 10,
                                color: Colors.black,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 12),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            '${moeda['name']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.yellow),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            '${moeda['code']}-${moeda['codein']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.yellow),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            'Valor na baixa: R\$ ${moeda['low']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.yellow),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            'Valor na Alta: R\$ ${moeda['high']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.yellow),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            'Valor Atual: R\$ ${moeda['bid']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.yellow),
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        addFavorite(
                                            '${moeda['code']}-${moeda['codein']}');
                                      },
                                      child: Icon(
                                        favorites.contains(
                                                '${moeda['code']}-${moeda['codein']}')
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.yellow,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Favorites(
                        favorites: favorites,
                      )));
        },
        backgroundColor: Colors.yellow,
        child: Icon(
          Icons.star,
          color: Colors.black,
        ),
      ),
    );
  }
}
