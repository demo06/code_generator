import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ManifestPage extends StatefulWidget {
  const ManifestPage({super.key});

  @override
  State<StatefulWidget> createState() => _ManifestPageState();
}

String generatorManifest(String className, String description) {
  return '''
<activity
      android:name="com.zgw.home.activity.${className}Activity"
      android:configChanges="keyboardHidden|orientation"
      android:label="$description"
      android:screenOrientation="portrait" />
    ''';
}

class _ManifestPageState extends State<ManifestPage> with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller = TextEditingController();

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
            const Text('AndroidManifest生成', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: TextField(
                  controller: _controller,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 6,
                  readOnly: true,
                  decoration: const InputDecoration(border: OutlineInputBorder())),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: _generateContext(), child: const Text('generate'))),
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

  _copyToClipBoard() {
    return () {
      Clipboard.setData(ClipboardData(text: generatorManifest('Generator', '代码生成器')));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('复制成功')));
    };
  }

  _generateContext() {
    return () {
      _controller.text = generatorManifest('Generator', '代码生成器');
    };
  }

  @override
  bool get wantKeepAlive => true;
}
