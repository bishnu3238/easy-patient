import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 35,
        titleSpacing: 0,
        title: TextField(
          cursorColor: Colors.black,
          decoration: const InputDecoration(
              hintText: "Search doctor, diseases etc ...",
              hintStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
              fillColor: Colors.white,
              filled: true,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              suffix: FaIcon(FontAwesomeIcons.microphone)),
          autofocus: true,
          onChanged: (searching) {},
          onSubmitted: (data){},
        ),
      ),
      body: Stack(children: [

      ],)
    );
  }
}
