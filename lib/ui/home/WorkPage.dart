import 'dart:convert';
import 'dart:io';

import 'package:code_generator/model/daily_work.dart';
import 'package:code_generator/ui/widget/DailyItem.dart';
import 'package:code_generator/utils/GitUtil.dart';
import 'package:code_generator/utils/SpUtil.dart';
import 'package:code_generator/utils/TimeUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:git/git.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<StatefulWidget> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  final todayTime = TimeUtil().getTodayStartTime();
  Utf8Decoder decoder = const Utf8Decoder();
  List<DailyWork> workLog = [];

  @override
  void initState() {
    super.initState();
    getGitDirectoryInfo();
  }

  Future<void> getGitDirectoryInfo() async {
    if (workLog.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('当天记录已生成')));
      return;
    }
    var projectPath = '';
    SPUtil.perInit()
        .then((value) => projectPath = SPUtil().get<String>("projectPath") ?? '')
        .then((value) => getGitInfo(projectPath));
  }

  Future<void> getGitInfo(String path) async {
    if (await GitDir.isGitDir(path)) {
      final commit = await GitUtil.getCommits(path);
      commit.forEach((key, value) {
        final time = GitUtil.getCommitDate(value);
        if (time > todayTime) {
          setState(() {
            workLog.add(DailyWork(value.message, false));
          });
        }
      });
    }
  }

  void generateLogAndSend() {
    var time = TimeUtil().getTodayDate();
    var title = '$time 丁文彬 工作总结';
    int index = 1;
    workLog.forEach((element) {
      if (element.isSelect == true) {
        title += '\n$index、${element.title}  完成100%';
        index++;
      }
    });
    Clipboard.setData(ClipboardData(text: title));
    Process.run('python', ['D:\\project\\python\\tool_pyautogui_sendmsg\\autoSendMsg.py']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0XFFEFF4F9),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right:  12, top: 0, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('WorkBench', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 160,
                child: ListView.builder(
                    itemCount: workLog.length,
                    itemBuilder: (context, index) {
                      return DailyItem(
                        title: workLog[index].title,
                        isSelect: workLog[index].isSelect,
                        onChanged: () {
                          setState(() {
                            workLog[index].isSelect = !workLog[index].isSelect;
                          });
                        },
                      );
                    }),
              ),
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
                          child: ElevatedButton(
                              onPressed: () {
                                getGitDirectoryInfo();
                              },
                              child: const Text('Fetch Work Record'))),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () => generateLogAndSend(), child: const Text('Generate And Send'))),
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
}
