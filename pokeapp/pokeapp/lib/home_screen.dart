import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokeapp/pokemon_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokeApi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List pokedex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: -50,
          right: -50,
          child: Image.asset('images/pokeball.png', width: 200,fit: BoxFit.fitWidth),
          ),
          Positioned(
            top: 80,
            left: 20,
            child: Text("Pokédex", 
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),)
            ),
        Positioned(
          top: 150,
          bottom: 0,
          width: width,
          child: Column(
            children: [
              pokedex != null
                  ? Expanded(
                      child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4,
                      ),
                      itemCount: pokedex.length,
                      itemBuilder: (context, index) {
                        var type = pokedex[index]['type'][0];
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            child: Container(
                              decoration: BoxDecoration(      
                                color: type == 'Grass' ? Color.fromARGB(255, 99, 223, 163) : type == "Fire" ? Colors.redAccent : type == "Water" ? Color.fromARGB(255, 176, 198, 235) 
                                : type == "Electric" ? Color.fromARGB(255, 207, 207, 118) : type == "Rock" ? Colors.grey : type == "Ground" ? Colors.brown
                                : type == "Psycho" ? Colors.indigo : type == "Fighting" ? Colors.orange : type == "Bug" ? Color.fromARGB(255, 165, 209, 115) 
                                : type == "Ghost" ? Colors.purple : type == "Normal" ? Colors.grey: type == "Poison" ? Colors.deepPurpleAccent : Colors.pink,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Stack(children: [
                                Positioned(
                                    bottom: -10,
                                    right: -10,
                                    child: Image.asset(
                                      'images/pokeball.png',
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    )),
                                Positioned(
                                  top: 20,
                                  left: 20,
                                  child: Text(
                                    pokedex[index]['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                ),
                                Positioned(
                                  top: 45,
                                  left: 20,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                          top: 4,
                                          bottom: 4),
                                      child: Text(
                                        type.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                        color: Colors.black26),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: Hero(
                                    tag: index,
                                    child: CachedNetworkImage(
                                      imageUrl: pokedex[index]['img'],
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          onTap: (){
                            //TODO Navigate to new detail screen
                            Navigator.push(context, MaterialPageRoute(builder: (_) => PokemonDetailScreen(
                              pokemonDetail: pokedex[index],
                              color: type == 'Grass' ? Color.fromARGB(255, 99, 223, 163) : type == "Fire" ? Colors.redAccent : type == "Water" ? Color.fromARGB(255, 176, 198, 235) 
                                : type == "Electric" ? Color.fromARGB(255, 207, 207, 118) : type == "Rock" ? Colors.grey : type == "Ground" ? Colors.brown
                                : type == "Psycho" ? Colors.indigo : type == "Fighting" ? Colors.orange : type == "Bug" ? Color.fromARGB(255, 165, 209, 115) 
                                : type == "Ghost" ? Colors.purple : type == "Normal" ? Colors.grey: type == "Poison" ? Colors.deepPurpleAccent : Colors.pink,
                              heroTag: index,
                            )));
                          },
                        );
                      },
                    ))
                  : Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ),
        ),
      ],
    ));
  }

  void fetchPokemonData() {
    var url = Uri.https("raw.githubusercontent.com",
        "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      //print(value.body);
      //print(value.statusCode)

      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        pokedex = decodedJsonData['pokemon'];
        setState(() {});
      }
    });
  }
}
