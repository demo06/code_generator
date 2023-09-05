import 'dart:convert';
import 'dart:io';

import '../model/commit.dart';

class GitUtil {
  static Future<Map<String, Commit>> getCommits(String path, [String branchName = 'HEAD']) async {
    final pr = await Process.run('git', ['rev-list', '--format=raw', branchName],
        workingDirectory: path, stdoutEncoding: const Utf8Codec());
    return Commit.parseRawRevList(pr.stdout as String);
  }

  static int getCommitDate(Commit commit) {
    return int.parse(commit.author.split(" ")[2]);
  }
}
