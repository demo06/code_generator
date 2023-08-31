import 'package:code_generator/ui/widget/CustomItem.dart';
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
  var _projectPath = 'Please setting generate file directory';

  @override
  void initState() {
    super.initState();
    _getProjectName();
    _getProjectPath();
  }

  Future _getProjectName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _projectName = prefs.getString("projectName") ?? "Please setting project name";
      _controller.text = _projectName;
    });
  }

  Future _saveProjectName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("projectName", value);
  }

  Future _getProjectPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _projectPath = prefs.getString("projectPath") ?? "Please setting generate file directory";
    });
  }

  Future _saveProjectPath(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("projectPath", value);
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
                                        _saveProjectName(_controller.text);
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
                      icon: Icons.folder_rounded,
                      title: "Generate Path",
                      subTitle: _projectPath,
                      child: SizedBox(
                        width: 80,
                        child: ElevatedButton(
                          onPressed: () => getProjectPath(),
                          child: const Text('Choose'),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future getProjectPath() async {
    final String? directoryPath = await getDirectoryPath();
    if (directoryPath != null) {
      setState(() {
        _projectPath = directoryPath;
        _saveProjectPath(_projectPath);
      });
    }
    // else {
    //   setState(() {
    //     _projectPath = 'Please setting generate file directory';
    //   });
    // }
  }

  @override
  bool get wantKeepAlive => true;
}
