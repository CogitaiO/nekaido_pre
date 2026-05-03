import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:isar/isar.dart';
import 'package:nekaido_pre/presentation/settings/settings_screen.dart'; // Проверьте правильность пути
import '../../providers/library_provider.dart';
import '../../providers/settings_provider.dart';
import '../../core/debouncer.dart';
import '../widgets/media_card.dart';
import '../widgets/custom_title_bar.dart'; // <-- Исправлена опечатка с кавычкой
import '../../../../providers/settings_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Column(
        children:[
          // 1. Кастомная шапка всегда на самом верху, во всю ширину
          const CustomTitleBar(), 

          // 2. Основной контент (Сайдбар + Сетка), растянутый на оставшееся место
          Expanded(
            child: Row( // <-- ВАЖНО: Row, чтобы сайдбар был слева, а контент справа
              children:[
                const _LeftSidebar(), 
                
                Expanded(
                  child: Column(
                    children: const[
                      _TopBar(),       
                      Expanded(
                        child: _ContentGrid(), 
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(ref.watch(settingsProvider).accentColorValue),
        onPressed: () async {
          final String? folderPath = await FilePicker.getDirectoryPath();
          if (folderPath != null) {
            ref.read(savedFoldersProvider.notifier).addFolder(folderPath);
            
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Сканируем новую папку..."))
            );

            final scanner = ref.read(scannerProvider);
            await scanner.scanAndGroupFiles(folderPath);

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Папка добавлена в библиотеку!"), backgroundColor: Colors.green)
              );
            }
          }
        },
        icon: const Icon(Icons.create_new_folder_rounded, color: Colors.white),
        label: const Text("Добавить папку", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _LeftSidebar extends StatelessWidget {
  const _LeftSidebar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      color: const Color(0xFF151515),
      child: Column(
        children:[
          const SizedBox(height: 24),
          Tooltip(
            message: "Режим: Аниме\n(Нажми для смены)",
            decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent,
                boxShadow:[BoxShadow(color: Colors.redAccent, blurRadius: 10, spreadRadius: -2)],
              ),
              child: const Icon(Icons.movie_creation, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(height: 32),
          const Divider(color: Colors.white10, indent: 16, endIndent: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const[
                  SizedBox(height: 8),
                  _SidebarIcon(icon: Icons.all_inclusive, tooltip: "Вся библиотека", index: 0),
                  _SidebarIcon(icon: Icons.play_circle_outline, tooltip: "Смотрю", index: 1),
                  _SidebarIcon(icon: Icons.watch_later_outlined, tooltip: "В планах", index: 2),
                  _SidebarIcon(icon: Icons.check_circle_outline, tooltip: "Просмотрено", index: 3),
                  _SidebarIcon(icon: Icons.cancel_outlined, tooltip: "Брошено", index: 4),

                  SizedBox(height: 16),
                  Divider(color: Colors.white10, indent: 16, endIndent: 16),
                  SizedBox(height: 16),
                  _SidebarIcon(icon: Icons.folder_special_outlined, tooltip: "Мои подборки", index: 5),
                ],
              ),
            ),
          ),
          const _SidebarIcon(icon: Icons.settings, tooltip: "Settings", index: -1, isBottom: true),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SidebarIcon extends ConsumerStatefulWidget {
  final IconData icon;
  final String tooltip;
  final int index;
  final bool isBottom;

  const _SidebarIcon({
    required this.icon, required this.tooltip, required this.index, this.isBottom = false,
  });

  @override
  ConsumerState<_SidebarIcon> createState() => _SidebarIconState();
}

class _SidebarIconState extends ConsumerState<_SidebarIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSelected = ref.watch(selectedSidebarIndexProvider.select((val) => val == widget.index)) && !widget.isBottom;
    final color = isSelected ? Color(ref.watch(settingsProvider).accentColorValue) : (_isHovered ? Colors.white : Colors.white38);

    return Tooltip(
      message: widget.tooltip,
      waitDuration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white12)),
      textStyle: const TextStyle(color: Colors.white, fontSize: 12),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (widget.isBottom && widget.index == -1) {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            } else if (!widget.isBottom) {
              ref.read(selectedSidebarIndexProvider.notifier).state = widget.index;
              if (widget.index == 5) {
                final collections = ref.read(allCollectionsProvider);
                if(collections.isNotEmpty && ref.read(selectedCollectionProvider) == null) {
                  ref.read(selectedCollectionProvider.notifier).state = collections.first;
                }
              }
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? Color(ref.watch(settingsProvider).accentColorValue).withValues(alpha: 0.15) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
           child: Icon(widget.icon, color: color, size: 28),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends ConsumerStatefulWidget {
  const _TopBar();
  @override
  ConsumerState<_TopBar> createState() => _TopBarState();
}

class _TopBarState extends ConsumerState<_TopBar> {
  final _debouncer = Debouncer(milliseconds: 300);

  String _getTitle(int index) {
    switch (index) {
      case 1: return "Watching";
      case 2: return "In plans";
      case 3: return "Watched";
      case 4: return "Abandoned ";
      case 5: return "My collections";
      default: return "Library";
    }
  }

  @override
  Widget build(BuildContext context) {
    final index = ref.watch(selectedSidebarIndexProvider);
    final allCollections = ref.watch(allCollectionsProvider);
    final selectedCollections =  ref.watch(selectedCollectionProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.fromLTRB(24, 24, 24, 8),
          child: Row(
            children: [
              Text(_getTitle(index), style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const Spacer(),
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (value) {
                    _debouncer.run(() {
                      ref.read(searchQueryProvider.notifier).state = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: const TextStyle(color: Colors.white38),
                    prefixIcon: const Icon(Icons.search_rounded, color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none), 
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: index == 5
                ? Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: allCollections.isEmpty
                      ? const Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text("You don't have any collections yet", style: TextStyle(color: Colors.white54)),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allCollections.length,
                        itemBuilder: (context,i) {
                          final collectionName = allCollections[i];
                          final isSelected = selectedCollections == collectionName;
                          return Padding(
                            padding: EdgeInsetsGeometry.only(right: 8),
                            child: ChoiceChip(
                              label: Text(collectionName), 
                              selected: isSelected,
                              selectedColor: Color(ref.watch(settingsProvider).accentColorValue).withValues(alpha: 0.3),
                              backgroundColor: Colors.white.withValues(alpha: 0.05),
                              labelStyle: TextStyle(color: isSelected ? Color(ref.watch(settingsProvider).accentColorValue) : Colors.white70),
                              side: BorderSide(color: isSelected ? Color(ref.watch(settingsProvider).accentColorValue) : Colors.transparent),
                              onSelected: (selected) {
                                if (selected) {
                                  ref.read(selectedCollectionProvider.notifier).state = collectionName;
                                } else {
                                  ref.read(selectedCollectionProvider.notifier).state = null;
                                }
                              },
                            ),
                          );
                        },
                    ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _ContentGrid extends ConsumerStatefulWidget {
  const _ContentGrid();

  @override
  ConsumerState<_ContentGrid> createState() => _ContentGridState();
}

class _ContentGridState extends ConsumerState<_ContentGrid> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowVpnWarning();
      _runAutoScan();
    });
  }

  Future<void> _runAutoScan() async {
    final folders = ref.read(savedFoldersProvider);
    if (folders.isEmpty) return;
    final scanner = ref.read(scannerProvider);
     for (String folder in folders) {
      await scanner.scanAndGroupFiles(folder);
    }
  }

  Future<void> _checkAndShowVpnWarning() async {
    final prefs = ref.read(sharedPrefsProvider);
    final hasSeenWarning = prefs.getBool('has_seen_vpn_warning') ?? false;

    if (!hasSeenWarning) {
      if (!mounted) return;
      await showDialog(
        context: context,
        barrierDismissible: false, // Запрещаем закрывать кликом мимо
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children:[
              Icon(Icons.shield_outlined, color: Colors.redAccent, size: 28),
              SizedBox(width: 12),
              Text("Рекомендация по сети", style: TextStyle(color: Colors.white)),
            ],
          ),
          content: const Text(
            "Для корректной работы приложения (загрузки постеров, описаний и поиска таймкодов пропусков опенингов) используются зарубежные сервисы Shikimori и AniSkip.\n\n"
            "Если вы находитесь в РФ, некоторые из них могут блокироваться провайдерами.\n\n" 
            "В случае сбоев или бесконечных загрузок настоятельно рекомендуется включить VPN (например, с маршрутизацией для определенных IP) или использовать средства обхода блокировок.",
            style: TextStyle(color: Colors.white70, height: 2.5),
          ),
          actions:[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(ref.watch(settingsProvider).accentColorValue)),
              onPressed: () {
                prefs.setBool('has_seen_vpn_warning', true);
                Navigator.pop(ctx);
              },
              child: const Text("Понятно", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final libraryAsync = ref.watch(libraryProvider);
    return libraryAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: Colors.redAccent)),
      error: (err, stack) => Center(child: Text("Ошибка БД: $err", style: const TextStyle(color: Colors.white))),
      data: (allAnimes) {
        final filteredList = ref.watch(filteredAnimeProvider);
        if (filteredList.isEmpty) return const Center(child: Text("Ничего не найдено", style: TextStyle(color: Colors.white54)));
        return GridView.builder (
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 0.7,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            return AnimeCard(anime: filteredList[index]);
          }
        );
      },
    );
  }
}