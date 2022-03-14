// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:apollo_lite/backend/components.dart';
import 'package:apollo_lite/backend/constants.dart';
import 'package:apollo_lite/backend/locals/lang.dart';
import 'package:apollo_lite/backend/song_manager.dart';
import 'package:apollo_lite/pages/playing_now.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'edit_playlist_page.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({this.artwork, required this.listname, required this.listid, required this.playlistlen, required this.pagemanager, Key? key}) : super(key: key);
  final artwork;
  //final playlistsong;
  // final playlistIds;
  // final playlistarti;
  final String listname;
  final int listid;
  final int playlistlen;
  final PageManager pagemanager;
  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  final List<int> _listIds = [];
  @override
  void initState() {
    List<SongModel> _songs = Provider.of<PageManager>(context, listen: false).songs;
    List<String> titles = Provider.of<PageManager>(context, listen: false).listTitles;
    for (var song in _songs) {
      for (var tit in titles) {
        if (song.title == tit) {
          _listIds.add(song.id);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _listSongs = widget.pagemanager.listSongs;
    final _listTitles = widget.pagemanager.listTitles;
    final _listArtists = widget.pagemanager.listArtists;
    final _ids = widget.pagemanager.listIds;
    final lang = Languages.of(context);
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Stack(children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: false,
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: morningBlue,
                forceElevated: false,
                expandedHeight: 250,
                centerTitle: false,
                pinned: false,
                shadowColor: whitey.withAlpha(10),
                leading: const BackButton(color: dblue),
                actions: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('${lang.delPla} ${widget.listname}?', style: songTitleStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold, color: whitey)),
                          backgroundColor: morningBlue,
                          actions: [
                            TextButton(onPressed: () => {Navigator.pop(context)}, child: Text(lang.cancel, style: songTitleStyle.copyWith(color: whitey, fontWeight: FontWeight.bold))),
                            TextButton(
                                onPressed: () => {
                                      widget.pagemanager.removePlaylist(widget.listid, widget.listname),
                                      Navigator.pop(context),
                                    },
                                child: Text(lang.delPla, style: songTitleStyle.copyWith(color: Colors.red.shade700, fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0, right: 20, left: 20),
                      child: Text(lang.delPla, style: songTitleStyle.copyWith(color: onyx)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => EditPlaylistPage(
                            artwork: widget.artwork,
                            listname: widget.listname,
                            listid: widget.listid,
                            playlistlen: widget.playlistlen,
                            playlistsong: _listTitles,
                            playlistarti: _listArtists,
                            playlistIds: _ids,
                            pagemanager: widget.pagemanager,
                          ),
                        ),
                      ),
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0, right: 20, left: 20),
                      child: Text(lang.editPla, style: songTitleStyle.copyWith(color: onyx)),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: size.width * .35,
                          width: size.width * .36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            boxShadow: [
                              BoxShadow(
                                color: onyx.withOpacity(.5),
                                offset: const Offset(3, 4),
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            child: widget.artwork,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * .34,
                              child: Text(
                                widget.listname,
                                style: bas2Style.copyWith(
                                  color: onyx,
                                  fontSize: 26,
                                ),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            const SizedBox(height: 20 / 4),
                            Text(
                              '${widget.playlistlen} ${lang.tracks}',
                              style: songArtistStyle.copyWith(
                                color: onyx,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: morningBlue.withAlpha(100).withOpacity(.7),
                pinned: true,
                elevation: 25,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PlayListButton(
                        name: lang.playPla,
                        icon: Icon(Icons.play_arrow, color: whitey.withAlpha(180)),
                        func: () {
                          widget.pagemanager.listenPlaylistChanges(
                            _listTitles,
                            _listArtists,
                            _listIds,
                          );
                          setState(() {});
                        }),
                    PlayListButton(
                      name: lang.shufflePla,
                      icon: Icon(Icons.shuffle, color: whitey.withAlpha(180)),
                      func: () {
                        widget.pagemanager.shufflePlaylist(
                          _listTitles,
                          _listArtists,
                          _listIds,
                        );
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 20),
                    //SizedBox(height: leftPad),
                    _listTitles.isEmpty
                        ? Text(
                            lang.textPla,
                            style: bas2Style.copyWith(fontSize: 21),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            addAutomaticKeepAlives: true,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemBuilder: (context, index) => SongContainer(
                              isHome: false,
                              h: size.width * .20,
                              w: 25.0,
                              title: _listTitles[index],
                              artist: _listArtists[index],
                              id: _listIds[index],
                              icon: Icons.menu_open_rounded,
                              size: size,
                              manager: widget.pagemanager,
                              func: () {
                                widget.pagemanager.playPlaylistInd(_listTitles, _listArtists, _listIds, _listTitles[index]);
                                setState(() {});
                              },
                            ),
                            separatorBuilder: (context, index) => Divider(thickness: 2, color: onyx.withOpacity(.2), height: 10),
                            itemCount: _listSongs.length,
                            scrollDirection: Axis.vertical,
                          ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AltBar(
              manager: widget.pagemanager,
              size: size,
              h: widget.pagemanager.currentSongTitleNotifier.value.isEmpty ? 0.0 : 1.0,
              func: () {
                Navigator.of(context).pushNamed(PlayingNow.routeName);
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class PlayListButton extends StatelessWidget {
  const PlayListButton({
    Key? key,
    required this.name,
    required this.icon,
    required this.func,
  }) : super(key: key);

  final String name;
  final Icon icon;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        func();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20 / 3),
        child: Row(
          children: [
            icon,
            Text(
              name,
              style: bas2Style.copyWith(
                fontSize: 21,
                color: whitey.withAlpha(200),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: onyx.withOpacity(.55),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: onyx.withAlpha(180).withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
