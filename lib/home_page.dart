import 'package:apollo_lite/backend/locals/lang.dart';
import 'package:apollo_lite/pages/library_page.dart';
import 'package:apollo_lite/pages/playing_now.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'backend/components.dart';
import 'backend/constants.dart';
import 'backend/song_manager.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/home';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _listScrollController;

  @override
  void initState() {
    _listScrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lang = Languages.of(context);
    final _pageManager = Provider.of<PageManager>(context);
    final List<SongModel> songList = _pageManager.songs;
    final songs = _pageManager.songTitles;
    final songArtists = _pageManager.songArtists;
    final songIds = _pageManager.songIds;
    final curTitle = _pageManager.currentSongTitleNotifier.value;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _listScrollController,
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  pinned: false,
                  snap: false,
                  stretch: true,
                  backgroundColor: morningBlue,
                  toolbarHeight: 100,
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                      // topLeft: Radius.circular(45),
                      // topRight: Radius.circular(45),
                      bottomLeft: Radius.circular(125),
                      bottomRight: Radius.circular(125),
                    ),
                  ),
                  forceElevated: true,
                  elevation: 15,
                  shadowColor: black,
                  centerTitle: true,
                  title: Text(
                    lang.archiveLabel,
                    style: basStyle.copyWith(letterSpacing: 3, fontSize: 32, color: dblue),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(LibraryPage.routeName),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 25.0),
                        child: SizedBox(
                          width: 35,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Icon(
                              Icons.my_library_music_rounded,
                              color: dblue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (songs.isEmpty)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20 / 2),
                        child: Text(
                          lang.noSongs,
                          style: bas2Style.copyWith(fontSize: 21),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ),
                if (songs.isNotEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ListView.separated(
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(2, 2),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-1, -1),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: ExpansionTile(
                                children: [
                                  SongMenuv2(
                                    //artist: _albumArtists[index],
                                    id: songIds[index],
                                    //title: _albumTitles[index],
                                    size: size,
                                  )
                                ],
                                trailing: Text(
                                  "${(songList[index].duration! ~/ 60000).toString().padLeft(2, '0')} : ${((songList[index].duration! / 60000 - (songList[index].duration! ~/ 60000).floor()) * 60).toInt().toString().padLeft(2, '0')}",
                                ),
                                title: SongContainerv2(
                                  h: 55.0,
                                  w: 25.0,
                                  title: songs[index],
                                  artist: songArtists[index].toString(),
                                  id: songIds[index],
                                  size: size,
                                  manager: _pageManager,
                                  func: () {
                                    setState(() {
                                      if (songs[index] != curTitle) {
                                        _pageManager.playHomeIndividual(songIds[index]);
                                      } else {
                                        Navigator.of(context).pushNamed(PlayingNow.routeName);
                                      }
                                    });
                                  },
                                ),
                                leading: GestureDetector(
                                  onTap: () {
                                    if (_pageManager.favSongIds.contains(songIds[index])) {
                                      _pageManager.removeFromFav(songIds[index]);
                                      bildirim(context, lang.remFav2);
                                    } else {
                                      _pageManager.add2Fav(songIds[index]);
                                      bildirim(
                                        context,
                                        lang.addFav2,
                                      );
                                    }
                                    _pageManager.getFavIds();
                                    _pageManager.initID2Song();
                                  },
                                  child: Icon(
                                    _pageManager.favSongTitle.contains(songs[index]) ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                                    size: 30,
                                    color: _pageManager.favSongTitle.contains(songs[index]) ? Colors.redAccent : black,
                                  ),
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => const SizedBox(height: 15),
                            itemCount: songs.length,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (songs.length > 15)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 150.0),
                      child: FloatingActionButton.small(backgroundColor: onyx, child: const Icon(Icons.arrow_upward_rounded), enableFeedback: true, onPressed: () => _listScrollController.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.decelerate)),
                    ),
                  ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AltBar(
                manager: _pageManager,
                size: size,
                h: _pageManager.currentSongTitleNotifier.value.isEmpty ? 0.0 : 1.0,
                func: () {
                  Navigator.of(context).pushNamed(PlayingNow.routeName);
                },
              ),
            ),
          ],
        ), // ArchivePage
      ),
    );
  }
}
