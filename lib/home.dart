import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var currentplayer = "X";
  var winner = "";
  bool dialogstate = true;
  var playername1 = "";
  var playername2 = "";
  var playerturn = "";
  List<String> board = List.filled(9, '');
  void move(int index) {
    if (board[index] == "" && winner == "") {
      board[index] = currentplayer;
      if (checkwinner(currentplayer)) {
        winner = "$currentplayer is the winner!!";
      } else if (!board.contains("")) {
        winner = " its draw";
      } else {
        currentplayer == "X" ? currentplayer = "O" : currentplayer = "X";
        playerturn == playername1
            ? playerturn = playername2
            : playerturn = playername1;
      }
    }
  }

  bool checkwinner(String currentplayer) {
    List<List<int>> winningpossibilities = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (List pattern in winningpossibilities) {
      if (board[pattern[0]] == currentplayer &&
          board[pattern[1]] == currentplayer &&
          board[pattern[2]] == currentplayer) {
        return true;
      }
    }
    return false;
  }

  TextEditingController player1 = TextEditingController();
  TextEditingController player2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Widget dialog = AlertDialog(
      title: Text("Player Registration"),
      actions: [
        Column(
          children: [
            TextField(
              autofocus: true,
              controller: player1,
              decoration: InputDecoration(
                label: Text("Enter  1st player name"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              autofocus: true,
              controller: player2,

              decoration: InputDecoration(
                label: Text("Enter  2st player name"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  dialogstate = false;
                  playername1 = player1.text;
                  playername2 = player2.text;
                  playerturn = playername1;
                });
              },
              child: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tic Tac Toe",
          style: GoogleFonts.abel(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  winner == ""
                      ? (playerturn == "" ? "Hi Gamers" : "$playerturn's turn")
                      : "the winner is $playerturn",
                  style: GoogleFonts.abel(
                    fontSize: 50,
                    color: Colors.amber[700],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
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
                            move(index);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Center(
                            child: Text(
                              board[index],
                              style: GoogleFonts.abel(
                                fontSize: 120,
                                color: Colors.amber[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(),
                ElevatedButton(
                  onPressed: () {
                     setState(() {
                      board = List.filled(9, "");
                      winner = "";
                      playerturn==playername1?playerturn=playername2:playerturn=playername1;

                    });
                  },
                  child: Text(
                    "Reset",
                    style: GoogleFonts.abel(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      board = List.filled(9, "");
                      winner = "";
                      dialogstate = true;
                      player1.clear();
                      player2.clear();
                    });
                  },
                  child: Text(
                    "Restart",
                    style: GoogleFonts.abel(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          dialogstate == true ? dialog : SizedBox.shrink(),
        ],
      ),
    );
  }
}
