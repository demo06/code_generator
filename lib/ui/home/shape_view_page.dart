import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShapeViewPage extends StatefulWidget {
  const ShapeViewPage({super.key});

  @override
  State<StatefulWidget> createState() => _ShapeViewPageState();
}

class _ShapeViewPageState extends State<ShapeViewPage> with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller = TextEditingController();

  int groupIndex = 1;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0XFFEFF4F9),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('ShapeView生成', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: RadioListTile(
                              title: const Text(
                                "ShapeView",
                                style: TextStyle(fontSize: 14),
                              ),
                              value: 1,
                              selected: groupIndex == 1,
                              groupValue: groupIndex,
                              onChanged: _changed)),
                      Expanded(
                        child: RadioListTile(
                            title: const Text(
                              "ShapeTextView",
                              style: TextStyle(fontSize: 14),
                            ),
                            value: 2,
                            selected: groupIndex == 2,
                            groupValue: groupIndex,
                            onChanged: _changed),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                            title: const Text(
                              "ShapeBackGroundView",
                              style: TextStyle(fontSize: 14),
                            ),
                            value: 3,
                            selected: groupIndex == 3,
                            groupValue: groupIndex,
                            onChanged: _changed),
                      ),
                      Expanded(
                        child: RadioListTile(
                            title: const Text(
                              "ShapeBackGroundRelationView",
                              style: TextStyle(fontSize: 14),
                            ),
                            value: 4,
                            selected: groupIndex == 4,
                            groupValue: groupIndex,
                            onChanged: _changed),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                  controller: _controller,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 15,
                  readOnly: true,
                  decoration: const InputDecoration(border: OutlineInputBorder())),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  const Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: Text('')),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: _copyToClipBoard(), child: const Text('copy'))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changed(value) {
    groupIndex = value;
    setState(() {});
    if (kDebugMode) {
      print("groupIndex = $groupIndex");
    }
  }

  _copyToClipBoard() {
    return () {
      Clipboard.setData(ClipboardData(text: _generateContext()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('复制成功')));
    };
  }

  _generateContext() {
    switch (groupIndex) {
      case 1:
        _controller.text = generateShapeView('4', '#FF0000', '#00FF00', '1');
        break;
      case 2:
        _controller.text = generateShapeTextView('4', '#FF0000', '#00FF00', '1');
        break;
      case 3:
        _controller.text = generatorShapeBackGroundView('4', '#FF0000', '#00FF00', '1');
        break;
      case 4:
        _controller.text = generatorShapeBackGroundRelationView('4', '#FF0000', '#00FF00', '1');
        break;
      default:
        _controller.text="";
    }
  }

  String generateShapeView(String cornerRadius, String bgColor, String borderColor, String strokeWidth) {
    return '''
  <com.zgw.base.component.ShapeView
            android:id="@+id/shapeTv"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_centerHorizontal="true"
            android:gravity="center"
            app:cornesRadius="${cornerRadius}dp"
            app:solidColor="$bgColor"
            app:stroke_Color="$borderColor"
            app:stroke_Width="${strokeWidth}dp"
            app:touchSolidColor="@color/white" />
    ''';
  }

  String generateShapeTextView(String cornerRadius, String bgColor, String borderColor, String strokeWidth) {
    return '''
  <com.zgw.base.component.ShapeTextView
            android:id="@+id/shapeTv"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_centerHorizontal="true"
            android:gravity="center"
            android:text="确定"
            android:textColor="@color/orange"
            android:textSize="16sp"
            app:cornesRadius="${cornerRadius}dp"
            app:solidColor="$bgColor"
            app:stroke_Color="$borderColor"
            app:stroke_Width="${strokeWidth}dp"
            app:touchSolidColor="@color/white" />
    ''';
  }

  String generatorShapeBackGroundView(String cornerRadius, String bgColor, String borderColor, String strokeWidth) {
    return '''
  <com.zgw.base.component.ShapeBackGroundView
            android:id="@+id/shapeTv"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_centerHorizontal="true"
            android:gravity="center"
            app:cornesRadius="${cornerRadius}dp"
            app:solidColor="$bgColor"
            app:stroke_Color="$borderColor"
            app:stroke_Width="${strokeWidth}dp">
            
  </com.zgw.base.component.ShapeBackGroundView>
    ''';
  }

  String generatorShapeBackGroundRelationView(
      String cornerRadius, String bgColor, String borderColor, String strokeWidth) {
    return '''
  <com.zgw.base.component.ShapeBackGroundRelationView
            android:id="@+id/shapeTv"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_centerHorizontal="true"
            android:gravity="center"
            app:cornesRadius="${cornerRadius}dp"
            app:solidColor="$bgColor"
            app:stroke_Color="$borderColor"
            app:stroke_Width="${strokeWidth}dp">
            
  </com.zgw.base.component.ShapeBackGroundRelationView>
    ''';
  }

  @override
  bool get wantKeepAlive => true;
}
