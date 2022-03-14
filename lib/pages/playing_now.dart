import 'dart:ui';
import 'package:apollo_lite/backend/locals/lang.dart';
import 'package:apollo_lite/backend/song_manager.dart';

import '/backend/components.dart';
import '/backend/constants.dart';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayingNow extends StatefulWidget {
  static const routeName = '/playingnow';
  const PlayingNow({Key? key}) : super(key: key);

  @override
  State<PlayingNow> createState() => _PlayingNowState();
}

class _PlayingNowState extends State<PlayingNow> with TickerProviderStateMixin {
  bool _isQueuePressed = false;
  double iconAngle = 0;
  double artH = .75;
  double artW = .9;
  late PageController _pController;

  final List<BoxShadow> buttonShadow0 = [
    BoxShadow(
      color: Colors.grey.shade900,
      offset: const Offset(1, 0),
      blurRadius: 5,
      spreadRadius: 2,
    ),
    BoxShadow(
      color: Colors.grey.shade500,
      offset: const Offset(-1, -1),
      blurRadius: 5,
      spreadRadius: 2,
    ),
  ];

  @override
  void initState() {
    _pController = PageController();

    super.initState();
  }

  void clickQueue() {
    setState(() {
      _isQueuePressed = !_isQueuePressed;
    });
    if (_isQueuePressed) {
      _pController.animateToPage(
        1,
        duration: const Duration(milliseconds: 50),
        curve: Curves.decelerate,
      );
    } else {
      _pController.animateToPage(0, duration: const Duration(milliseconds: 50), curve: Curves.decelerate);
    }
  }

  void swipeHandler(String dir, pm) {
    if (dir == 'left') {
      if (pm.isLastSongNotifier.value) {
        return;
      } else {
        pm.onNextSongButtonPressed;
      }
    } else {
      if (pm.isFirstSongNotifier.value) {
        return;
      } else {
        pm.onPreviousSongButtonPressed;
      }
    }
  }

  @override
  void dispose() {
    _pController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pageManager = Provider.of<PageManager>(context);
    final currentSongTitle = CurrentSongTitle(
      pageManager: pageManager,
      style: songTitleStyle.copyWith(fontSize: 22, color: whitey),
    );
    final currentSongArtist = CurrentSongArtist(
      pageManager: pageManager,
      style: songArtistStyle.copyWith(fontSize: 19, color: whitey),
    );
    final currentId = pageManager.currentSongIdNotifier.value;

    final currentList = pageManager.selectedListTitles;
    final sArtists = pageManager.selectedListArtists;
    final sIds = pageManager.selectedListIds;
    final lang = Languages.of(context);
    return Scaffold(
      backgroundColor: dblue.withOpacity(.5),
      resizeToAvoidBottomInset: false,
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 75,
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: dblue.withOpacity(.15),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            // topLeft: Radius.circular(45),
            // topRight: Radius.circular(45),
            bottomLeft: Radius.circular(85),
            bottomRight: Radius.circular(85),
          ),
        ),
        title: Text(
          lang.playing,
          style: basStyle.copyWith(
            fontWeight: FontWeight.w500,
            letterSpacing: 10,
            fontSize: 18,
            color: whitey,
          ),
        ),
      ),

      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeIn,
              height: _isQueuePressed ? size.height * .225 : size.height * .45,
              width: _isQueuePressed ? size.width * .45 : size.width * .9,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      height: size.width * 8,
                      width: size.width * 8,
                      child: PlayingNowSongArtWork(pageManager: pageManager),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 42.0,
                      sigmaY: 40.0,
                      tileMode: TileMode.repeated,
                    ),
                    child: GestureDetector(
                      onTapCancel: () => setState(() {
                        artH = .75;
                        artW = .9;
                      }),
                      onTapDown: (d) => setState(() {
                        artH = .68;
                        artW = .88;
                      }),
                      onTapUp: (d) => setState(() {
                        artH = .75;
                        artW = .9;
                      }),
                      onVerticalDragUpdate: (details) {},
                      onHorizontalDragUpdate: (DragUpdateDetails details) {
                        if (details.delta.direction < 0) {
                          swipeHandler('right', pageManager);
                        }
                        if (details.delta.direction > 0) {
                          swipeHandler('left', pageManager);
                        }
                      },
                      onLongPress: () => showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            insetAnimationCurve: Curves.decelerate,
                            child: Container(
                              color: Colors.transparent,
                              width: size.width * .75,
                              child: SongMenuv4(id: currentId, size: size),
                            ),
                          );
                        },
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: size.width * artH,
                          width: size.width * artW,
                          child: CurrentSongArtWork(pageManager: pageManager),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height * .02),
          Expanded(
            child: PageView(
              scrollDirection: Axis.vertical,
              controller: _pController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Column(
                  children: [
                    Container(
                      height: size.height * .06,
                      width: size.width * .7,
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.symmetric(vertical: 20 / 2),
                      child: currentSongTitle,
                    ),
                    Container(
                      height: size.height * .05,
                      width: size.width * .7,
                      alignment: Alignment.topCenter,
                      //padding: EdgeInsets.symmetric(vertical: leftPad / 6),
                      child: currentSongArtist,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                      width: size.width * .9,
                      child: AudioProgressBar(
                        pageManager: pageManager,
                        barColor: whitey.withOpacity(.25),
                        timelabel: TimeLabelLocation.below,
                        thumbrad: 10.0,
                        barheight: 5.0,
                        timestyle: const TextStyle(color: whitey, fontSize: 14),
                      ),
                    ),
                    const Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: buttonShadow0,
                          ),
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: morningBlue.withOpacity(.4),
                            child: ShuffleButton(
                              size: 30.0,
                              color: whitey,
                              pageManager: pageManager,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: buttonShadow0,
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: morningBlue.withOpacity(.4),
                            child: PreviousSongButton(
                              pageManager: pageManager,
                              size: 45.0,
                              color: whitey,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: buttonShadow0,
                          ),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: morningBlue.withOpacity(.4),
                            child: PlayButton(pageManager: pageManager, size: 60.0, color: whitey),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: buttonShadow0,
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: morningBlue.withOpacity(.4),
                            child: NextSongButton(
                              pageManager: pageManager,
                              size: 45.0,
                              color: whitey,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: buttonShadow0,
                          ),
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: morningBlue.withOpacity(.4),
                            child: RepeatButton(
                              size: 30.0,
                              color: whitey,
                              pageManager: pageManager,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(flex: 2),
                    GestureDetector(
                      onTap: () => clickQueue(),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 35.0),
                        child: Icon(
                          Icons.expand_less_rounded,
                          color: whitey,
                          size: 34,
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => clickQueue(),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 35.0),
                        child: Icon(
                          Icons.expand_more_rounded,
                          color: whitey,
                          size: 34,
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * .45,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: currentList.isEmpty
                          ? Text(
                              lang.qEmpty,
                              style: bas2Style.copyWith(
                                fontSize: 18,
                                color: whitey,
                              ),
                            )
                          : ListView.separated(
                              itemCount: currentList.length,
                              shrinkWrap: false,
                              addAutomaticKeepAlives: true,
                              separatorBuilder: (ctx, i) => const SizedBox(height: 10),
                              itemBuilder: (ctx, i) => SongContainerv3(
                                h: size.width * .15,
                                w: 25.0,
                                title: currentList[i],
                                artist: sArtists[i],
                                icon: Icons.menu_open_rounded,
                                id: sIds[i],
                                size: size,
                                manager: pageManager,
                                func: () => pageManager.playPlaylistInd(
                                  currentList,
                                  sArtists,
                                  sIds,
                                  currentList[i],
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
