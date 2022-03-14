// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';
import 'package:apollo_lite/backend/locals/lang.dart';
import 'package:apollo_lite/pages/create_playlist.dart';
import 'package:apollo_lite/pages/playing_now.dart';

import 'widgets/play_button_notifier.dart';
import 'widgets/progress_notifier.dart';
import 'widgets/repeat_button_notifier.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'song_manager.dart';

class SongMenu extends StatelessWidget {
  const SongMenu({
    Key? key,
    required this.size,
    required this.title,
    required this.artist,
    required this.id,
  }) : super(key: key);

  final Size size;
  final String title;
  final String artist;
  final int id;

  @override
  Widget build(BuildContext context) {
    final _pageManager = Provider.of<PageManager>(context);
    final favIds = _pageManager.favSongIds;
    final playlists = _pageManager.playlists;
    final lang = Languages.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetAnimationCurve: Curves.decelerate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //  ARTWORK
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: size.width * 0.55,
              width: size.width * 0.55,
              child: SongArtWork(id: id),
            ),
          ),
          const SizedBox(height: 20 * 2),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 7.0,
                sigmaY: 7.0,
              ),
              child: Container(
                height: size.height * 0.45,
                width: size.height * 0.35,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    color: dblue.withOpacity(0.3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: size.height * 0.4,
                        height: 30,
                        child: title.length < 21
                            ? Text(
                                title,
                                style: songDetailStyle.copyWith(fontSize: 24),
                                textAlign: TextAlign.center,
                              )
                            : Marquee(
                                text: title,
                                style: songDetailStyle,
                                scrollAxis: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                blankSpace: 20.0,
                                velocity: 45.0,
                                pauseAfterRound: const Duration(seconds: 1),
                                accelerationDuration: const Duration(seconds: 1),
                                accelerationCurve: Curves.linear,
                                decelerationDuration: const Duration(milliseconds: 500),
                                decelerationCurve: Curves.bounceOut,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: size.height * 0.4,
                      height: 30,
                      child: artist.length < 20
                          ? Text(
                              artist,
                              style: songDetailStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                              textAlign: TextAlign.center,
                            )
                          : Marquee(
                              text: artist,
                              style: songDetailStyle.copyWith(fontWeight: FontWeight.bold),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              blankSpace: 20.0,
                              velocity: 45.0,
                              pauseAfterRound: const Duration(seconds: 1),
                              accelerationDuration: const Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: const Duration(milliseconds: 500),
                              decelerationCurve: Curves.bounceOut,
                            ),
                    ),
                    Divider(
                      height: 30,
                      thickness: 8,
                      color: dblue.withOpacity(.2),
                    ),
                    // ADD TO PLA
                    GestureDetector(
                      onTap: () {
                        if (favIds.contains(id)) {
                          _pageManager.removeFromFav(id);
                          bildirim(context, lang.remFav2);
                        } else {
                          _pageManager.add2Fav(id);
                          bildirim(
                            context,
                            lang.addFav2,
                          );
                        }
                        _pageManager.getFavIds();
                        _pageManager.initID2Song();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          favIds.contains(id) ? const Icon(Icons.favorite, color: Colors.redAccent, size: 28) : const Icon(Icons.favorite_border_rounded, color: dblue, size: 28),
                          const SizedBox(width: 20),
                          Text(
                            !favIds.contains(id) ? lang.addFav1 : lang.remFav1,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.pop(context),
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 8.0,
                                sigmaY: 8.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: dblue.withOpacity(0.3)),
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(lang.playlists, style: basStyle),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      height: size.height * .4,
                                      width: size.width * .8,
                                      child: _pageManager.playlists.length == 0
                                          ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                              Text(lang.noPlaylists, style: bas2Style.copyWith(fontSize: 21)),
                                              const SizedBox(height: 20),
                                              Container(
                                                width: size.width * .6,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: brown1,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                padding: const EdgeInsets.all(20.0),
                                                child: GestureDetector(
                                                    onTap: () => {Navigator.of(context).pop(), Navigator.pushNamed(context, CreatePlaylistPage.routeName)},
                                                    child: Text(
                                                      lang.libToolTip,
                                                      style: basStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 21),
                                                    )),
                                              )
                                            ])
                                          : ListView.separated(
                                              physics: const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) => ListTile(
                                                leading: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () => {_pageManager.add2Playlist(playlists[index].id, id), Navigator.pop(context), bildirim(context, '${lang.addSongTo} ${playlists[index].playlist}')},
                                                  icon: const Icon(Icons.add, size: 28, color: dblue),
                                                ),
                                                title: SizedBox(
                                                  width: 200,
                                                  height: 30,
                                                  child: Text(
                                                    playlists[index].playlist,
                                                    style: bas2Style,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                dense: true,
                                                onTap: () => {_pageManager.add2Playlist(playlists[index].id, id), Navigator.pop(context), bildirim(context, '${lang.addSongTo} ${playlists[index].playlist}')},
                                              ),
                                              separatorBuilder: (context, index) => const SizedBox(height: 20),
                                              itemCount: playlists.length,
                                              scrollDirection: Axis.vertical,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.music_note, color: dblue, size: 28),
                          const SizedBox(width: 20 / 2),
                          SizedBox(
                            width: size.width * .42,
                            child: Text(
                              lang.addToPla,
                              style: const TextStyle(fontSize: 21, color: Colors.white),
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MusicContainer extends StatelessWidget {
  const MusicContainer({
    Key? key,
    required this.size,
    required this.img,
    required this.name,
    required this.artist,
  }) : super(key: key);

  final Size size;
  final img;
  final artist;
  final name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width * .35,
      width: size.width * .2,
      decoration: BoxDecoration(
        color: dblue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          SizedBox(
            height: 120,
            width: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 130,
                  width: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: img,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 120,
                    width: 120,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              color: dblue,
              fontFamily: 'Roboto',
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key, @required this.pageManager, @required this.barColor, @required this.timelabel, this.timestyle, @required this.thumbrad, @required this.barheight}) : super(key: key);
  final pageManager;
  final barColor;
  final timelabel;
  final timestyle;
  final thumbrad;
  final barheight;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: pageManager.seek,
          baseBarColor: barColor,
          bufferedBarColor: Colors.transparent,
          progressBarColor: whitey.withOpacity(.8),
          barHeight: barheight,
          thumbRadius: thumbrad,
          thumbColor: whitey.withOpacity(.9),
          timeLabelLocation: timelabel,
          timeLabelTextStyle: timestyle,
          timeLabelType: TimeLabelType.remainingTime,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key, @required this.pageManager, required this.size, required this.color}) : super(key: key);
  final pageManager;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return IconButton(
              color: color,
              enableFeedback: true,
              icon: const Icon(Icons.stop_rounded),
              iconSize: size,
              onPressed: pageManager.pause,
            );
          case ButtonState.paused:
            return IconButton(
              color: color,
              icon: const Icon(Icons.play_arrow_rounded),
              iconSize: size,
              onPressed: pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              color: color,
              icon: const Icon(Icons.pause_rounded),
              iconSize: size,
              onPressed: pageManager.pause,
            );
        }
      },
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key, @required this.pageManager, required this.style}) : super(key: key);
  final pageManager;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    final lang = Languages.of(context);
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return title.length < 25
            ? Text(
                title.isEmpty ? lang.notPlaying : title,
                style: title.isEmpty ? songDetailStyle.copyWith(fontSize: 19) : style,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              )
            : Marquee(
                text: title,
                style: style,
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: 20.0,
                velocity: 30.0,
                pauseAfterRound: const Duration(seconds: 1),
                accelerationDuration: const Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: const Duration(milliseconds: 500),
                decelerationCurve: Curves.decelerate,
              );
      },
    );
  }
}

class CurrentSongArtist extends StatelessWidget {
  const CurrentSongArtist({Key? key, @required this.pageManager, required this.style}) : super(key: key);
  final pageManager;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongArtistNotifier,
      builder: (_, title, __) {
        return title.length < 25
            ? Text(
                title,
                style: style,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              )
            : Marquee(
                text: title,
                style: style,
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: 20.0,
                velocity: 30.0,
                pauseAfterRound: const Duration(seconds: 1),
                accelerationDuration: const Duration(seconds: 1),
                accelerationCurve: Curves.linear,
                decelerationDuration: const Duration(milliseconds: 500),
                decelerationCurve: Curves.decelerate,
              );
      },
    );
  }
}

class CurrentSongArtWork extends StatelessWidget {
  const CurrentSongArtWork({
    Key? key,
    @required this.pageManager,
  }) : super(key: key);
  final pageManager;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: pageManager.currentSongIdNotifier,
      builder: (_, id, __) {
        return QueryArtworkWidget(
          id: id,
          type: ArtworkType.AUDIO,
          nullArtworkWidget: defaultPlaylistArt,
          keepOldArtwork: true,
          format: ArtworkFormat.JPEG,
          artworkRepeat: ImageRepeat.noRepeat,
          size: 950,
          artworkFit: BoxFit.cover,
          artworkQuality: FilterQuality.medium,
          frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return AnimatedOpacity(
              child: child,
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeIn,
            );
          },
        );
      },
    );
  }
}

class PlayingNowSongArtWork extends StatelessWidget {
  const PlayingNowSongArtWork({
    Key? key,
    @required this.pageManager,
  }) : super(key: key);
  final pageManager;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: pageManager.currentSongIdNotifier,
      builder: (_, id, __) {
        return QueryArtworkWidget(
          id: id,
          type: ArtworkType.AUDIO,
          keepOldArtwork: true,
          format: ArtworkFormat.JPEG,
          artworkRepeat: ImageRepeat.noRepeat,
          size: 950,
          artworkFit: BoxFit.cover,
          artworkQuality: FilterQuality.medium,
          frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return AnimatedOpacity(
              child: child,
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
            );
          },
        );
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({
    Key? key,
    @required this.pageManager,
    required this.size,
    required this.color,
  }) : super(key: key);
  final pageManager;
  final size;
  final color;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.skip_next_rounded, size: size, color: color),
          onPressed: (isLast) ? null : pageManager.onNextSongButtonPressed,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({
    Key? key,
    @required this.pageManager,
    required this.size,
    required this.color,
  }) : super(key: key);
  final pageManager;
  final size;
  final color;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.skip_previous_rounded, size: size, color: color),
          onPressed: (isFirst) ? null : pageManager.onPreviousSongButtonPressed,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key, this.pageManager, this.size, this.color}) : super(key: key);
  final pageManager;
  final size;
  final color;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          padding: EdgeInsets.zero,
          icon: (isEnabled)
              ? Icon(
                  Icons.shuffle_on_rounded,
                  size: size,
                  color: color,
                )
              : Icon(
                  Icons.shuffle_rounded,
                  size: size,
                  color: color,
                ),
          onPressed: pageManager.onShuffleButtonPressed,
        );
      },
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key, this.pageManager, this.size, this.color}) : super(key: key);
  final pageManager;
  final size;
  final color;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(Icons.repeat, color: color, size: size);
            break;
          case RepeatState.repeatSong:
            icon = Icon(Icons.repeat_one_on_rounded, color: color, size: size);
            break;
          case RepeatState.repeatPlaylist:
            icon = Icon(Icons.repeat_on_rounded, color: color, size: size);
            break;
        }
        return IconButton(
          icon: icon,
          padding: EdgeInsets.zero,
          onPressed: pageManager.onRepeatButtonPressed,
        );
      },
    );
  }
}

class SongContainer extends StatelessWidget {
  const SongContainer({
    Key? key,
    required this.isHome,
    this.h,
    this.w,
    this.title,
    this.artist,
    this.id,
    this.size,
    this.manager,
    this.func,
    this.icon,
  }) : super(key: key);
  final bool isHome;
  final h;
  final w;
  final title;
  final artist;
  final id;
  final size;
  final manager;
  final func;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h,
      width: w,
      alignment: Alignment.center,
      child: ListTile(
        onLongPress: () {
          isHome
              ? showDialog(
                  context: context,
                  builder: (context) {
                    return SongMenu(
                      title: title,
                      artist: artist.toString(),
                      id: id,
                      size: size,
                    );
                  },
                )
              : showDialog(
                  context: context,
                  builder: (context) {
                    return SongMenuv3(
                      title: title,
                      artist: artist.toString(),
                      id: id,
                      size: size,
                    );
                  },
                );
        },
        onTap: func,
        trailing: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            icon,
            color: dblue,
            size: 28,
          ),
          onPressed: () {
            isHome
                ? showDialog(
                    context: context,
                    builder: (context) {
                      return SongMenu(
                        title: title,
                        artist: artist.toString(),
                        id: id,
                        size: size,
                      );
                    },
                  )
                : showDialog(
                    context: context,
                    builder: (context) {
                      return SongMenuv3(
                        title: title,
                        artist: artist.toString(),
                        id: id,
                        size: size,
                      );
                    },
                  );
          },
        ),
        title: SizedBox(
          width: 200,
          height: 30,
          child: Text(
            title,
            style: title == manager.currentSongTitleNotifier.value ? songTitleStyle.copyWith(color: brown3) : songTitleStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: SizedBox(
          width: 200,
          height: 22,
          child: Text(
            artist.toString(),
            style: title == manager.currentSongTitleNotifier.value ? songArtistStyle.copyWith(color: brown3) : songArtistStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        dense: true,
      ),
    );
  }
}

class AltBar extends StatefulWidget {
  const AltBar({
    Key? key,
    required this.manager,
    required this.func,
    required this.size,
    required this.h,
  }) : super(key: key);

  final PageManager manager;
  final Function func;
  final Size size;
  final double h;

  @override
  State<AltBar> createState() => _AltBarState();
}

class _AltBarState extends State<AltBar> with SingleTickerProviderStateMixin {
  final _maxHeight = 450.0;
  final _minHeight = 120.0;
  bool _isExpanded = false;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _currentHeight = 120.0;
  @override
  Widget build(BuildContext context) {
    final menuWidth = widget.size.width * .85;
    return AnimatedOpacity(
      opacity: widget.h,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeIn,
      child: GestureDetector(
        onVerticalDragUpdate: _isExpanded
            ? (details) {
                setState(() {
                  final newHeight = _currentHeight - details.delta.dy;
                  _controller.value = _currentHeight / _maxHeight;
                  _currentHeight = newHeight.clamp(_minHeight, _maxHeight);
                });
              }
            : null,
        onVerticalDragEnd: _isExpanded
            ? (details) {
                if (_currentHeight < _maxHeight / 2) {
                  _controller.reverse();
                  _isExpanded = false;
                } else {
                  _isExpanded = true;
                  _controller.forward(from: _currentHeight / _maxHeight);
                  setState(() {
                    _currentHeight = _maxHeight;
                  });
                }
              }
            : null,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            final value = const ElasticOutCurve(1.7).transform(_controller.value);
            return Stack(
              children: [
                Positioned(
                  height: lerpDouble(_minHeight, _currentHeight, value),
                  width: lerpDouble(menuWidth, widget.size.width, value),
                  left: lerpDouble(widget.size.width / 2 - menuWidth / 2, 0, value),
                  bottom: lerpDouble(20.0, 0.0, value),
                  child: _isExpanded ? _buildExpandedContent() : _buildMenuContent(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0, left: 8, right: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 450),
        curve: Curves.decelerate,
        height: _maxHeight,
        width: widget.size.width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: morningBlue,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: widget.h != 0
              ? [
                  BoxShadow(spreadRadius: 10, blurRadius: 35, color: dblue.withOpacity(.7), offset: const Offset(0, 15)),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = false;
                          _currentHeight = _maxHeight;
                        });
                        _controller.reverse();
                      },
                      child: const Icon(Icons.expand_more_rounded, size: 34)),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = false;
                          _currentHeight = _maxHeight;
                        });
                        _controller.reverse();
                        Navigator.of(context).pushNamed(PlayingNow.routeName);
                      },
                      child: const Icon(Icons.fullscreen_rounded, size: 34)),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: widget.size.width * .5,
                  width: widget.size.width * .5,
                  child: widget.manager.currentSongTitleNotifier.value.isEmpty ? defaultPlaylistArt : CurrentSongArtWork(pageManager: widget.manager),
                ),
              ),
              const SizedBox(height: 15),
              CurrentSongTitle(
                pageManager: widget.manager,
                style: songTitleStyle.copyWith(color: dblue, fontSize: 21),
              ),
              CurrentSongArtist(
                pageManager: widget.manager,
                style: songArtistStyle.copyWith(color: dblue, fontSize: 18),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: widget.size.width * .8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PreviousSongButton(pageManager: widget.manager, size: 50.0, color: dblue),
                    PlayButton(pageManager: widget.manager, size: 50.0, color: dblue),
                    NextSongButton(pageManager: widget.manager, size: 50.0, color: dblue),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuContent() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = true;
          _currentHeight = _maxHeight;
        });
        _controller.forward(from: 0.0);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: morningBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10), bottom: Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PreviousSongButton(pageManager: widget.manager, size: 50.0, color: dblue),
                PlayButton(pageManager: widget.manager, size: 50.0, color: dblue),
                NextSongButton(pageManager: widget.manager, size: 50.0, color: dblue),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: widget.size.height * 0.05,
              width: widget.size.width * .70,
              child: AudioProgressBar(pageManager: widget.manager, barColor: dblue, thumbrad: 10.0, barheight: 5.0, timelabel: TimeLabelLocation.none),
            ),
          ],
        ),
      ),
    );
  }
}

class AlbumArtWork extends StatelessWidget {
  const AlbumArtWork({
    Key? key,
    @required this.id,
  }) : super(key: key);

  final id;
  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: id,
      type: ArtworkType.ALBUM,
      nullArtworkWidget: defaultPlaylistArt,
      keepOldArtwork: true,
      artworkClipBehavior: Clip.antiAlias,
      artworkRepeat: ImageRepeat.noRepeat,
      format: ArtworkFormat.JPEG,
      artworkFit: BoxFit.cover,
      size: 350,
      artworkQuality: FilterQuality.medium,
      frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          child: child,
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      },
    );
  }
}

class SongArtWork extends StatelessWidget {
  const SongArtWork({
    Key? key,
    @required this.id,
  }) : super(key: key);

  final id;
  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: id,
      type: ArtworkType.AUDIO,
      nullArtworkWidget: defaultPlaylistArt,
      keepOldArtwork: true,
      format: ArtworkFormat.JPEG,
      artworkFit: BoxFit.cover,
      size: 750,
      artworkQuality: FilterQuality.medium,
      frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          child: child,
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeIn,
        );
      },
    );
  }
}

class Cover extends StatelessWidget {
  const Cover({
    Key? key,
    @required this.id,
  }) : super(key: key);

  final id;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        height: 250,
        width: 450,
        child: QueryArtworkWidget(
          id: id,
          type: ArtworkType.AUDIO,
          nullArtworkWidget: defaultPlaylistArt,
          keepOldArtwork: true,
          format: ArtworkFormat.JPEG,
          artworkFit: BoxFit.fitHeight,
          size: 1000,
          artworkQuality: FilterQuality.high,
          frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return AnimatedOpacity(
              child: child,
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
            );
          },
        ),
      ),
    );
  }
}

class SongContainerv2 extends StatelessWidget {
  const SongContainerv2({
    Key? key,
    this.h,
    this.w,
    this.title,
    this.artist,
    this.id,
    this.size,
    this.manager,
    this.func,
  }) : super(key: key);

  final h;
  final w;
  final title;
  final artist;
  final id;
  final size;
  final manager;
  final func;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h,
      width: w,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.zero,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        enableFeedback: true,
        title: Text(
          title,
          style: songTitleStyle,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          artist.toString(),
          style: songArtistStyle,
          overflow: TextOverflow.ellipsis,
        ),
        dense: true,
        isThreeLine: true,
        onTap: title != manager.currentSongTitleNotifier.value ? func : null,
      ),
    );
  }
}

class SongMenuv2 extends StatelessWidget {
  const SongMenuv2({
    Key? key,
    required this.size,
    required this.id,
  }) : super(key: key);

  final Size size;

  final int id;

  @override
  Widget build(BuildContext context) {
    final _pageManager = Provider.of<PageManager>(context);
    final lang = Languages.of(context);
    final favIds = _pageManager.favSongIds;
    final playlists = _pageManager.playlists;
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.8,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(thickness: 2, color: dblue.withOpacity(.3), height: 15),
          const SizedBox(height: 10),
          SizedBox(
            width: size.width * 0.8,
            child: GestureDetector(
              onTap: () {
                if (favIds.contains(id)) {
                  _pageManager.removeFromFav(id);
                  bildirim(context, lang.remFav2);
                } else {
                  _pageManager.add2Fav(id);
                  bildirim(
                    context,
                    lang.addFav2,
                  );
                }
                _pageManager.getFavIds();
                _pageManager.initID2Song();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  favIds.contains(id) ? const Icon(Icons.favorite, color: Colors.redAccent, size: 28) : const Icon(Icons.favorite_border_rounded, color: dblue, size: 28),
                  const SizedBox(width: 10),
                  Text(
                    !favIds.contains(id) ? lang.addFav1 : lang.remFav1,
                    style: const TextStyle(
                      fontSize: 18,
                      color: onyx,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => {
              Navigator.pop(context),
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 8.0,
                      sigmaY: 8.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: whitey.withOpacity(0.3)),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(lang.playlists, style: basStyle),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: size.height * .3,
                            width: size.width * .8,
                            child: _pageManager.playlists.length == 0
                                ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Text(lang.noPlaylists, style: bas2Style.copyWith(fontSize: 21)),
                                    const SizedBox(height: 20),
                                    Container(
                                      width: size.width * .6,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: whitey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(20.0),
                                      child: GestureDetector(
                                          onTap: () => {Navigator.of(context).pop(), Navigator.pushNamed(context, CreatePlaylistPage.routeName)},
                                          child: Text(
                                            lang.libToolTip,
                                            style: basStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 21),
                                          )),
                                    )
                                  ])
                                : ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => ListTile(
                                      leading: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () => {_pageManager.add2Playlist(playlists[index].id, id), Navigator.pop(context), bildirim(context, '${lang.addSongTo} ${playlists[index].playlist}')},
                                        icon: const Icon(Icons.add, size: 28, color: dblue),
                                      ),
                                      title: SizedBox(
                                        width: 200,
                                        height: 30,
                                        child: Text(
                                          playlists[index].playlist,
                                          style: bas2Style,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      dense: true,
                                      onTap: () => {_pageManager.add2Playlist(playlists[index].id, id), Navigator.pop(context), bildirim(context, '${lang.addSongTo} ${playlists[index].playlist}')},
                                    ),
                                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                                    itemCount: playlists.length,
                                    scrollDirection: Axis.vertical,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.music_note, color: dblue, size: 28),
                const SizedBox(height: 10),
                Text(
                  lang.addToPla,
                  style: const TextStyle(fontSize: 18, overflow: TextOverflow.clip, color: onyx),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SongMenuv3 extends StatelessWidget {
  const SongMenuv3({
    Key? key,
    required this.size,
    required this.title,
    required this.artist,
    required this.id,
  }) : super(key: key);

  final Size size;
  final String title;
  final String artist;
  final int id;

  @override
  Widget build(BuildContext context) {
    final _pageManager = Provider.of<PageManager>(context);
    final favIds = _pageManager.favSongIds;
    final playlists = _pageManager.playlists;
    final lang = Languages.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetAnimationCurve: Curves.decelerate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 7.0,
                sigmaY: 7.0,
              ),
              child: Container(
                height: size.height * 0.5,
                width: size.height * 0.4,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: whitey.withOpacity(0.3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: size.height * 0.4,
                        height: 30,
                        child: title.length < 21
                            ? Text(
                                title,
                                style: songDetailStyle,
                                textAlign: TextAlign.center,
                              )
                            : Marquee(
                                text: title,
                                style: songDetailStyle,
                                scrollAxis: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                blankSpace: 20.0,
                                velocity: 45.0,
                                pauseAfterRound: const Duration(seconds: 1),
                                accelerationDuration: const Duration(seconds: 1),
                                accelerationCurve: Curves.linear,
                                decelerationDuration: const Duration(milliseconds: 500),
                                decelerationCurve: Curves.bounceOut,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: size.height * 0.4,
                      height: 30,
                      child: artist.length < 20
                          ? Text(
                              artist,
                              style: songDetailStyle.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          : Marquee(
                              text: artist,
                              style: songDetailStyle.copyWith(fontWeight: FontWeight.bold),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              blankSpace: 20.0,
                              velocity: 45.0,
                              pauseAfterRound: const Duration(seconds: 1),
                              accelerationDuration: const Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: const Duration(milliseconds: 500),
                              decelerationCurve: Curves.bounceOut,
                            ),
                    ),
                    Divider(
                      height: 30,
                      thickness: 8,
                      color: dblue.withOpacity(.2),
                    ),
                    // ADD TO PLA
                    GestureDetector(
                      onTap: () {
                        if (favIds.contains(id)) {
                          _pageManager.removeFromFav(id);
                          bildirim(context, lang.remFav2);
                        } else {
                          _pageManager.add2Fav(id);
                          bildirim(
                            context,
                            lang.addFav2,
                          );
                        }
                        _pageManager.getFavIds();
                        _pageManager.initID2Song();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          favIds.contains(id) ? const Icon(Icons.favorite, color: Colors.redAccent, size: 28) : const Icon(Icons.favorite_border_rounded, color: dblue, size: 28),
                          const SizedBox(width: 20),
                          Text(
                            !favIds.contains(id) ? lang.addFav1 : lang.remFav1,
                            style: const TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        Navigator.pop(context),
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 8.0,
                                sigmaY: 8.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: brown1.withOpacity(0.3)),
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(lang.playlists, style: basStyle),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      height: size.height * .4,
                                      width: size.width * .8,
                                      child: _pageManager.playlists.length == 0
                                          ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                              Text(lang.noPlaylists, style: bas2Style.copyWith(fontSize: 21)),
                                              const SizedBox(height: 20),
                                              Container(
                                                width: size.width * .6,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: brown3,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                padding: const EdgeInsets.all(20.0),
                                                child: GestureDetector(
                                                    onTap: () => {Navigator.of(context).pop(), Navigator.pushNamed(context, CreatePlaylistPage.routeName)},
                                                    child: Text(
                                                      lang.libToolTip,
                                                      style: basStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 21),
                                                    )),
                                              )
                                            ])
                                          : ListView.separated(
                                              physics: const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) => ListTile(
                                                leading: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () => {_pageManager.add2Playlist(playlists[index].id, id), Navigator.pop(context), bildirim(context, '${lang.addSongTo} ${playlists[index].playlist}')},
                                                  icon: const Icon(Icons.add, size: 28, color: dblue),
                                                ),
                                                title: SizedBox(
                                                  width: 200,
                                                  height: 30,
                                                  child: Text(
                                                    playlists[index].playlist,
                                                    style: bas2Style,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                dense: true,
                                                onTap: () => {_pageManager.add2Playlist(playlists[index].id, id), Navigator.pop(context), bildirim(context, '${lang.addSongTo} ${playlists[index].playlist}')},
                                              ),
                                              separatorBuilder: (context, index) => const SizedBox(height: 20),
                                              itemCount: playlists.length,
                                              scrollDirection: Axis.vertical,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.music_note, color: dblue, size: 28),
                          const SizedBox(width: 20 / 2),
                          SizedBox(
                            width: size.width * .40,
                            child: Text(
                              lang.addToPla,
                              style: const TextStyle(fontSize: 21, color: Colors.white),
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SongMenuv4 extends StatelessWidget {
  const SongMenuv4({
    Key? key,
    required this.size,
    required this.id,
  }) : super(key: key);

  final Size size;

  final int id;

  @override
  Widget build(BuildContext context) {
    final _pageManager = Provider.of<PageManager>(context);
    final lang = Languages.of(context);
    final favIds = _pageManager.favSongIds;
    final playlists = _pageManager.playlists;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (favIds.contains(id)) {
              _pageManager.removeFromFav(id);
              bildirim(context, lang.remFav2);
            } else {
              _pageManager.add2Fav(id);
              bildirim(
                context,
                lang.addFav2,
              );
            }
            _pageManager.getFavIds();
            _pageManager.initID2Song();
            Navigator.pop(context);
          },
          child: Container(
            decoration: const BoxDecoration(
              color: morningBlue,
              shape: BoxShape.circle,
            ),
            height: 75,
            width: 75,
            child: favIds.contains(id) ? const Icon(Icons.favorite, color: Colors.redAccent, size: 34) : const Icon(Icons.favorite_border_rounded, color: whitey, size: 34),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => {
            Navigator.pop(context),
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 8.0,
                    sigmaY: 8.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: whitey.withOpacity(0.3)),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(lang.playlists, style: basStyle),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: size.height * .3,
                          width: size.width * .8,
                          child: _pageManager.playlists.length == 0
                              ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  Text(lang.noPlaylists, style: bas2Style.copyWith(fontSize: 21)),
                                  const SizedBox(height: 20),
                                  Container(
                                    width: size.width * .6,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: whitey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                        onTap: () => {Navigator.of(context).pop(), Navigator.pushNamed(context, CreatePlaylistPage.routeName)},
                                        child: Text(
                                          lang.libToolTip,
                                          style: basStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 21),
                                        )),
                                  )
                                ])
                              : ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => ListTile(
                                    leading: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () => {_pageManager.add2Playlist(playlists[index].id, id), Navigator.pop(context), bildirim(context, '${lang.addSongTo} ${playlists[index].playlist}')},
                                      icon: const Icon(Icons.add, size: 28, color: dblue),
                                    ),
                                    title: SizedBox(
                                      width: 200,
                                      height: 30,
                                      child: Text(
                                        playlists[index].playlist,
                                        style: bas2Style,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    dense: true,
                                    onTap: () => {_pageManager.add2Playlist(playlists[index].id, id), Navigator.pop(context), bildirim(context, '${lang.addSongTo} ${playlists[index].playlist}')},
                                  ),
                                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                                  itemCount: playlists.length,
                                  scrollDirection: Axis.vertical,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          },
          child: Container(
              decoration: const BoxDecoration(
                color: morningBlue,
                shape: BoxShape.circle,
              ),
              height: 75,
              width: 75,
              child: const Icon(Icons.library_add_rounded, color: whitey, size: 30)),
        ),
      ],
    );
  }
}

class SongContainerv3 extends StatelessWidget {
  const SongContainerv3({
    Key? key,
    this.h,
    this.w,
    this.title,
    this.artist,
    this.id,
    this.size,
    this.manager,
    this.func,
    this.icon,
  }) : super(key: key);

  final h;
  final w;
  final title;
  final artist;
  final id;
  final size;
  final manager;
  final func;

  final icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h,
      width: w,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey.shade500),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        enableFeedback: true,
        title: Text(
          title,
          style: songTitleStyle.copyWith(color: whitey),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          artist.toString(),
          style: songArtistStyle.copyWith(color: whitey),
          overflow: TextOverflow.ellipsis,
        ),
        dense: true,
        isThreeLine: true,
        onTap: title != manager.currentSongTitleNotifier.value ? func : null,
      ),
    );
  }
}

class PlaylistContainer extends StatelessWidget {
  const PlaylistContainer({
    Key? key,
    required this.size,
    required this.img,
    required this.name,
    required this.length,
  }) : super(key: key);
  final Size size;
  final img;
  final int length;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
            offset: const Offset(1, 1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
          const BoxShadow(
            color: whitey,
            offset: Offset(-1, -1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      height: 130,
      child: Row(
        children: [
          const SizedBox(width: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(4, 3),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            height: size.width * .26,
            width: size.width * .28,
            child: ClipRRect(
              child: img,
              borderRadius: BorderRadius.circular(35),
            ),
          ), // Img of playlist
          const Spacer(flex: 1),
          Text(name, style: songDetailStyle.copyWith(color: dblue)), // name of the playlist
          const Spacer(flex: 1),
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.keyboard_arrow_right_rounded, size: 34),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

bildirim(context, text) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
        ),
        backgroundColor: dblue,
        margin: const EdgeInsets.only(bottom: 80),
      ),
    );
