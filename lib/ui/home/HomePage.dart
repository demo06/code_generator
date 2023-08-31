import 'package:code_generator/ui/home/ActivityPage.dart';
import 'package:code_generator/ui/home/AdapterPage.dart';
import 'package:code_generator/ui/home/DialogPage.dart';
import 'package:code_generator/ui/home/FragmentPage.dart';
import 'package:code_generator/ui/home/ManifestPage.dart';
import 'package:code_generator/ui/home/SelectorPage.dart';
import 'package:code_generator/ui/home/SettingPage.dart';
import 'package:code_generator/ui/home/ShapePage.dart';
import 'package:code_generator/ui/home/WorkPage.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:window_manager/window_manager.dart';

import '../../model/nav.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  final PageController _transController = PageController();

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    _transController.dispose();
    super.dispose();
  }

  List<Navigation> navigator = [
    Navigation("Work", Icons.badge_rounded, true),
    Navigation("Custom", Icons.settings_rounded, false),
    Navigation("Activity", Icons.layers_rounded, false),
    Navigation("Fragment", Icons.segment_rounded, false),
    Navigation("Adapter", Icons.power_rounded, false),
    Navigation("ShapeView", Icons.streetview_outlined, false),
    Navigation("Dialog", Icons.outbox_rounded, false),
    Navigation("Selector", Icons.check_circle_rounded, false),
    Navigation("AndroidManifest", Icons.room_preferences_rounded, false)
  ];

  List<Widget> page = [
    const WorkPage(),
    const SettingPage(),
    const ActivityPage(),
    const FragmentPage(),
    const AdapterPage(),
    const ShapeViewPage(),
    const DialogPage(),
    const SelectorPage(),
    const ManifestPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanStart: (details) {
                windowManager.startDragging();
              },
              child: Container(
                color: const Color(0XFFEFF4F9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 40,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width / 2,
                      child: Row(
                        children: const [
                          Icon(Icons.precision_manufacturing, size: 20),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Code Generator", style: TextStyle(color: Colors.black, fontSize: 13)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            windowManager.close();
                          },
                          icon: const Icon(Icons.close)),
                    ),
                  ],
                ),
              ))),
      body: Container(
        color: const Color(0XFFEFF4F9),
        // color: Colors.red,
        child: Row(
          children: [
            SizedBox(
              width: 260,
              height: MediaQuery.of(context).size.height - 40,
              child: ListView.builder(
                  itemCount: navigator.length,
                  itemBuilder: (context, index) {
                    return leftItem(navigator[index].name, navigator[index].icon, navigator[index].isSelect, () {
                      setState(() {
                        for (int i = 0; i < navigator.length; i++) {
                          navigator[i].isSelect = false;
                        }
                        navigator[index].isSelect = true;
                        _transController.animateToPage(index, //跳转到的位置
                            duration: const Duration(milliseconds: 300), //跳转的间隔时间
                            curve: Curves.fastOutSlowIn);
                      });
                    });
                  }),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width - 260,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: _transController,
                  itemCount: navigator.length,
                  itemBuilder: (context, index) {
                    return page[index];
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget leftItem(String title, IconData icon, bool isSelect, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
      child: HoverButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        onpressed: onPressed,
        hoverElevation: 0,
        color: isSelect ? const Color(0XFFEDEDED) : const Color(0XFFEFF4F9),
        hoverPadding: const EdgeInsets.only(left: 8, right: 8, top: 2.5, bottom: 2.5),
        hoverColor: const Color(0XFFEDEDED),
        padding: const EdgeInsets.only(left: 8, right: 8, top: 2.5, bottom: 2.5),
        child: Container(
          height: 40,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 12),
                child: Icon(icon, color: Colors.black54, size: 20),
              ),
              Text(title, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}
