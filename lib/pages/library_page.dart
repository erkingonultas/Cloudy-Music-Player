import 'dart:io';

import 'package:apollo_lite/backend/components.dart';
import 'package:apollo_lite/backend/constants.dart';
import 'package:apollo_lite/backend/locals/lang.dart';
import 'package:apollo_lite/backend/song_manager.dart';
import 'package:apollo_lite/pages/favorites_page.dart';
import 'package:apollo_lite/pages/playing_now.dart';
import 'package:apollo_lite/pages/playlist_page.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'create_playlist.dart';

class LibraryPage extends StatelessWidget {
  static const routeName = '/library';
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pageManager = Provider.of<PageManager>(context);
    final lang = Languages.of(context);
    final favorites = _pageManager.favoriteSongs;
    final favTitle = _pageManager.favSongTitle;
    final favArti = _pageManager.favSongArtists;
    final favids = _pageManager.favSongIds;
    final favArtWork = favorites.isEmpty ? defaultPlaylistArt : SongArtWork(id: favorites[0].id);
    final List<PlaylistModel> playlists = _pageManager.playlists;
    final _playlistArtworks = _pageManager.playlistArtworks;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: false,
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: false,
                  snap: false,
                  stretch: true,
                  toolbarHeight: 100,
                  backgroundColor: morningBlue,
                  shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                      // topLeft: Radius.circular(45),
                      // topRight: Radius.circular(45),
                      bottomLeft: Radius.circular(125),
                      bottomRight: Radius.circular(125),
                    ),
                  ),
                  elevation: 15,
                  forceElevated: true,
                  shadowColor: black,
                  centerTitle: true,
                  title: Text(
                    lang.libraryLabel,
                    style: basStyle.copyWith(letterSpacing: 3, fontSize: 32, color: dblue),
                  ),
                  leading: const BackButton(color: dblue),
                  actions: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(CreatePlaylistPage.routeName),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 25.0),
                        child: SizedBox(
                          width: 35,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Icon(
                              Icons.add_box_rounded,
                              color: dblue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 45),
                  sliver: SliverAppBar(
                    backgroundColor: Colors.grey.shade300,
                    automaticallyImplyLeading: false,
                    elevation: 15,
                    forceElevated: true,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade400),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10),
                        top: Radius.circular(10),
                      ),
                    ),
                    shadowColor: Colors.grey.shade400,
                    toolbarHeight: 130,
                    title: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => FavoritesPage(
                              artwork: favArtWork,
                              listname: lang.favorites,
                              playlistsong: favTitle,
                              playlistlen: favids.length,
                              playlistIds: favids,
                              playlistarti: favArti,
                              pagemanager: _pageManager,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(3, 3),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                                // BoxShadow(
                                //   color: Colors.grey.shade400,
                                //   offset: const Offset(-1, -1),
                                //   blurRadius: 5,
                                //   spreadRadius: 1,
                                // ),
                              ],
                            ),
                            height: size.width * .26,
                            width: size.width * .28,
                            //padding: EdgeInsets.all(leftPad),
                            child: favArtWork,
                          ),
                          Text(
                            lang.favorites,
                            style: songDetailStyle.copyWith(color: dblue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (playlists.isEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 15 * 4, top: 25, left: 15, right: 15),
                    sliver: SliverList(delegate: delegate(size, lang)),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 15 * 4, top: 25, left: 30, right: 30),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        return GestureDetector(
                          onTap: () async {
                            await _pageManager.songsForPlaylist(playlists[i].id);

                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => PlaylistPage(
                                  //artwork: _playlistArtworks[i] == 999 ? defaultPlaylistArt : SongArtWork(id: _playlistArtworks[i]),
                                  artwork: _pageManager.customArts[playlists[i].playlist] != null
                                      ? Image.file(File(_pageManager.customArts[playlists[i].playlist]!), fit: BoxFit.cover)
                                      : _playlistArtworks[i] == 999
                                          ? defaultPlaylistArt
                                          : SongArtWork(id: _playlistArtworks[i]),
                                  listname: playlists[i].playlist,
                                  listid: playlists[i].id,
                                  playlistlen: playlists[i].numOfSongs,
                                  //playlistsong: songs,
                                  // playlistarti: songArtists,
                                  // playlistIds: songIds,
                                  pagemanager: _pageManager,
                                ),
                              ),
                            );

                            // ).whenComplete(() => controller());
                          },
                          child: PlaylistContainer(
                            name: playlists[i].playlist,
                            //img: _playlistArtworks[i] == 999 ? defaultPlaylistArt : SongArtWork(id: _playlistArtworks[i]),
                            img: _pageManager.customArts[playlists[i].playlist] != null
                                ? Image.file(File(_pageManager.customArts[playlists[i].playlist]!), fit: BoxFit.cover)
                                : _playlistArtworks[i] == 999
                                    ? defaultPlaylistArt
                                    : SongArtWork(id: _playlistArtworks[i]),
                            size: size, length: playlists[i].numOfSongs,
                          ),
                        );
                      },
                      childCount: playlists.length,
                    ),
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
        ),
      ),
    );
  }

  delegate(size, lang) => SliverChildListDelegate([
        SizedBox(height: size.width * .35),
        Text(
          lang.noPlaylists,
          style: songDetailStyle.copyWith(fontSize: 21),
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
        ),
      ]);
}
