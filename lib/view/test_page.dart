
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onDoubleTap: () {
            print('123');
          },
          behavior: HitTestBehavior.translucent,
          child: SizedBox(
            height: 300,
            width: 300,

            // color: Colors.transparent,
            // color: Colors.red,
            child: Center(
              child:GestureDetector(
                  onTap: (){
                    print('321');
                  },

                  child: Text("123")),
            ),
          ),
        ),
      ),
    );
  }
}
