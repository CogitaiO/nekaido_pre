import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../../widgets/escapable.dart';
import '../../providers/settings_provider.dart';
import '../../providers/library_provider.dart';
import '../../providers/repositories_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget{
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final accentColor = Color(ref.watch(settingsProvider).accentColorValue);

    return Escapable(
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F0F),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Settings", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              SizedBox(
                width: 250,
                child: Column(
                  children:[
                    _MenuTab(title: "Appearance", icon: Icons.palette_rounded, index: 0, currentIndex: _selectedIndex, accentColor: accentColor, onTap: () => setState(() => _selectedIndex = 0)),
                    _MenuTab(title: "Player", icon: Icons.play_circle_rounded, index: 1, currentIndex: _selectedIndex, accentColor: accentColor, onTap: () => setState(() => _selectedIndex = 1)),
                    _MenuTab(title: "Library", icon: Icons.folder_copy_rounded, index: 2, currentIndex: _selectedIndex, accentColor: accentColor, onTap: () => setState(() => _selectedIndex = 2)),
                    _MenuTab(title: "Advanced", icon: Icons.settings_applications_rounded, index: 3, currentIndex: _selectedIndex, accentColor: accentColor, onTap: () => setState(() => _selectedIndex = 3)),
                  ],
                ),
              ),
              
              const SizedBox(width: 32),
              
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero).animate(animation),
                      child: child,
                    ),
                  ),
                  child: _buildContent(_selectedIndex, accentColor, ref),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(int index, Color accentColor, WidgetRef ref) {
    switch (index) {
      case 0: return _AppearanceSettings(key: const ValueKey(0), accentColor: accentColor);
      case 1: return _PlayerSettings(key: const ValueKey(1), accentColor: accentColor);
      case 2: return _LibrarySettings(key: const ValueKey(2), accentColor: accentColor);
      case 3: return _AdvancedSettings(key: const ValueKey(3), accentColor: accentColor);
      default: return const SizedBox.shrink();
    }
  }
}

class _AppearanceSettings extends ConsumerWidget {
  final Color accentColor;
  const _AppearanceSettings({super.key, required this.accentColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    final colors = [
      Colors.redAccent, Colors.blueAccent, Colors.greenAccent, 
      Colors.purpleAccent, Colors.orangeAccent, Colors.pinkAccent,
    ];

    return ListView(children: [
      _SectionHeader(title: "Theme & Colors"),
      _SettingsCard(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("App Accent Color", style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 16),
              Row(
                children: colors.map((c) {
                  final isSelected = settings.accentColorValue == c.toARGB32();
                  return GestureDetector(
                    onTap: () => notifier.updateAccentColor(c),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: c, shape: BoxShape.circle,
                        border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
                        boxShadow: isSelected ?[BoxShadow(color: c.withValues(alpha: 0.5), blurRadius: 10)] :[],
                      ),
                      child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 20) : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 24),
      _SectionHeader(title: "Integrations"),
      _SettingsCard(
        child: SwitchListTile(
          activeThumbColor: accentColor,
          title: const Text("Discord Rich Presence", style: TextStyle(color: Colors.white)),
          subtitle: const Text("Show the anime you are watching in your Discord status", style: TextStyle(color: Colors.white38)),
          value: settings.discordRpcEnabled,
          onChanged: (val) => notifier.toggleDiscordRpc(val),
        ),
      ),
    ]);
  }
}

class _PlayerSettings extends ConsumerWidget {
  final Color accentColor;
  const _PlayerSettings({super.key, required this.accentColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return ListView(
      children: [
        _SectionHeader(title: "Playback"),
        _SettingsCard(
          child: Column(
            children: [
              SwitchListTile(
                activeThumbColor: accentColor,
                title: const Text("Auto-skip Openings/Endings", style: TextStyle(color: Colors.white)),
                subtitle: const Text("Automatically skip if AniSkip finds timestamps", style: TextStyle(color: Colors.white38)),
                value: settings.autoSkipEnabled,
                onChanged: (val) => notifier.toggleAutoSkip(val),
              ),
            ],
          )
        ),
        const SizedBox(height: 24),
        _SectionHeader(title: "Languages (Priority)"),
        _SettingsCard(
          child: Column(
            children: [
              ListTile(
                title: const Text("Audio Language", style: TextStyle(color: Colors.white)),
                trailing: DropdownButton<String>(
                  dropdownColor: const Color(0xFF1A1A1A),
                  value: settings.audioLanguage.startsWith('jpn') ? 'jpn' : 'eng',
                  items: [
                    DropdownMenuItem(value: 'jpn', child: Text("Japanese (Original)", style: TextStyle(color: Colors.white))),
                    DropdownMenuItem(value: 'eng', child: Text("English (Dub)", style: TextStyle(color: Colors.white))),
                  ],
                  onChanged: (val) {
                    if (val == 'jpn') notifier.updateAudioLang('jpn,jp,eng,en,rus,ru');
                    if (val == 'eng') notifier.updateAudioLang('eng,en,jpn,jp,rus,ru');
                  },
                ),
              ),
              const Divider(color: Colors.white12, height: 1),
              ListTile(
                title: const Text("Subtitle Language", style: TextStyle(color: Colors.white)),
                trailing: DropdownButton<String>(
                  dropdownColor: const Color(0xFF1A1A1A),
                  value: settings.subLanguage.startsWith('eng') ? 'eng' : 'rus',
                  items: const[
                    DropdownMenuItem(value: 'eng', child: Text("English", style: TextStyle(color: Colors.white))),
                    DropdownMenuItem(value: 'rus', child: Text("Russian", style: TextStyle(color: Colors.white)))
                  ],
                  onChanged: (val) {
                    if (val == 'eng') notifier.updateSubLang('eng,en,rus,ru');
                    if (val == 'rus') notifier.updateSubLang('rus,ru,eng,en');
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _SectionHeader(title: "Video Decoder"),
        _SettingsCard(
          child: ListTile(
            title: const Text("Hardware Acceleration", style: TextStyle(color: Colors.white)),
            subtitle: const Text("Change this if video is lagging or shows a black screen", style: TextStyle(color: Colors.white38)),
            trailing: DropdownButton<String>(
              dropdownColor: const Color(0xFF1A1A1A),
              value: settings.hwdec,
              items: const[
                DropdownMenuItem(value: 'auto', child: Text("Auto", style: TextStyle(color: Colors.white))),
                DropdownMenuItem(value: 'auto-safe', child: Text("Auto (Safe)", style: TextStyle(color: Colors.white))),
                DropdownMenuItem(value: 'd3d11va', child: Text("Windows (d3d11va)", style: TextStyle(color: Colors.white))),
                DropdownMenuItem(value: 'no', child: Text("Disabled (CPU)", style: TextStyle(color: Colors.redAccent))),
              ],
              onChanged: (val) {
                if (val != null) notifier.updateHwdec(val);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuTab extends StatelessWidget {
  final String title;
  final IconData icon;
  final int index;
  final int currentIndex;
  final Color accentColor;
  final VoidCallback onTap;
  
  const _MenuTab({required this.title, required this.icon, required this.index, required this.currentIndex, required this.accentColor, required this.onTap});

  @override
  Widget build(BuildContext context){
    final isSelected = index == currentIndex;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? accentColor.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? accentColor : Colors.white54, size: 22),
            const SizedBox(width: 16),
            Text(title, style: TextStyle(color: isSelected ? accentColor : Colors.white70, fontSize: 16, fontWeight: isSelected ? 
                                        FontWeight.bold : FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _LibrarySettings extends ConsumerWidget {
  final Color accentColor;
  const _LibrarySettings({super.key, required this.accentColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(savedFoldersProvider);
    return ListView(
      children: [
        _SectionHeader(title: "Scanned Folders"),
        _SettingsCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (folders.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(child: Text("No folders added yet", style: TextStyle(color: Colors.white38))),
                )
              else 
                ...folders.map((folder) => ListTile(
                  leading: const Icon(Icons.folder,color: Colors.white54),
                  title: Text(folder, style: const TextStyle(color: Colors.white)),
                  trailing:  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white38),
                    onPressed: () => ref.read(savedFoldersProvider.notifier).removeFolder(folder),
                    tooltip: "Remove from library",
                  ),
                ),
              ),
              const Divider(color: Colors.white12, height: 1),
              InkWell(
                onTap: () async {
                  final String? folderPath = await FilePicker.getDirectoryPath();
                  if (folderPath != null) {
                    ref.read(savedFoldersProvider.notifier).addFolder(folderPath);
                    ref.read(scannerProvider).scanAndGroupFiles(folderPath);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Folder added to scan queue"), 
                      backgroundColor: Colors.lightGreen));
                    }
                  }
                },
                child: Padding(
                  padding:  const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: accentColor),
                      const SizedBox(width: 8),
                      Text("Add New Folder", style: TextStyle(color: accentColor, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: folders.isEmpty ? null : () async {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Scan started...")));
            final scanner = ref.read(scannerProvider);
            for (var folder in folders) {
              await scanner.scanAndGroupFiles(folder);
            }
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Scan completed!"), 
              backgroundColor: Colors.lightGreen));
            }
          },
          icon: const Icon(Icons.sync_rounded),
          label: const Text("Rescan Library"),
        ),
      ],
    );
  }
}

class _AdvancedSettings extends ConsumerWidget{
  final Color accentColor;
  const _AdvancedSettings({super.key, required this.accentColor});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return ListView(
      children: [
        _SectionHeader(title: "Danger Zone"),
         _SettingsCard(
          child: ListTile(
            iconColor: Colors.redAccent,
            textColor: Colors.redAccent,
            leading: const Icon(Icons.delete_forever),
            title: const Text("Clear Database", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Removes all titles, watch history, and notes. Media files on disk will NOT be deleted.", 
                                  style: TextStyle(color: Colors.white38)),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Clear everything?", style: TextStyle(color: Colors.white)),
                  content: const Text("This action cannot be undone.", style: TextStyle(color: Colors.white70)), 
                                    backgroundColor: const Color(0xFF1A1A1A),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel", 
                                                                    style: TextStyle(color: Colors.white54))),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      onPressed: () async {
                        await ref.read(animeRepoProvider).clearAll();
                        if (ctx.mounted) Navigator.pop(ctx);
                      },
                      child: const Text("Delete", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({ required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(title, style: const TextStyle(color: Colors.white54, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.2)), 
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;
  const _SettingsCard({required this.child});

  @override 
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: child,
    );
  }
}