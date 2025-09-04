import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  var currentplayer = "X";
  var winner = "";
  List<String> board = List.filled(9, '');
  void move(int index) {
    if (board[index] == "" && winner == "") {
      board.insert(index, currentplayer);
      if (checkwinner(currentplayer)) {
        winner = "$currentplayer is the winner!!";
      } else if (!board.contains("")) {
        winner = " its draw";
      } else {
        currentplayer == "X" ? "O" : "X";
      }
    }
  }

  bool checkwinner(String currentplayer) {
    List<List<int>> winning_possibilities = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (List pattern in winning_possibilities) {
      if (pattern[0] == currentplayer &&
          pattern[1] == currentplayer &&
          pattern[2] == currentplayer) {
        return true;
      }
    }
    return false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
          style: GoogleFonts.abel(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox( width: MediaQuery.of(context).size.width*0.7,
          height: MediaQuery.of(context).size.height*0.7,
            child: GridView.builder(
              padding: EdgeInsets.all(4),
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    board[index]=currentplayer;
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Text(currentplayer),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
