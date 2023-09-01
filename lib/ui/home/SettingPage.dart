import 'package:code_generator/ui/widget/CustomItem.dart';
import 'package:code_generator/utils/SpUtil.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller = TextEditingController();

  var _projectName = 'Please setting your project name';
  var _projectPath = 'Please setting your project root path';
  var _generatePath = 'Please choose a directory for generate file';

  @override
  void initState() {
    super.initState();
    SPUtil.perInit().then((value) {
      setState(() {
        _projectName = SPUtil().get<String>("projectName") ?? 'Please setting your project name';
        _projectPath = SPUtil().get<String>("projectPath") ?? 'Please setting your project root path';
        _generatePath = SPUtil().get<String>("generatePath") ?? 'Please choose a directory for generate file';
        _controller.text = _projectName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0XFFEFF4F9),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0, bottom: 12),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Custom', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                  child: Column(
                    children: [
                      CustomItem(
                        icon: Icons.drive_file_rename_outline,
                        title: "Project name",
                        subTitle: _projectName,
                        child: SizedBox(
                          width: 80,
                          child: ElevatedButton(
                            onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text("Input Project Name"),
                                      content: TextField(controller: _controller),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            SPUtil().setString("projectName", _controller.text);
                                            setState(() {
                                              _projectName = _controller.text;
                                            });
                                            Navigator.pop(context, 'OK');
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    )),
                            child: const Text('Edit'),
                          ),
                        ),
                      ),
                      CustomItem(
                          icon: Icons.snippet_folder_rounded,
                          title: "Project root directory",
                          subTitle: _projectPath,
                          child: SizedBox(
                            width: 80,
                            child: ElevatedButton(
                              onPressed: () => getProjectPath(1),
                              child: const Text('Choose'),
                            ),
                          )),
                      CustomItem(
                          icon: Icons.folder_rounded,
                          title: "Generate Path",
                          subTitle: _generatePath,
                          child: SizedBox(
                            width: 80,
                            child: ElevatedButton(
                              onPressed: () => getProjectPath(2),
                              child: const Text('Choose'),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future getProjectPath(int type) async {
    final String? directoryPath = await getDirectoryPath();
    if (directoryPath != null) {
      setState(() {
        if (type == 1) {
          _projectPath = directoryPath;
          SPUtil().setString("projectPath", directoryPath);
        } else {
          _generatePath = directoryPath;
          SPUtil().setString("generatePath", directoryPath);
        }
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
