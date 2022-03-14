// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_this

import 'dart:io';

import 'package:apollo_lite/backend/components.dart';
import 'package:apollo_lite/backend/constants.dart';
import 'package:apollo_lite/backend/locals/lang.dart';
import 'package:apollo_lite/backend/song_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditPlaylistPage extends StatefulWidget {
  const EditPlaylistPage({required this.artwork, required this.listname, required this.playlistlen, required this.pagemanager, Key? key, required this.playlistsong, required this.playlistIds, required this.playlistarti, required this.listid}) : super(key: key);
  final artwork;
  final List<String> playlistsong;
  final List<int> playlistIds;
  final List<String> playlistarti;
  final String listname;
  final int listid;
  final int playlistlen;
  final PageManager pagemanager;

  @override
  _EditPlaylistPageState createState() => _EditPlaylistPageState();
}

class _EditPlaylistPageState extends State<EditPlaylistPage> {
  late final ImagePicker _imgPicker;
  // ignore: unused_field
  late final _textController;
  Image image = defaultPlaylistArt;
  String? imgPath;
  List selected = [];
  final String _newPlaylistName = " ";
  final bool _isNameSet = false;

  @override
  void initState() {
    _imgPicker = ImagePicker();
    _textController = TextEditingController();
    super.initState();
  }

  void enterDelMode(index) {
    setState(() {
      selected.add(index.toInt());
    });
  }

  void exitDelMode(index) {
    setState(() {
      selected.remove(index.toInt());
    });
  }

  Future pickImg() async {
    try {
      final img = await _imgPicker.pickImage(source: ImageSource.gallery);
      if (img == null) return;
      final imageTemporary = File(img.path);
      //final imagePermanent = await saveImagePermanently(image.path);
      setState(() {
        this.imgPath = img.path;
        this.image = Image.file(
          imageTemporary,
          fit: BoxFit.fitHeight,
        );
      });
    } on PlatformException catch (e) {
      bildirim(context, 'Failed to pick an image: $e');
    }
  }

  // @override
  // void dispose() {
  //   _textController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lang = Languages.of(context);
    final List tempListTitles = widget.playlistsong;
    final List tempListArti = widget.playlistarti;
    //final List newListIds = widget.playlistIds;
    List newListIds = [];
    final _pageManager = Provider.of<PageManager>(context);
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: CustomScrollView(physics: const BouncingScrollPhysics(), shrinkWrap: false, slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: morningBlue,
            forceElevated: false,
            expandedHeight: 250,
            centerTitle: false,
            pinned: false,
            automaticallyImplyLeading: false,
            shadowColor: whitey.withAlpha(10),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, right: 20, left: 20),
                child: GestureDetector(
                  child: Text(lang.done, style: songTitleStyle.copyWith(color: onyx, fontWeight: FontWeight.bold)),
                  onTap: () async => {
                    // Future.delayed(
                    //   Duration(milliseconds: 200),
                    //   () => Navigator.pop(context),
                    // ),
                    Navigator.pop(context),
                    if (selected.isNotEmpty)
                      {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(lang.remSongFromPla, style: songTitleStyle.copyWith(fontSize: 21, fontWeight: FontWeight.bold)),
                            backgroundColor: morningBlue,
                            actions: [
                              TextButton(
                                onPressed: () => {Navigator.pop(context)},
                                child: Text(
                                  lang.cancel,
                                  style: songTitleStyle.copyWith(color: whitey, fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  for (var item in selected) {newListIds.add(widget.playlistIds[item])},
                                  //if (_isNameSet == true) {_pageManager.renamePlaylist(widget.listid, _newPlaylistName)},
                                  if (imgPath != null) {_pageManager.editPlaylistArt(widget.listname, imgPath)},
                                  _pageManager.removeFromPlaylist(widget.listid, widget.listname, newListIds),
                                  Navigator.pop(context),
                                },
                                child: Text('lang.confirm', style: songTitleStyle.copyWith(color: whitey, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      }
                    else
                      {
                        if (imgPath != null)
                          {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(lang.changeCoverPla, style: songTitleStyle.copyWith(fontSize: 21, fontWeight: FontWeight.bold)),
                                backgroundColor: morningBlue,
                                actions: [
                                  TextButton(
                                    onPressed: () => {Navigator.pop(context)},
                                    child: Text(
                                      lang.cancel,
                                      style: songTitleStyle.copyWith(color: whitey, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      //if (_isNameSet == true) {_pageManager.renamePlaylist(widget.listid, _newPlaylistName)},
                                      _pageManager.editPlaylistArt(widget.listname, imgPath),
                                      Navigator.pop(context),
                                    },
                                    child: Text(lang.confirm, style: songTitleStyle.copyWith(color: whitey, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          }
                        else
                          {
                            //if (_isNameSet == true) {_pageManager.renamePlaylist(widget.listid, _newPlaylistName)},
                          },
                      },
                  },
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        imgPath != null
                            ? SizedBox(
                                height: size.width * 0.44,
                                width: size.width * 0.44,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: image,
                                ),
                              )
                            : Container(
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
                        Container(
                          height: size.width * 0.25,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: morningBlue.withOpacity(.5),
                          ),
                          child: GestureDetector(
                            onTap: () => pickImg(),
                            child: Icon(Icons.edit, color: whitey.withAlpha(220), size: 60),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      _isNameSet ? _newPlaylistName : widget.listname,
                      style: bas2Style.copyWith(
                        color: onyx.withAlpha(220),
                        fontSize: 26,
                        overflow: TextOverflow.fade,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 40),
                widget.playlistlen == 0
                    ? Text(
                        'lang.textPla',
                        style: bas2Style.copyWith(fontSize: 21),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        addAutomaticKeepAlives: false,
                        itemBuilder: (context, index) => Container(
                          height: size.width * .20,
                          width: size.width * .85,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: selected.contains(index)
                                ? [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      blurRadius: 5,
                                      blurStyle: BlurStyle.inner,
                                      offset: const Offset(2, 2),
                                      spreadRadius: -1,
                                    ),
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 5,
                                      spreadRadius: -8,
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.grey.shade700,
                                      offset: const Offset(1, 1),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                    const BoxShadow(
                                      color: Colors.white70,
                                      offset: Offset(-1, -1),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ],
                          ),
                          child: ListTile(
                            tileColor: selected.contains(index) ? ashGray.withOpacity(.8) : Colors.transparent,
                            horizontalTitleGap: 20,
                            trailing: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                selected.contains(index) ? Icons.check : Icons.cancel_outlined,
                                color: onyx,
                                size: 28,
                              ),
                              onPressed: () => {
                                selected.contains(index) ? exitDelMode(index) : enterDelMode(index),
                              },
                            ),
                            title: SizedBox(
                              width: size.width * .55,
                              height: 30,
                              child: Text(
                                tempListTitles[index],
                                style: songTitleStyle.copyWith(fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            subtitle: SizedBox(
                              width: size.width * .45,
                              height: 22,
                              child: Text(
                                tempListArti[index].toString(),
                                style: songArtistStyle.copyWith(fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            onLongPress: () => selected.contains(index) ? exitDelMode(index) : enterDelMode(index),
                            onTap: () => selected.contains(index) ? exitDelMode(index) : enterDelMode(index),
                            dense: true,
                          ),
                        ),
                        separatorBuilder: (context, index) => Divider(thickness: 2, color: dblue.withOpacity(.2), height: 10),
                        itemCount: tempListTitles.length,
                        scrollDirection: Axis.vertical,
                      ),
                const SizedBox(height: 20 * 2),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

// SongContainer(
//                   h: size.width * .10,
//                   w: 25.0,
//                   title: widget.playlistsong[index],
//                   artist: widget.playlistarti[index],
//                   id: widget.playlistIds[index],
//                   icon: Icons.menu_open_rounded,
//                   size: size,
//                   manager: widget.pagemanager,
//                   func: () {},
//                 )
