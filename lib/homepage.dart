import 'package:flutter/material.dart';

import 'global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Text text = const Text("");

  @override
  void initState() {
    super.initState();
    box();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: const Icon(
          Icons.catching_pokemon,
          color: Colors.black,
          size: 40,
        ),
        title: Text(
          "${Global.score}/ 100",
          style: const TextStyle(
            fontSize: 40,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: (Global.pokemons.isEmpty)
          ? Center(
              child: box(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Expanded(
                    child: Column(
                      children: [
                        ...Global.pokemons
                            .map(
                              (e) => SizedBox(
                                height: 230,
                                width: 190,
                                child: Draggable(
                                  feedback: SizedBox(
                                    height: 230,
                                    width: 190,
                                    child: Image.asset(
                                      e['pokemon'],
                                      scale: 5,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  data: e['data'],
                                  childWhenDragging: Container(),
                                  child: SizedBox(
                                    height: 230,
                                    width: 190,
                                    child: Image.asset(
                                      e['pokemon'],
                                      scale: 5,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList()
                          ..shuffle(),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Expanded(
                    child: Column(
                      children: [
                        ...Global.pokemons
                            .map(
                              (e) => SizedBox(
                                height: 230,
                                width: 190,
                                child: DragTarget(
                                  builder: (context, accepted, rejected) {
                                    Global.isDrag = e['isDrag'];
                                    return SizedBox(
                                      height: 230,
                                      width: 190,
                                      child: Image.asset(
                                        e['pokemon'],
                                        color: Colors.grey,
                                        scale: 5,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                  onWillAccept: (data) {
                                    return data == e['data'];
                                  },
                                  onAccept: (data) {
                                    setState(
                                      () {
                                        if (e['isDrag'] == false) {
                                          Global.pokemons.remove(e);
                                        }

                                        if (data == e['data']) {
                                          Global.score = Global.score + 10;
                                        }
                                      },
                                    );
                                  },
                                  onLeave: (data) {
                                    setState(() {
                                      if (Global.score > 0) {
                                        Global.score = Global.score - 5;
                                      }
                                    });
                                  },
                                ),
                              ),
                            )
                            .toList()
                          ..shuffle(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  box() {
    return Container(
      alignment: Alignment.center,
      height: 330,
      width: 500,
      child: Dialog(
        child: Column(
          children: [
            const Text(
              "Game is Over",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.yellow,
                ),
                const Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.yellow,
                ),
                Icon(
                  (Global.score > 70) ? Icons.star : Icons.star_border,
                  size: 40,
                  color: Colors.yellow,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Level ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Total Score ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Best Score ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "1",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${Global.score}",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${Global.score}",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    // Navigator.of(context).pushReplacementNamed('/');

                    setState(() {
                      Global.pokemons = Global.pokeList;
                      Global.score = 0;
                    });
                  },
                  backgroundColor: Colors.yellow,
                  child: const Icon(
                    Icons.restart_alt,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
