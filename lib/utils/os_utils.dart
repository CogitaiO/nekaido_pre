import 'dart:io';

class OSUtils {
  static void openFolder(String? path) {
    if (path == null) return;
    if (Platform.isWindows) Process.run('explorer', [path]);
    else if (Platform.isMacOS) Process.run('open', [path]);
    else if (Platform.isLinux) Process.run('xdg-open', [path]);
  }
}