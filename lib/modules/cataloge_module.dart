import 'package:flutter/material.dart';
import 'package:luna/pages/list_furnitures.dart';

class Cataloge_Module extends StatefulWidget {
  const Cataloge_Module({super.key});

  @override
  State<Cataloge_Module> createState() => _Cataloge_ModuleState();
}

class _Cataloge_ModuleState extends State<Cataloge_Module> {
  late String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.05,
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          InkWell(
            onTap: () {
              type = 'Кухня';
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListFurnituresPage(
                    type: type,
                  ),
                ),
              );
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff171717),
              ),
              child: Center(
                child: Text(
                  'Кухня',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xfff0f0f0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          InkWell(
            onTap: () {
              type = 'Гостиная';
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListFurnituresPage(
                    type: type,
                  ),
                ),
              );
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffff5d00),
              ),
              child: Center(
                child: Text(
                  'Гостиная',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          InkWell(
            onTap: () {
              type = 'Спальня';
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListFurnituresPage(
                    type: type,
                  ),
                ),
              );
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Спальня',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          InkWell(
            onTap: () {
              type = 'Ванная';
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListFurnituresPage(
                    type: type,
                  ),
                ),
              );
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff171717),
              ),
              child: Center(
                child: Text(
                  'Ванная',
                  style: TextStyle(
                    fontSize: 20,
                    color:  Color(0xfff0f0f0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          InkWell(
            onTap: () {
              type = 'Гардероб';
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListFurnituresPage(
                    type: type,
                  ),
                ),
              );
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffff5d00),
              ),
              child: Center(
                child: Text(
                  'Гардероб',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
