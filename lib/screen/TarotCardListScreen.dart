import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarot_ai/entities/TarotCard.dart';

class TarotCardListScreen extends StatefulWidget {
  const TarotCardListScreen({Key? key}) : super(key: key);

  @override
  _TarotCardListScreenState createState() => _TarotCardListScreenState();
}

class _TarotCardListScreenState extends State<TarotCardListScreen> {
  late Future<List<TarotCard>> _tarotCardsFuture;
  List<bool> _cardTapped = [];
  int _selectedCount = 0;

  @override
  void initState() {
    super.initState();
    _tarotCardsFuture = loadTarotCards();
  }

  Future<List<TarotCard>> loadTarotCards() async {
    String jsonString = await loadJsonData();
    List<dynamic> jsonList = json.decode(jsonString);
    List<TarotCard> tarotCards =
        jsonList.map((json) => TarotCard.fromJson(json)).toList();
    tarotCards.shuffle(); // Shuffle the list of cards
    _cardTapped = List.generate(tarotCards.length, (_) => false);
    return tarotCards;
  }

  Future<String> loadJsonData() async {
    return await rootBundle.loadString('assets/tarots.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarot Cards'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<TarotCard>>(
        future: _tarotCardsFuture,
        builder:
            (BuildContext context, AsyncSnapshot<List<TarotCard>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 5.0,
                  runSpacing: 5.0,
                  children: [
                    for (var i = 0; i < snapshot.data!.length; i++)
                      GestureDetector(
                        onTap: () {
                          if (_selectedCount < 5 && !_cardTapped[i]) {
                            setState(() {
                              _cardTapped[i] = true;
                              _selectedCount++;
                            });
                          }
                        },
                        child: _cardTapped[i]
                            ? Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                child: FlipCard(
                                  direction: FlipDirection.HORIZONTAL,
                                  flipOnTouch: true,
                                  front: buildFaceDownCard(),
                                  back: buildFaceUpCard(snapshot.data![i]),
                                ),
                              )
                            : buildFaceDownCard(),
                      ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }

  Widget buildFaceDownCard() {
    return Container(
      width: 120.0,
      height: 200.0,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Card Back',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildFaceUpCard(TarotCard card) {
    return Container(
      width: 120.0,
      height: 200.0,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            card.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            card.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
