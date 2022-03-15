// ignore_for_file: prefer_final_fields

import 'package:apollo_lite/backend/constants.dart';
import 'package:apollo_lite/backend/widgets/progress_notifier.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components.dart';
import 'widgets/play_button_notifier.dart';
import 'widgets/progress_notifier.dart';
import 'widgets/repeat_button_notifier.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'dart:convert';

class PageManager with ChangeNotifier {
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final currentSongArtistNotifier = ValueNotifier<String>('');
  final currentSongIdNotifier = ValueNotifier<int>(0);
  // final nextSongTitleNotifier = ValueNotifier<String>('');
  // final nextSongArtistNotifier = ValueNotifier<String>('');
  // final nextSongIdNotifier = ValueNotifier<int>(0);
  // final prevSongTitleNotifier = ValueNotifier<String>('');
  // final prevSongArtistNotifier = ValueNotifier<String>('');
  // final prevSongIdNotifier = ValueNotifier<int>(0);

  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  List<SongModel> _songs = [];
  List<SongModel> get songs {
    return [..._songs];
  }

  final List<Widget> _allArtworks = [];
  List<Widget> get allArtworks {
    return [..._allArtworks];
  }

  Map<List<String>, List<String>> sarkilarArtists = {};
  Map<List<String>, List<int>> sarkilarIds = {};
  String selectedSong = " ";
  int currentId = 0;
  String currentArtist = " ";
  int prevId = 0;
  String prevArtist = " ";
  int nextId = 0;
  String nextArtist = " ";
  List<String> _songTitles = [];
  List<String> get songTitles {
    return [..._songTitles];
  }

  List<String> _songArtists = [];
  List<String> get songArtists {
    return [..._songArtists];
  }

  List<int> _songIds = [];
  List<int> get songIds {
    return [..._songIds];
  }

  List<String> _selectedListTitles = [];
  List<String> get selectedListTitles {
    return [..._selectedListTitles];
  }

  List<String> _selectedListArtists = [];
  List<String> get selectedListArtists {
    return [..._selectedListArtists];
  }

  List<int> _selectedListIds = [];
  List<int> get selectedListIds {
    return [..._selectedListIds];
  }

  late ConcatenatingAudioSource _playlist;

  late AudioPlayer _audioPlayer;
  late OnAudioQuery _audioQuery;

  Future<void> initSongManager() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.erkingonultas.apollo_music_player',
      androidNotificationChannelName: 'Apollo Music Player',
      androidNotificationOngoing: false,
      androidResumeOnClick: true,
      androidNotificationChannelDescription: 'Apollo Music Player',
      androidNotificationClickStartsActivity: false,
      notificationColor: whitey,
      preloadArtwork: true,
      artDownscaleHeight: 100,
      artDownscaleWidth: 100,
    );
    _audioPlayer = AudioPlayer();
    _audioQuery = OnAudioQuery();

    fetchSongs();
    fetchPlaylists();
    getArtworks();
    _listenForChangesInPlayerState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
    _listenForChangesInSequenceState();
  }

  Future<void> fetchSongs() async {
    List<SongModel> _loadedsongs = [];
    //List<AudioSource> _shuffledUri = [];
    _songs.clear();
    _songTitles.clear();
    _songArtists.clear();
    _songIds.clear();
    _allArtworks.clear();
    _loadedsongs = await _audioQuery.querySongs();
    for (var song in _loadedsongs) {
      bool i = false;
      if (song.isMusic == null) {
        i = false;
      } else if (song.isMusic == false) {
        i = false;
      } else if (song.isMusic == true && song.album != "WhatsApp Audio") {
        i = true;
      }

      if (i) {
        _songs.add(song);
        _allArtworks.add(Cover(id: song.id));
      }
    }
    for (var element in _songs) {
      _songTitles.add(element.title);
      _songArtists.add(element.artist!);
      _songIds.add(element.id);
    }

    getFavIds();

    //initID2Song();
    Map<List<String>, List<String>> sarkilarArtists = {};
    Map<List<String>, List<int>> sarkilarIds = {};
    sarkilarArtists[songTitles] = songArtists;
    sarkilarIds[songTitles] = songIds;
    getLastPlayed();
    notifyListeners();
  }

  Future<void> refreshSongs() async {
    fetchSongs();
    fetchPlaylists();
    getArtworks();
  }

  // set playlist, used in --> play button,
  void setInitialPlaylist() async {
    // List<SongModel> _loadedsongs = [];
    List<SongModel> thissongs = songs;
    List<AudioSource> _shuffledUri = [];
    _selectedListTitles.clear();
    _selectedListArtists.clear();
    _selectedListIds.clear();
    for (var element in thissongs) {
      _selectedListTitles.add(element.title);
      _selectedListArtists.add(element.artist!);
      _selectedListIds.add(element.id);
    }
    for (var item in thissongs) {
      //_shuffledUri.add(AudioSource.uri(Uri.parse(item.uri!), tag: item.title));
      _shuffledUri.add(AudioSource.uri(Uri.parse(item.uri!), tag: MediaItem(id: item.id.toString(), title: item.title)));
    }
    _playlist = ConcatenatingAudioSource(
      children: _shuffledUri,
    );
    await _audioPlayer.setAudioSource(_playlist, initialIndex: 0, preload: true);
    notifyListeners();
    play();
  }

  // select playlist. used in -> playlist music containers,
  void listenPlaylistChanges(titles, artists, ids) async {
    List<AudioSource> _selectedList = [];
    List<SongModel> _selected = [];
    List<int> _plaIds = [];

    for (var title in titles) {
      _plaIds.add(_songIds[_songTitles.indexOf(title)]);
    }

    for (var select in _plaIds) {
      for (var song in songs) {
        if (select == song.id) {
          _selectedList.add(AudioSource.uri(Uri.parse(song.uri!), tag: MediaItem(id: song.id.toString(), title: song.title)));
          _selected.add(song);
        }
      }
    }
    _selectedListTitles.clear();
    _selectedListArtists.clear();
    _selectedListIds.clear();
    for (var song in _selected) {
      _selectedListTitles.add(song.title);
      _selectedListArtists.add(song.artist!);
      _selectedListIds.add(song.id);
    }

    _playlist = ConcatenatingAudioSource(children: _selectedList);
    await _audioPlayer.setAudioSource(_playlist, initialIndex: 0);

    notifyListeners();
    play();
  }

  // select playlist. used in -> playlist music containers,
  void shufflePlaylist(titles, artists, ids) async {
    List<AudioSource> _selectedList = [];
    List<SongModel> _selected = [];
    List<int> _plaIds = [];

    for (var title in titles) {
      _plaIds.add(_songIds[_songTitles.indexOf(title)]);
    }

    //ids.shuffle();
    _plaIds.shuffle();
    for (var select in _plaIds) {
      for (var song in songs) {
        if (select == song.id) {
          _selectedList.add(AudioSource.uri(Uri.parse(song.uri!), tag: MediaItem(id: song.id.toString(), title: song.title)));
          _selected.add(song);
        }
      }
    }
    _selectedListTitles.clear();
    _selectedListArtists.clear();
    _selectedListIds.clear();
    for (var song in _selected) {
      _selectedListTitles.add(song.title);
      _selectedListArtists.add(song.artist!);
      _selectedListIds.add(song.id);
    }

    _playlist = ConcatenatingAudioSource(children: _selectedList);
    await _audioPlayer.setAudioSource(_playlist, initialIndex: 0);
    if (isShuffleModeEnabledNotifier.value == false) {
      onShuffleButtonPressed();
    }
    notifyListeners();
    play();
  }

  // select individual music in a playlist. used in -> playlist music containers,
  void playPlaylistInd(titles, artists, ids, selectedTitle) async {
    List<AudioSource> _selectedList = [];
    List<SongModel> _selected = [];
    for (var select in titles) {
      for (var song in songs) {
        if (select == song.title) {
          _selectedList.add(AudioSource.uri(Uri.parse(song.uri!), tag: MediaItem(id: song.id.toString(), title: song.title)));
          _selected.add(song);
        }
      }
    }
    _selectedListTitles.clear();
    _selectedListArtists.clear();
    _selectedListIds.clear();
    for (var song in _selected) {
      _selectedListTitles.add(song.title);
      _selectedListArtists.add(song.artist!);
      _selectedListIds.add(song.id);
    }

    _playlist = ConcatenatingAudioSource(children: _selectedList);
    await _audioPlayer.setAudioSource(_playlist, initialIndex: _selectedListTitles.indexOf(selectedTitle));
    notifyListeners();
    play();
  }

  // select individual music. used in -> homepage music containers,
  void playHomeIndividual(id) async {
    List<SongModel> thissongs = songs;
    _selectedListTitles.clear();
    _selectedListArtists.clear();
    _selectedListIds.clear();
    List<AudioSource> _shuffledUri = [];
    for (var item in thissongs) {
      _shuffledUri.add(AudioSource.uri(Uri.parse(item.uri!), tag: MediaItem(id: item.id.toString(), title: item.title)));
      _selectedListTitles.add(item.title);
      _selectedListArtists.add(item.artist!);
      _selectedListIds.add(item.id);
    }
    _playlist = ConcatenatingAudioSource(
      children: _shuffledUri,
    );

    await _audioPlayer.setAudioSource(_playlist, initialIndex: _selectedListIds.indexOf(id), preload: true);
    notifyListeners();
    play();
  }

  // play only one music. --> searchpage
  void playIndividual(id) async {
    List<SongModel> thissongs = songs;
    _selectedListTitles.clear();
    _selectedListArtists.clear();
    _selectedListIds.clear();
    List<AudioSource> _shuffledUri = [];
    for (var item in thissongs) {
      if (item.id == id) {
        _shuffledUri.add(AudioSource.uri(Uri.parse(item.uri!), tag: MediaItem(id: item.id.toString(), title: item.title)));
        _selectedListTitles.add(item.title);
        _selectedListArtists.add(item.artist!);
        _selectedListIds.add(item.id);
      }
    }
    _playlist = ConcatenatingAudioSource(
      children: _shuffledUri,
    );
    await _audioPlayer.setAudioSource(_playlist, initialIndex: _selectedListIds.indexOf(id), preload: true);
    notifyListeners();
    play();
  }

  // home page shuffle function. --> homepage
  void homeShuffle() async {
    List<SongModel> thissongs = songs;
    thissongs.shuffle();
    _selectedListTitles.clear();
    _selectedListArtists.clear();
    _selectedListIds.clear();
    List<AudioSource> _shuffledUri = [];
    for (var item in thissongs) {
      _shuffledUri.add(AudioSource.uri(Uri.parse(item.uri!),
          tag: MediaItem(
            id: item.id.toString(),
            title: item.title,
          )));
      _selectedListTitles.add(item.title);
      _selectedListArtists.add(item.artist!);
      _selectedListIds.add(item.id);
    }
    _playlist = ConcatenatingAudioSource(
      children: _shuffledUri,
    );
    await _audioPlayer.setAudioSource(_playlist, initialIndex: 0, preload: true);
    if (isShuffleModeEnabledNotifier.value == false) {
      onShuffleButtonPressed();
    }
    notifyListeners();

    play();
  }

  void _listenForChangesInPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  void _listenForChangesInPlayerPosition() {
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInBufferedPosition() {
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInTotalDuration() {
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void _listenForChangesInSequenceState() {
    _audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;
      //current song info
      final currentItem = sequenceState.currentSource;
      final title = currentItem?.tag.title as String?;
      currentSongTitleNotifier.value = title ?? '';
      currentSongArtistNotifier.value = songArtists[_songTitles.indexOf(currentSongTitleNotifier.value)];
      currentSongIdNotifier.value = songIds[_songTitles.indexOf(currentSongTitleNotifier.value)];
      // update playlist
      final playlist = sequenceState.effectiveSequence;
      final titles = playlist.map((item) => item.tag.title as String).toList();
      playlistNotifier.value = titles;
      // update shuffle mode
      isShuffleModeEnabledNotifier.value = sequenceState.shuffleModeEnabled;
      // update previous and next buttons
      if (playlist.isEmpty || currentItem == null) {
        isFirstSongNotifier.value = true;
        isLastSongNotifier.value = true;
      } else {
        isFirstSongNotifier.value = playlist.first == currentItem;
        isLastSongNotifier.value = playlist.last == currentItem;
      }
    });
  }

  void play() async {
    _audioPlayer.play();
    notifyListeners();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void onRepeatButtonPressed() {
    repeatButtonNotifier.nextState();
    switch (repeatButtonNotifier.value) {
      case RepeatState.off:
        _audioPlayer.setLoopMode(LoopMode.off);
        break;
      case RepeatState.repeatSong:
        _audioPlayer.setLoopMode(LoopMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioPlayer.setLoopMode(LoopMode.all);
    }
  }

  void onPreviousSongButtonPressed() {
    _audioPlayer.seekToPrevious();
    notifyListeners();
  }

  void onNextSongButtonPressed() {
    _audioPlayer.seekToNext();
    notifyListeners();
  }

  void onShuffleButtonPressed() async {
    final enable = !_audioPlayer.shuffleModeEnabled;
    if (enable) {
      await _audioPlayer.shuffle();
    }
    await _audioPlayer.setShuffleModeEnabled(enable);
  }

  // FAV SONGS

  List<SongModel> _favoriteSongs = [];
  List<int> _favSongIds = [];
  List<String> _favSongArtists = [];
  List<String> _favSongTitle = [];

  List<SongModel> get favoriteSongs {
    return [..._favoriteSongs];
  }

  List<int> get favSongIds {
    return [..._favSongIds];
  }

  List<String> get favSongArtists {
    return [..._favSongArtists];
  }

  List<String> get favSongTitle {
    return [..._favSongTitle];
  }

  void initID2Song() {
    _favoriteSongs.clear();

    _favSongArtists.clear();
    _favSongTitle.clear();
    for (var i = 0; i < favSongIds.length; i++) {
      for (var j = 0; j < songs.length; j++) {
        if (favSongIds[i] == songs[j].id) {
          _favoriteSongs.add(songs[j]);
          _favSongTitle.add(songs[j].title);
          _favSongArtists.add(songs[j].artist.toString());
        }
      }
    }
  }

  void convertID2Song() {
    _favoriteSongs.clear();

    _favSongArtists.clear();
    _favSongTitle.clear();
    //for (var item in songs) {}
    for (var i = 0; i < favSongIds.length; i++) {
      for (var j = 0; j < songs.length; j++) {
        if (songs[j].id == favSongIds[i]) {
          _favoriteSongs.add(songs[j]);
          _favSongTitle.add(songs[j].title);
          _favSongArtists.add(songs[j].artist.toString());
        }
      }
    }

    notifyListeners();
  }

  Future<void> add2Fav(id) async {
    _favSongIds.add(id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favIds', favSongIds.map((i) => i.toString()).toList());
    convertID2Song();

    notifyListeners();
  }

  Future<void> removeFromFav(id) async {
    _favSongIds.remove(id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favIds', favSongIds.map((i) => i.toString()).toList());
    notifyListeners();
  }

  getFavIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('favIds') == null) {
      prefs.setStringList('favIds', favSongIds.map((i) => i.toString()).toList());
    }
    List<String> favSongStr = prefs.getStringList('favIds')!;
    _favSongIds = favSongStr.map((i) => int.parse(i)).toList();
    initID2Song();
  }

  int _lastPlayed = 0;

  int get lastPlayed {
    return _lastPlayed;
  }

  Future<void> setLastPlayed() async {
    // currentSongTitleNotifier.value = title ?? '';
    //   currentSongArtistNotifier.value = songArtists[_songTitles.indexOf(currentSongTitleNotifier.value)];
    //   currentSongIdNotifier.value = songIds[_songTitles.indexOf(currentSongTitleNotifier.value)];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _lastPlayed = currentSongIdNotifier.value;
    prefs.setInt('lastPlayed', lastPlayed);
    notifyListeners();
  }

  Future<void> getLastPlayed() async {
    // currentSongTitleNotifier.value = title ?? '';
    //   currentSongArtistNotifier.value = songArtists[_songTitles.indexOf(currentSongTitleNotifier.value)];
    //   currentSongIdNotifier.value = songIds[_songTitles.indexOf(currentSongTitleNotifier.value)];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('lastPlayed') == null) {
      prefs.setInt('lastPlayed', lastPlayed);
    }
    _lastPlayed = prefs.getInt('lastPlayed')!;

    if (lastPlayed != 0) {
      List<SongModel> thissongs = songs;
      _selectedListTitles.clear();
      _selectedListArtists.clear();
      _selectedListIds.clear();
      List<AudioSource> _shuffledUri = [];
      for (var item in thissongs) {
        _shuffledUri.add(AudioSource.uri(Uri.parse(item.uri!), tag: MediaItem(id: item.id.toString(), title: item.title)));
        _selectedListTitles.add(item.title);
        _selectedListArtists.add(item.artist!);
        _selectedListIds.add(item.id);
      }
      notifyListeners();
      _playlist = ConcatenatingAudioSource(
        children: _shuffledUri,
      );

      await _audioPlayer.setAudioSource(_playlist, initialIndex: _selectedListIds.indexOf(_lastPlayed), preload: true);
    }
  }

  // SEARCH

  List<SongModel> _searchedSongs = [];
  List<SongModel> get searchedSongs {
    return [..._searchedSongs];
  }

  void searchSongs(name) {
    name.toLowerCase();
    _searchedSongs.clear();
    if (songs.isNotEmpty) {
      for (var song in songs) {
        if (song.title.toLowerCase().startsWith(name) || song.artist!.toLowerCase().startsWith(name) || song.album!.toLowerCase().startsWith(name) || song.displayName.toLowerCase().startsWith(name)) {
          _searchedSongs.add(song);
        }
        // if (song.artist!.toLowerCase().startsWith(name) && !_searchedSongs.contains(song)) {
        //   _searchedSongs.add(song);
        // }
        // if (song.album!.toLowerCase().startsWith(name) && !_searchedSongs.contains(song)) {
        //   _searchedSongs.add(song);
        // }
        // if (song.displayName.toLowerCase().startsWith(name) && !_searchedSongs.contains(song)) {
        //   _searchedSongs.add(song);
        // }
      }
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchedSongs.clear();
    notifyListeners();
  }

  // PLAYLISTS

  List<PlaylistModel> _playlists = [];

  get playlists {
    return [..._playlists];
  }

  List<int> _playlistsIds = [];
  get playlistsIds {
    return [..._playlistsIds];
  }

  List<int> _playlistArtworks = [];

  get playlistArtworks {
    return [..._playlistArtworks];
  }

  List<SongModel> _listSongs = [];

  get listSongs {
    return [..._listSongs];
  }

  List<String> _listTitles = [];
  List<String> get listTitles {
    return [..._listTitles];
  }

  List<String> _listArtists = [];
  List<String> get listArtists {
    return [..._listArtists];
  }

  List<int> _listIds = [];
  List<int> get listIds {
    return [..._listIds];
  }

  fetchPlaylists() async {
    List<PlaylistModel> _loadedPlaylists = [];
    _loadedPlaylists = await _audioQuery.queryPlaylists(sortType: PlaylistSortType.DATE_ADDED);
    _playlists = _loadedPlaylists;
    for (var item in _playlists) {
      _playlistsIds.add(item.id);
    }
    notifyListeners();
    fetchPlaylistArtworks();
  }

  songsForPlaylist(playlistId) async {
    List<SongModel> _loadedListSongs = [];

    _listTitles.clear();
    _listArtists.clear();
    _listIds.clear();
    _loadedListSongs = await _audioQuery.queryAudiosFrom(
      AudiosFromType.PLAYLIST,
      playlistId,
      orderType: OrderType.ASC_OR_SMALLER,
      ignoreCase: true,
    );
    _listSongs = _loadedListSongs;

    for (var song in _listSongs) {
      _listTitles.add(song.title);
      _listArtists.add(song.artist!);
      //_listIds.add(_songIds[_songTitles.indexOf(song.title)]);
      _listIds.add(song.id);
    }

    notifyListeners();
  }

  fetchPlaylistArtworks() async {
    List<int> _loadedArts = [];
    List<SongModel> _ls = [];

    for (var playlist in playlists) {
      _ls.clear();
      _ls = await _audioQuery.queryAudiosFrom(
        AudiosFromType.PLAYLIST,
        playlist.id,
        orderType: OrderType.ASC_OR_SMALLER,
        ignoreCase: true,
      );
      if (_ls.isNotEmpty) {
        _loadedArts.add(_songIds[_songTitles.indexOf(_ls[_ls.length - 1].title)]);
      } else {
        _loadedArts.add(999);
      }
    }
    _playlistArtworks = _loadedArts;
    notifyListeners();
  }

  Map<String, dynamic> _customArts = {};

  Map<String, dynamic> get customArts {
    return _customArts;
  }

  createPlaylist(BuildContext _, name, img) async {
    List<String> plNames = [];
    for (var pl in playlists) {
      plNames.add(pl.playlist);
    }
    if (plNames.contains(name)) {
      bildirim(_, 'the name already exists.');
      return;
    }
    await _audioQuery.createPlaylist(name);
    if (img != null) {
      _customArts[name] = img;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedMap = json.encode(_customArts);
    prefs.setString('customArts', encodedMap);

    notifyListeners();
    fetchPlaylists();
  }

  removePlaylist(id, name) async {
    await _audioQuery.removePlaylist(id);
    if (_customArts[name] != null) {
      _customArts.remove(name);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String encodedMap = json.encode(_customArts);
      prefs.setString('customArts', encodedMap);
    }
    fetchPlaylists();
  }

  add2Playlist(listId, songId) async {
    await _audioQuery.addToPlaylist(listId, songId);
    fetchPlaylists();
  }

  removeFromPlaylist(listId, listName, newList) async {
    try {
      //await _audioQuery.removeFromPlaylist(listId, newList[0]);
      for (var item in newList) {
        await _audioQuery.removeFromPlaylist(listId, item);
      }
    } catch (e) {
      return;
    }
    fetchPlaylists();
    notifyListeners();
  }

  editPlaylistArt(name, img) async {
    _customArts[name] = img;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedMap = json.encode(_customArts);
    prefs.setString('customArts', encodedMap);

    notifyListeners();
  }

  renamePlaylist(listId, newName) async {
    await _audioQuery.renamePlaylist(listId, newName);
    // final thepla = File(playlists[playlistsIds.indexOf(listId)].data);
    // var path = thepla.path;
    // var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    // var newPath = path.substring(0, lastSeparator + 1) + newName;
    // thepla.rename(newPath);

    //print(playlists[playlistsIds.indexOf(listId)].data);
    fetchPlaylists();
  }

  Future<void> getArtworks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> decodedMap = {};
    String? encodedMap = prefs.getString('customArts');
    if (encodedMap != null) {
      decodedMap = json.decode(encodedMap);
    }
    _customArts = decodedMap;
    notifyListeners();
  }

  Future<void> add2Q() async {}
}
