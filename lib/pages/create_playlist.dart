// ignore_for_file: unnecessary_this

import 'dart:io';

import 'package:apollo_lite/backend/components.dart';
import 'package:apollo_lite/backend/constants.dart';
import 'package:apollo_lite/backend/locals/lang.dart';
import 'package:apollo_lite/backend/song_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreatePlaylistPage extends StatefulWidget {
  static const routeName = '/create_playlist';
  const CreatePlaylistPage({Key? key}) : super(key: key);

  @override
  State<CreatePlaylistPage> createState() => _CreatePlaylistPageState();
}

class _CreatePlaylistPageState extends State<CreatePlaylistPage> {
  final _textController = TextEditingController();
  late final ImagePicker _imgPicker;
  Image image = defaultPlaylistArt;
  String? imgPath;
  String _newPlaylistName = " ";
  bool _isNameSet = false;

  @override
  void initState() {
    _imgPicker = ImagePicker();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final _pageManager = Provider.of<PageManager>(context);
    final size = MediaQuery.of(context).size;
    // final songs = _pageManager.songTitles;
    // final songArtists = _pageManager.songArtists;
    // final songIds = _pageManager.songIds;
    final lang = Languages.of(context);
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: morningBlue,
          elevation: 15,
          toolbarHeight: 100,
          centerTitle: true,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              // topLeft: Radius.circular(45),
              // topRight: Radius.circular(45),
              bottomLeft: Radius.circular(125),
              bottomRight: Radius.circular(125),
            ),
          ),
          leading: const BackButton(color: dblue),
          title: FittedBox(fit: BoxFit.contain, child: Text(lang.libToolTip, style: basStyle.copyWith(color: dblue, letterSpacing: 2))),
          actions: [
            IconButton(
              padding: const EdgeInsets.only(right: 20),
              onPressed: () => _isNameSet == true
                  ? {
                      if (_newPlaylistName == " ")
                        {bildirim(context, lang.newPlaWarn1)}
                      else if (_newPlaylistName.length > 18 || _newPlaylistName.isEmpty)
                        {
                          bildirim(context, lang.newPlaWarn2),
                        }
                      else
                        {
                          _pageManager.createPlaylist(context, _newPlaylistName, imgPath),
                          Navigator.of(context).pop(),
                        }
                    }
                  : {bildirim(context, lang.newPlaWarn3)},
              icon: const Icon(Icons.check_box_rounded, color: dblue, size: 34),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: true,
          top: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(12, 12),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Container(
                  height: size.width * 0.6,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                    color: morningBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: imgPath != null
                        ? [
                            SizedBox(
                              height: size.width * 0.5,
                              width: size.width * 0.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: image,
                              ),
                            ),
                            Container(
                              height: size.width * 0.35,
                              width: size.width * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(120),
                                color: onyx.withOpacity(.5),
                              ),
                              child: GestureDetector(
                                //onTap: () => bildirim(context, 'cover seçme ekranı çıkar'),
                                onTap: () => pickImg(),
                                child: Icon(Icons.edit, color: onyx.withAlpha(220), size: 60),
                              ),
                            ),
                          ]
                        : [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                alignment: Alignment.center,
                                height: size.width * 0.5,
                                width: size.width * 0.5,
                                child: defaultPlaylistArt,
                              ),
                            ),
                            Container(
                              height: size.width * 0.25,
                              width: size.width * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(120),
                                color: onyx.withOpacity(.5),
                              ),
                              child: GestureDetector(
                                //onTap: () => bildirim(context, 'cover seçme ekranı çıkar'),
                                onTap: () => pickImg(),
                                child: Icon(Icons.edit, color: whitey.withAlpha(220), size: 60),
                              ),
                            ),
                          ],
                  ),
                ),
              ),
              const Spacer(),
              Text(lang.crePlaText1, style: basStyle.copyWith(fontSize: 24, color: onyx, fontWeight: FontWeight.w400), textAlign: TextAlign.left), //'lang.crePlaText1'
              const Spacer(),
              TextField(
                controller: _textController,
                style: basStyle.copyWith(fontSize: 30),
                textAlign: TextAlign.center,

                // maxLength: 15,
                // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  hintText: lang.newPla,
                  hintStyle: basStyle.copyWith(color: onyx.withOpacity(.9)),
                ),
                onChanged: (value) => {
                  setState(() {
                    _newPlaylistName = _textController.text;
                    _isNameSet = true;
                  })
                },
                onEditingComplete: () => {
                  if (_textController.text.isEmpty)
                    {bildirim(context, lang.newPlaWarn1)}
                  else if (_textController.text.length > 15 && _textController.text.isEmpty)
                    {bildirim(context, lang.newPlaWarn2)}
                  else
                    {
                      setState(() {
                        _newPlaylistName = _textController.text;
                        _isNameSet = true;
                      }),
                    },
                },
                onSubmitted: (value) => FocusScope.of(context).unfocus(),
                //onChanged: (value) => {},
              ),
              const Spacer(flex: 3),
            ],
          ),
        ));
  }
}
