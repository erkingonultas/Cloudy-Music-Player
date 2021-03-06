import 'package:flutter/material.dart';
import 'dart:ui' as ui;

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of(context, Languages);
  }

  final int saat = DateTime.now().hour;
  String get musicPlayer;
  String get designed;
  String get tested;
  String get freeVer;
  String get paidVer;
  String get homeLabel;
  String get libraryLabel;
  String get archiveLabel;
  String get searchText;
  String get search;
  String get recLabel1;
  String get recLabel2;
  String get albums;
  String get libToolTip;
  String get notPlaying;
  String get favorites;
  String get noPlaylists;
  String get playlists;
  String get favText;
  String get favText2;
  String get shufflePla;
  String get playPla;
  String get textPla;
  String get text2Pla;
  String get delPla;
  String get editPla;
  String get deleted;
  String get cancel;
  String get crePlaText1;
  String get crePlaText2;
  String get crePlaText3;
  String get tracks;
  String get shuffleArc;
  String get addFav1;
  String get remFav1;
  String get addFav2;
  String get remFav2;
  String get addSongTo;
  String get addToPla;
  String get newPla;
  String get newPlaWarn1;
  String get newPlaWarn2;
  String get newPlaWarn3;
  String get done;
  String get confirm;
  String get undo;
  String get playing;
  String get qEmpty;
  String get noSongs;
  String get editSong;
  String get customYSong;
  String get title;
  String get artist;
  String get remSongFromPla;
  String get hideSong;
  String get changeCoverPla;
  String get save;
  String get confirmChanges;
  String get duration;
  String get musicError1;
  String get musicError2;
  String get standby0;
  String get standby1;
  String get standby2;
  String get standby3;
  String get standby4;
  String get conRefresh;
  String get greet;
  String get unlockAllF;
  String get connecting;
  String get notConnected;
  String get purchase;
  String get storeIsAvailable;
  String get storeIsNotAvailable;
  String get onPro;
  String get onFree;
  String get proFeatures;
  String get promoT1;
  String get promoT2;
  String get promoT3;
  String get later;
  String get rate;
  String get rateTitle;
  String get ratemessage;
  String get rateBildirim;
}

class LanguageEN extends Languages {
  @override
  String get musicPlayer => 'music player';
  @override
  String get designed => 'Designed by';
  @override
  String get tested => 'Tested by';
  @override
  String get freeVer => 'FREE VERSION';
  @override
  String get paidVer => 'FULL VERSION';
  @override
  String get archiveLabel => "ARCHIVE";
  @override
  String get homeLabel => "HOME";
  @override
  String get libraryLabel => "LIBRARY";
  @override
  String get recLabel1 => "APOLLO RECOMMENDS";
  @override
  String get recLabel2 => "what about...";
  @override
  String get albums => 'ALBUMS';
  @override
  String get libToolTip => 'create a playlist';
  @override
  String get notPlaying => 'Not Playing';
  @override
  String get favorites => 'Favorites';
  @override
  String get playlists => 'playlists';
  @override
  String get noPlaylists => 'Looks like\nthere are no playlists';
  @override
  String get favText => 'There is no favorites yet!';
  @override
  String get favText2 => 'MORE SONGS';
  @override
  String get shufflePla => 'SHUFFLE';
  @override
  String get playPla => 'PLAY';
  @override
  String get textPla => 'The list you looking for is empty!';
  @override
  String get text2Pla => 'MORE SONGS';
  @override
  String get delPla => 'DELETE';
  @override
  String get editPla => 'EDIT';
  @override
  String get deleted => 'deleted';
  @override
  String get cancel => 'CANCEL';
  @override
  String get crePlaText1 => 'name your playlist:';
  @override
  String get crePlaText2 => 'then choose a cover';
  @override
  String get crePlaText3 => '(optional)';
  @override
  String get tracks => 'tracks';
  @override
  String get shuffleArc => 'SHUFFLE';
  @override
  String get searchText => 'clear';
  @override
  String get search => 's e a r c h';
  @override
  String get addFav1 => 'add favorites';
  @override
  String get remFav1 => 'remove favorite';
  @override
  String get addFav2 => 'added to your favorites!';
  @override
  String get remFav2 => 'removed from your favorites!';
  @override
  String get addSongTo => 'song added to';
  @override
  String get addToPla => 'add to playlist';
  @override
  String get newPla => 'new playlist';
  @override
  String get newPlaWarn1 => 'Name cannot be empty.';
  @override
  String get newPlaWarn2 => 'Length of the name must be in the range of 1-18.';
  @override
  String get newPlaWarn3 => 'Please set a name.';
  @override
  String get done => 'D O N E';
  @override
  String get playing => 'P L A Y I N G';
  @override
  String get confirm => 'CONFIRM';
  @override
  String get undo => 'undo';
  @override
  String get qEmpty => "queue is empty";
  @override
  String get noSongs => 'There are no songs found on your device.';
  @override
  String get editSong => 'CUSTOMIZE';
  @override
  String get customYSong => 'customize your song';
  @override
  String get title => 'title';
  @override
  String get artist => 'artist';
  @override
  String get remSongFromPla => 'Selected songs will be removed from the list!\nSave changes?';
  @override
  String get hideSong => 'HIDE SONGS';
  @override
  String get changeCoverPla => 'The cover is changed!\nSave changes?';
  @override
  String get save => 'SAVE';
  @override
  String get confirmChanges => 'Confirm the changes?';
  @override
  String get duration => 'Duration';
  @override
  String get musicError1 => 'Music can not be loaded, please try again.';
  @override
  String get musicError2 => 'Google Play Billing Services can not be initialized, please try again.';
  @override
  String get standby0 => 'Searching for musics';
  @override
  String get standby1 => 'Fetching playlists';
  @override
  String get standby2 => 'Preparing favourites';
  @override
  String get standby3 => 'Process Completed';
  @override
  String get standby4 => 'Initializing UI...';
  @override
  String get conRefresh => 'Do you want to refresh songs and playlists?';
  @override
  String get unlockAllF => 'Unlock All Features';
  @override
  String get connecting => 'Connecting...';
  @override
  String get notConnected => 'Not connected';
  @override
  String get purchase => 'PURCHASE';
  @override
  String get storeIsAvailable => 'The store is available';
  @override
  String get storeIsNotAvailable => 'The store is unavailable';
  @override
  String get onPro => 'You are already using the full version.';
  @override
  String get onFree => 'You are using the free version.';
  @override
  String get proFeatures => 'Customize all of your songs,\ncreate unlimited playlists,\nand\nenjoy an ad-free experience.';
  @override
  String get promoT1 => 'Customize all of your songs';
  @override
  String get promoT2 => 'create unlimited playlists';
  @override
  String get promoT3 => 'and\nenjoy an ad-free experience.';
  @override
  String get later => 'LATER';
  @override
  String get rate => 'RATE';
  @override
  String get rateTitle => 'Are you enjoying the app so far?';
  @override
  String get ratemessage => 'Would you like to leave a review?';
  @override
  String get rateBildirim => 'Thank you for your feedback!';
  @override
  String get greet => ((0 <= DateTime.now().hour && DateTime.now().hour < 6) || DateTime.now().hour > 21)
      ? "GOOD NIGHT"
      : (12 < saat && saat < 19)
          ? "GOOD EVENING"
          : (18 < saat && saat < 22)
              ? "GOOD AFTERNOON"
              : "GOOD MORNING";
}

class LanguageTR extends Languages {
  @override
  String get musicPlayer => 'm??zik ??alar';
  @override
  String get designed => 'Dizayn eden';
  @override
  String get tested => 'Test eden';
  @override
  String get freeVer => '??CRETS??Z S??R??M';
  @override
  String get paidVer => 'TAM S??R??M';
  @override
  String get archiveLabel => "AR????V";

  @override
  String get homeLabel => "MERKEZ";

  @override
  String get libraryLabel => "K??T??PHANE";

  @override
  String get recLabel1 => "APOLLO'NUN ??NER??S??";

  @override
  String get recLabel2 => "??una ne dersin?";
  @override
  String get albums => 'ALB??MLER';
  @override
  String get libToolTip => '??alma listesi olu??tur';
  @override
  String get notPlaying => 'duraklat??ld??';
  @override
  String get favorites => 'Favoriler';
  @override
  String get playlists => '??alma listeleri';
  @override
  String get noPlaylists => '??alma listen yok gibi g??r??n??yor';
  @override
  String get favText => 'Hen??z bir favorin yok!';
  @override
  String get favText2 => 'daha fazla ??ark??';
  @override
  String get shufflePla => 'KARI??TIR';
  @override
  String get playPla => 'OYNAT';
  @override
  String get textPla => 'arad??????n liste bo?? g??r??n??yor!';
  @override
  String get text2Pla => 'daha fazla ??ark??';
  @override
  String get delPla => 'KALDIR';
  @override
  String get editPla => 'D??ZENLE';
  @override
  String get deleted => 'silindi';
  @override
  String get cancel => '??PTAL';
  @override
  String get crePlaText1 => '??alma listenize bir isim verin';
  @override
  String get crePlaText2 => 've bir kapak se??in';
  @override
  String get crePlaText3 => '(iste??e ba??l??)';
  @override
  String get tracks => 'par??a';
  @override
  String get shuffleArc => 'KARI??TIR';
  @override
  String get searchText => 'temizle';
  @override
  String get search => 'a r a';
  @override
  String get addFav1 => 'favorilere ekle';
  @override
  String get remFav1 => 'favorilerden ????kar';
  @override
  String get addFav2 => 'favorilerine eklendi!';
  @override
  String get remFav2 => 'favorilerinden ????kart??ld??!';
  @override
  String get addSongTo => '??ark?? ??uraya eklendi:';
  @override
  String get addToPla => '??alma listesine ekle';
  @override
  String get newPla => 'yeni liste';
  @override
  String get newPlaWarn1 => '??sim alan?? bo?? kalmamal??.';
  @override
  String get newPlaWarn2 => '??smin uzunlu??u 1-18 karakter aras??nda olmal??.';
  @override
  String get newPlaWarn3 => 'L??tfen bir isim se??in.';
  @override
  String get done => 'B ?? T ?? R';
  @override
  String get playing => 'O Y N A T';
  @override
  String get confirm => 'ONAYLA';
  @override
  String get undo => 'geri al';
  @override
  String get qEmpty => "liste bo??";
  @override
  String get noSongs => 'Cihaz??n??zda m??zik bulunamad??.';
  @override
  String get editSong => '??ZELLE??T??R';
  @override
  String get customYSong => '??ark??n?? ??zelle??tir';
  @override
  String get title => 'ba??l??k';
  @override
  String get artist => 'sanat????';
  @override
  String get remSongFromPla => 'Se??ti??in ??ark??lar listeden kald??r??lacak!\nDe??i??iklikler kaydedilsin mi?';
  @override
  String get hideSong => '??ARKILARI G??ZLE';
  @override
  String get changeCoverPla => '??alma listesi kapa???? de??i??ti!\nDe??i??iklikler kaydedilsin mi?';
  @override
  String get save => 'KAYDET';
  @override
  String get confirmChanges => 'De??i??iklikleri kaydet?';
  @override
  String get duration => 'S??re';
  @override
  String get musicError1 => 'M??zikler y??klenemedi. L??tfen daha sonra tekrar deneyin.';
  @override
  String get musicError2 => 'Google Play Faturaland??rma Servisi ba??lat??lam??yor, l??tfen tekrar deneyin.';
  @override
  String get standby0 => 'M??zik aran??yor';
  @override
  String get standby1 => '??alma listeleri haz??rlan??yor';
  @override
  String get standby2 => 'Favoriler ayarlan??yor';
  @override
  String get standby3 => '????lem tamamland??';
  @override
  String get standby4 => 'Aray??z ba??lat??l??yor...';
  @override
  String get conRefresh => '??ark??lar?? ve ??alma listelerini yenilemek istiyor musunuz?';
  @override
  String get unlockAllF => 'B??t??n ??zellikleri A??';
  @override
  String get connecting => 'Ba??lan??yor...';
  @override
  String get notConnected => 'Ba??lan??lamad??';
  @override
  String get storeIsAvailable => 'Market kullan??labilir';
  @override
  String get storeIsNotAvailable => 'Market kullan??lamaz';
  @override
  String get onPro => 'Zaten tam s??r??m?? kullanmaktas??n??z.';
  @override
  String get onFree => '??cretsiz s??r??m?? kullanmaktas??n??z.';
  @override
  String get purchase => 'SATIN AL';
  @override
  String get proFeatures => '??ark??lar??n?? ??zelle??tir,\nS??n??rs??z say??da ??alma listesi olu??tur\nve reklams??z bir deneyim ya??a.';
  @override
  String get promoT1 => '??ark??lar??n?? ??zelle??tir';
  @override
  String get promoT2 => 'S??n??rs??z say??da ??alma listesi olu??tur';
  @override
  String get promoT3 => 've\nreklams??z bir deneyim ya??a.';
  @override
  String get later => 'SONRA';
  @override
  String get rate => 'DE??ERLEND??R';
  @override
  String get rateTitle => 'Uygulamam??zdan memnun musunuz?';
  @override
  String get ratemessage => 'K??sa bir de??erlendirme yapmak ister misiniz?';
  @override
  String get rateBildirim => 'Geri bildiriminiz i??in te??ekk??r ederiz!';
  @override
  String get greet => ((0 <= DateTime.now().hour && DateTime.now().hour < 6) || DateTime.now().hour > 21)
      ? "??Y?? GECELER"
      : (12 < saat && saat < 19)
          ? "??Y?? G??NLER"
          : (18 < saat && saat < 22)
              ? "??Y?? AK??AMLAR"
              : "G??NAYDIN";
}

class LanguageFR extends Languages {
  @override
  String get musicPlayer => 'joueur de musique';
  @override
  String get designed => 'Con??u par';
  @override
  String get tested => 'Test?? par';
  @override
  String get freeVer => 'VERSION GRATUITE';
  @override
  String get paidVer => 'VERSION COMPL??TE';
  @override
  String get archiveLabel => "ARCHIVES";
  @override
  String get homeLabel => "DOMICILE";
  @override
  String get libraryLabel => "BIBLIOTH??QUE";
  @override
  String get recLabel1 => "APOLLO RECOMMANDE";
  @override
  String get recLabel2 => "qu'en est-il de...";
  @override
  String get albums => 'ALBUMS';
  @override
  String get libToolTip => 'cr??er une playlist';
  @override
  String get notPlaying => 'Ne joue pas';
  @override
  String get favorites => 'Les Favoris';
  @override
  String get playlists => 'playlists';
  @override
  String get noPlaylists => 'il n\'y a pas de playlist';
  @override
  String get favText => 'Il n\'y a pas encore de favoris !';
  @override
  String get favText2 => 'PLUS DE MUSIQUES';
  @override
  String get shufflePla => 'M??LANGER';
  @override
  String get playPla => 'JOUER';
  @override
  String get textPla => 'La liste que vous cherchez est vide !';
  @override
  String get text2Pla => 'PLUS DE MUSIQUES';
  @override
  String get delPla => 'EFFACER';
  @override
  String get editPla => '??DITER';
  @override
  String get deleted => 'supprim??';
  @override
  String get cancel => 'ANNULER';
  @override
  String get crePlaText1 => 'nommez votre playlist';
  @override
  String get crePlaText2 => 'puis choisissez une couverture';
  @override
  String get crePlaText3 => '(optionnel)';
  @override
  String get tracks => 'musiques';
  @override
  String get shuffleArc => 'M??LANGER';
  @override
  String get searchText => 'clear';
  @override
  String get search => 'c h e r c h e r';
  @override
  String get addFav1 => 'ajouter des favoris';
  @override
  String get remFav1 => 'supprimer le favori';
  @override
  String get addFav2 => 'ajout?? ?? vos favoris!';
  @override
  String get remFav2 => 'supprim?? de vos favoris!';
  @override
  String get addSongTo => 'musique ajout??e ??';
  @override
  String get addToPla => 'ajouter ?? la playlist';
  @override
  String get newPla => 'nouvelle playlist';
  @override
  String get newPlaWarn1 => 'Le nom ne peut pas ??tre vide.';
  @override
  String get newPlaWarn2 => 'La longueur du nom doit ??tre comprise entre 1 et 18.';
  @override
  String get newPlaWarn3 => 'Veuillez d??finir un nom.';
  @override
  String get done => 'F I N I';
  @override
  String get playing => 'J O U E R';
  @override
  String get confirm => 'CONFIRMEZ';
  @override
  String get undo => 'annuler';
  @override
  String get qEmpty => "la queue est vide";
  @override
  String get noSongs => 'Il n\'y a pas de musiques trouv??es sur votre appareil.';
  @override
  String get editSong => 'PERSONNALISER';
  @override
  String get customYSong => 'personnalisez votre musique';
  @override
  String get title => 'titre';
  @override
  String get artist => 'artiste';
  @override
  String get remSongFromPla => 'Les musiques s??lectionn??es seront supprim??es de la liste!\nEnregistrer les changements?';
  @override
  String get hideSong => 'MASQUER LES CHANSONS';
  @override
  String get changeCoverPla => 'La couverture de l\'album est modifi??e!\nEnregistrer les changements?';
  @override
  String get save => 'enregistrer';
  @override
  String get confirmChanges => 'Confirmez les changements?';
  @override
  String get duration => 'Dur??e';
  @override
  String get musicError1 => 'La musique ne peut pas ??tre charg??e, veuillez r??essayer.';
  @override
  String get musicError2 => 'Google Play Billing Services ne peut pas ??tre initialis??, veuillez r??essayer.';
  @override
  String get standby0 => 'Recherche de musiques';
  @override
  String get standby1 => 'R??cup??rer des playlists';
  @override
  String get standby2 => 'Pr??parer les favoris';
  @override
  String get standby3 => 'Processus Termin??';
  @override
  String get standby4 => 'Initialisation de l\'UI...';
  @override
  String get conRefresh => 'Voulez-vous rafraichir les musiques et les playlists?';
  @override
  String get unlockAllF => 'D??bloquez Toutes les Fonctionnalit??s';
  @override
  String get connecting => 'Connexion...';
  @override
  String get notConnected => 'Pas connect??';
  @override
  String get purchase => 'ACHETER';
  @override
  String get storeIsAvailable => 'Le magasin est disponible';
  @override
  String get storeIsNotAvailable => 'Le magasin est indisponible';
  @override
  String get onPro => 'Vous utilisez d??j?? la version compl??te.';
  @override
  String get onFree => 'Vous utilisez la version gratuite.';
  @override
  String get proFeatures => 'Personnalisez toutes vos musiques,\ncr??ez un nombre illimit?? de playlist,\net\ns\'amuser d\'une exp??rience sans publicit??.';
  @override
  String get promoT1 => 'Personnalisez toutes vos musiques';
  @override
  String get promoT2 => 'cr??ez un nombre illimit?? de playlist';
  @override
  String get promoT3 => 'et\ns\'amuser d\'une exp??rience sans publicit??.';
  @override
  String get later => 'PLUS TARD';
  @override
  String get rate => '??VALUER';
  @override
  String get rateTitle => 'Appr??ciez-vous l\'application jusqu\'?? pr??sent?';
  @override
  String get ratemessage => 'Souhaitez-vous laisser un commentaire?';
  @override
  String get rateBildirim => 'Merci pour votre avis!';
  @override
  String get greet => ((0 <= DateTime.now().hour && DateTime.now().hour < 6) || DateTime.now().hour > 21)
      ? "BONSOIR"
      : (12 < saat && saat < 19)
          ? "BONSOIR"
          : (18 < saat && saat < 22)
              ? "BONNE APR??S-MIDI"
              : "BONJOUR";
}

class LanguageES extends Languages {
  @override
  String get musicPlayer => 'reproductor de m??sica';
  @override
  String get designed => 'Dise??ada por';
  @override
  String get tested => 'Probado por';
  @override
  String get freeVer => 'VERSI??N GRATUITA';
  @override
  String get paidVer => 'VERSI??N COMPLETA';
  @override
  String get archiveLabel => "ARCHIVO";
  @override
  String get homeLabel => "CASA";
  @override
  String get libraryLabel => "BIBLIOTECA";
  @override
  String get recLabel1 => "APOLLO RECOMIENDA";
  @override
  String get recLabel2 => "qu?? pasa...";
  @override
  String get albums => '??LBUMES';
  @override
  String get libToolTip => 'crear una lista de reproducci??n';
  @override
  String get notPlaying => 'No jugando';
  @override
  String get favorites => 'Favoritas';
  @override
  String get playlists => 'playlists';
  @override
  String get noPlaylists => 'Parece que no hay\nlistas de reproducci??n.';
  @override
  String get favText => '??A??n no hay favoritos!';
  @override
  String get favText2 => 'M??S CANCIONES';
  @override
  String get shufflePla => 'BARAJAR';
  @override
  String get playPla => 'TOCAR';
  @override
  String get textPla => '??La lista que buscas est?? vac??a!';
  @override
  String get text2Pla => 'M??S CANCIONES';
  @override
  String get delPla => 'ELIMINAR';
  @override
  String get editPla => 'EDITAR';
  @override
  String get deleted => 'eliminado';
  @override
  String get cancel => 'CANCELAR';
  @override
  String get crePlaText1 => 'nombra tu playlist';
  @override
  String get crePlaText2 => 'luego elige una portada';
  @override
  String get crePlaText3 => '(Opcional)';
  @override
  String get tracks => 'canciones';
  @override
  String get shuffleArc => 'BARAJAR';
  @override
  String get searchText => 'claro';
  @override
  String get search => 'b u s c a r';
  @override
  String get addFav1 => 'Agregar favoritas';
  @override
  String get remFav1 => 'Eliminar favorito';
  @override
  String get addFav2 => 'A??adido a tus favoritas!';
  @override
  String get remFav2 => 'Eliminada de tus favoritas!';
  @override
  String get addSongTo => 'canci??n a??adida a';
  @override
  String get addToPla => 'agregar a la lista de reproducci??n';
  @override
  String get newPla => 'nueva playlist';
  @override
  String get newPlaWarn1 => 'El nombre no puede estar vac??o.';
  @override
  String get newPlaWarn2 => 'La longitud del nombre debe estar en el rango de 1-18.';
  @override
  String get newPlaWarn3 => 'Establezca un nombre.';
  @override
  String get done => 'H E C H O';
  @override
  String get playing => 'J U G A N D O';
  @override
  String get confirm => 'CONFIRMAR';
  @override
  String get undo => 'deshacer';
  @override
  String get qEmpty => "la cola est?? vac??a";
  @override
  String get noSongs => 'No se han encontrado canciones en su dispositivo.';
  @override
  String get editSong => 'PERSONALIZAR';
  @override
  String get customYSong => 'personaliza tu canci??n';
  @override
  String get title => 't??tulo';
  @override
  String get artist => 'artista';
  @override
  String get remSongFromPla => '??Las canciones seleccionadas ser??n eliminadas de la lista!\n??Guardar cambios?';
  @override
  String get hideSong => 'OCULTAR CANCIONES';
  @override
  String get changeCoverPla => '??La portada est?? cambiada!\n??Guardar cambios?';
  @override
  String get save => 'AHORRAR';
  @override
  String get confirmChanges => '??Confirmar los cambios?';
  @override
  String get duration => 'Duraci??n';
  @override
  String get musicError1 => 'No se puede cargar la m??sica, int??ntalo de nuevo.';
  @override
  String get musicError2 => 'Los servicios de facturaci??n de Google Play no se pueden inicializar, int??ntalo de nuevo.';
  @override
  String get standby0 => 'Buscando musicas';
  @override
  String get standby1 => 'Obtener listas de reproducci??n';
  @override
  String get standby2 => 'Preparando favoritos';
  @override
  String get standby3 => 'Proceso Completado';
  @override
  String get standby4 => 'Inicializando UI...';
  @override
  String get conRefresh => '??Quieres actualizar canciones y listas de reproducci??n?';
  @override
  String get unlockAllF => 'Desbloquear todas las funciones';
  @override
  String get connecting => 'Conectando...';
  @override
  String get notConnected => 'No conectado';
  @override
  String get purchase => 'COMPRA';
  @override
  String get storeIsAvailable => 'La tienda esta disponible';
  @override
  String get storeIsNotAvailable => 'La tienda no est?? disponible.';
  @override
  String get onPro => 'Ya est??s usando la versi??n completa.';
  @override
  String get onFree => 'Est??s usando la versi??n gratuita.';
  @override
  String get proFeatures => 'Personalice todas sus canciones,\n\ncrear listas de reproducci??n ilimitadas,\ny\ndisfruta de una experiencia sin publicidad.';
  @override
  String get promoT1 => 'Personalice todas sus canciones';
  @override
  String get promoT2 => 'crear listas de reproducci??n ilimitadas';
  @override
  String get promoT3 => 'y\ndisfruta de una experiencia sin publicidad.';
  @override
  String get later => 'M??S TARDE';
  @override
  String get rate => 'CALIFICAR';
  @override
  String get rateTitle => '??Est??s disfrutando de la aplicaci??n hasta ahora?';
  @override
  String get ratemessage => '??Te gustar??a dejar una rese??a?';
  @override
  String get rateBildirim => '??Gracias por tus comentarios!';
  @override
  String get greet => ((0 <= DateTime.now().hour && DateTime.now().hour < 6) || DateTime.now().hour > 21)
      ? "BUENAS NOCHES"
      : (12 < saat && saat < 19)
          ? "BUENAS NOCHES"
          : (18 < saat && saat < 22)
              ? "BUENAS TARDES"
              : "BUENOS D??AS";
}

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'tr', 'fr', 'es'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (Locale(ui.window.locale.languageCode, ui.window.locale.countryCode).languageCode) {
      case 'en':
        return LanguageEN();
      case 'tr':
        return LanguageTR();
      case 'fr':
        return LanguageFR();
      case 'es':
        return LanguageES();
      default:
        return LanguageEN();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
