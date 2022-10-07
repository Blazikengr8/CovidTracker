import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_wars/MazeLocation.dart';
import 'package:trivia_wars/utils/FloodFill.dart';
import 'utils/BFS.dart';

class Board extends StatefulWidget {
  Board({Key key}) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  FloodFill floodFill;

  List<MazeLocation> pathTiles = [];
  List<int> map = [1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 2];

  List<List<int>> map2D = [
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 1, 0, 0, 1],
    [1, 0, 0, 0, 1, 0, 0, 1],
    [1, 0, 0, 0, 1, 0, 0, 1],
    [1, 0, 0, 0, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 0, 0, 1],
    [1, 0, 0, 0, 1, 0, 0, 1],
    [1, 1, 1, 1, 1, 1, 1, 1]
  ];

  MazeLocation currentPos = MazeLocation(row: 0, col: 0);
  int currentPick = 0;
  void initState() {
    super.initState();

    print("init");
    floodFill = FloodFill(map, map2D);
  }

  int getNum(int index, int innerIndex) {
    int _index = index * 8 + innerIndex;
    return map[_index];
  }

  void getPath(MazeLocation endPath) {
    pathTiles.clear();
    List<MazeLocation> path = BFS().findPath(MazeLocation(row: 0, col: 0), MazeLocation(row: endPath.getRow(), col: endPath.getCol()));
    //pathTiles = path;
    setState(() {
      pathTiles = path;
    });
  }

  Color getColor(int index, int innerIndex) {
    var _index = index * 8 + innerIndex;
    Color color = Colors.white;

    if (index % 2 == 0) {
      color = _index % 2 == 0 ? Colors.purple : Colors.orange;
    } else {
      color = _index % 2 != 0 ? Colors.purple : Colors.orange;
    }
    if (_index == 63) {
      color = Colors.red;
    }
    if (_index == 0) {
      color = Colors.green;
    }

    // check if part of path
    MazeLocation result = pathTiles.firstWhere((element) {
      return (element.getRow() == index && element.getCol() == innerIndex);
    }, orElse: () => MazeLocation(row: -1, col: -1));
    if (result.getRow() != -1 && result.getCol() != -1) {
      color = Colors.green;
    }

    return color;
  }

  List<Widget> getBlocks(int index) {
    List<Widget> blockArr = [];
    for (var innerIndex = 0; innerIndex < 8; innerIndex++) {
      if (getNum(index, innerIndex) == 1 || getNum(index, innerIndex) == 2) {
        blockArr.add(Stack(
          key: UniqueKey(),
          alignment: AlignmentDirectional.center,
          fit: StackFit.loose,
          children: [
            GestureDetector(
                // When the child is tapped, show a snackbar.
                onTap: () {
                  getPath(MazeLocation(row: index, col: innerIndex));
                },
                child: Container(
                  //color: getColor(index, innerIndex),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: getColor(index, innerIndex),
                  ),
                  key: Key((index * innerIndex).toString()),
                  width: 40,
                  height: 40,
                ))
          ],
        ));
      } else {
        blockArr.add(Stack(
          key: UniqueKey(),
          alignment: AlignmentDirectional.center,
          fit: StackFit.loose,
          children: [
            Container(
              //color: Colors.transparent,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
              key: Key((index * innerIndex).toString()),
              width: 40,
              height: 40,
            )
          ],
        ));
      }
    }

    return blockArr;
  }

  List<Widget> getRows() {
    List<Widget> rowArr = [];
    for (var i = 0; i < 8; i++) {
      rowArr.add(Row(
        children: getBlocks(i),
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      ));
    }

    return rowArr;
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Container(
          color: Colors.white,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: getRows(),
              ),
              SizedBox(
                height: 50,
              ),
              //ElevatedButton(onPressed: () => {showStatePicker(context, viewportConstraints.maxWidth)}, child: Text("Pick a value"))
            ],
          )));
    });
  }
}
