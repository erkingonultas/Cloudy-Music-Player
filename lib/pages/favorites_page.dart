import 'package:apollo_lite/backend/components.dart';
import 'package:apollo_lite/backend/constants.dart';
import 'package:apollo_lite/backend/locals/lang.dart';
import 'package:apollo_lite/backend/song_manager.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({required this.artwork, required this.listname, required this.playlistlen, required this.pagemanager, Key? key, required this.playlistsong, required this.playlistIds, required this.playlistarti}) : super(key: key);
  final Widget artwork;
  final List<String> playlistsong;
  final List<int> playlistIds;
  final List<String> playlistarti;
  final String listname;
  final int playlistlen;
  final PageManager pagemanager;
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lang = Languages.of(context);

    return Scaffold(
      body: CustomScrollView(
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
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Container(
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
                    widget.pagemanager.listenPlaylistChanges(widget.playlistsong, widget.playlistarti, widget.playlistIds);
                    setState(() {});
                  },
                ),
                PlayListButton(
                  name: lang.shuffleArc,
                  icon: Icon(Icons.shuffle, color: whitey.withAlpha(180)),
                  func: () {
                    widget.pagemanager.shufflePlaylist(widget.playlistsong, widget.playlistarti, widget.playlistIds);
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
                widget.playlistsong.isEmpty
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
                          h: size.width * .10,
                          w: 25.0,
                          title: widget.playlistsong[index],
                          artist: widget.playlistarti[index],
                          id: widget.playlistIds[index],
                          icon: Icons.menu_open_rounded,
                          size: size,
                          manager: widget.pagemanager,
                          func: () => {
                            setState(() {
                              widget.pagemanager.playPlaylistInd(widget.playlistsong, widget.playlistarti, widget.playlistIds, widget.playlistsong[index]);
                            }),
                          },
                        ),
                        separatorBuilder: (context, index) => Divider(thickness: 2, color: onyx.withOpacity(.2), height: 20 * 2),
                        itemCount: widget.playlistsong.length,
                        scrollDirection: Axis.vertical,
                      ),
                const SizedBox(height: 80),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                //   child: GestureDetector(
                //     child: Container(
                //       width: size.width * .4,
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         color: spaceGrey2.withOpacity(0.7),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       padding: const EdgeInsets.all(15.0),
                //       child: Text(lang.text2Pla, style: basStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                //     ),
                //   ),
                // ),
                // SizedBox(height: leftPad),
              ],
            ),
          ),
        ],
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
