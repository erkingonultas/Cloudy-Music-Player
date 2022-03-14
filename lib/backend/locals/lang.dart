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
  String get musicPlayer => 'müzik çalar';
  @override
  String get designed => 'Dizayn eden';
  @override
  String get tested => 'Test eden';
  @override
  String get freeVer => 'ÜCRETSİZ SÜRÜM';
  @override
  String get paidVer => 'TAM SÜRÜM';
  @override
  String get archiveLabel => "ARŞİV";

  @override
  String get homeLabel => "MERKEZ";

  @override
  String get libraryLabel => "KÜTÜPHANE";

  @override
  String get recLabel1 => "APOLLO'NUN ÖNERİSİ";

  @override
  String get recLabel2 => "şuna ne dersin?";
  @override
  String get albums => 'ALBÜMLER';
  @override
  String get libToolTip => 'çalma listesi oluştur';
  @override
  String get notPlaying => 'duraklatıldı';
  @override
  String get favorites => 'Favoriler';
  @override
  String get playlists => 'çalma listeleri';
  @override
  String get noPlaylists => 'çalma listen yok gibi görünüyor';
  @override
  String get favText => 'Henüz bir favorin yok!';
  @override
  String get favText2 => 'daha fazla şarkı';
  @override
  String get shufflePla => 'KARIŞTIR';
  @override
  String get playPla => 'OYNAT';
  @override
  String get textPla => 'aradığın liste boş görünüyor!';
  @override
  String get text2Pla => 'daha fazla şarkı';
  @override
  String get delPla => 'KALDIR';
  @override
  String get editPla => 'DÜZENLE';
  @override
  String get deleted => 'silindi';
  @override
  String get cancel => 'İPTAL';
  @override
  String get crePlaText1 => 'çalma listenize bir isim verin';
  @override
  String get crePlaText2 => 've bir kapak seçin';
  @override
  String get crePlaText3 => '(isteğe bağlı)';
  @override
  String get tracks => 'parça';
  @override
  String get shuffleArc => 'KARIŞTIR';
  @override
  String get searchText => 'temizle';
  @override
  String get search => 'a r a';
  @override
  String get addFav1 => 'favorilere ekle';
  @override
  String get remFav1 => 'favorilerden çıkar';
  @override
  String get addFav2 => 'favorilerine eklendi!';
  @override
  String get remFav2 => 'favorilerinden çıkartıldı!';
  @override
  String get addSongTo => 'şarkı şuraya eklendi:';
  @override
  String get addToPla => 'çalma listesine ekle';
  @override
  String get newPla => 'yeni liste';
  @override
  String get newPlaWarn1 => 'İsim alanı boş kalmamalı.';
  @override
  String get newPlaWarn2 => 'İsmin uzunluğu 1-18 karakter arasında olmalı.';
  @override
  String get newPlaWarn3 => 'Lütfen bir isim seçin.';
  @override
  String get done => 'B İ T İ R';
  @override
  String get playing => 'O Y N A T';
  @override
  String get confirm => 'ONAYLA';
  @override
  String get undo => 'geri al';
  @override
  String get qEmpty => "liste boş";
  @override
  String get noSongs => 'Cihazınızda müzik bulunamadı.';
  @override
  String get editSong => 'ÖZELLEŞTİR';
  @override
  String get customYSong => 'şarkını özelleştir';
  @override
  String get title => 'başlık';
  @override
  String get artist => 'sanatçı';
  @override
  String get remSongFromPla => 'Seçtiğin şarkılar listeden kaldırılacak!\nDeğişiklikler kaydedilsin mi?';
  @override
  String get hideSong => 'ŞARKILARI GİZLE';
  @override
  String get changeCoverPla => 'Çalma listesi kapağı değişti!\nDeğişiklikler kaydedilsin mi?';
  @override
  String get save => 'KAYDET';
  @override
  String get confirmChanges => 'Değişiklikleri kaydet?';
  @override
  String get duration => 'Süre';
  @override
  String get musicError1 => 'Müzikler yüklenemedi. Lütfen daha sonra tekrar deneyin.';
  @override
  String get musicError2 => 'Google Play Faturalandırma Servisi başlatılamıyor, lütfen tekrar deneyin.';
  @override
  String get standby0 => 'Müzik aranıyor';
  @override
  String get standby1 => 'çalma listeleri hazırlanıyor';
  @override
  String get standby2 => 'Favoriler ayarlanıyor';
  @override
  String get standby3 => 'İşlem tamamlandı';
  @override
  String get standby4 => 'Arayüz başlatılıyor...';
  @override
  String get conRefresh => 'Şarkıları ve çalma listelerini yenilemek istiyor musunuz?';
  @override
  String get unlockAllF => 'Bütün Özellikleri Aç';
  @override
  String get connecting => 'Bağlanıyor...';
  @override
  String get notConnected => 'Bağlanılamadı';
  @override
  String get storeIsAvailable => 'Market kullanılabilir';
  @override
  String get storeIsNotAvailable => 'Market kullanılamaz';
  @override
  String get onPro => 'Zaten tam sürümü kullanmaktasınız.';
  @override
  String get onFree => 'Ücretsiz sürümü kullanmaktasınız.';
  @override
  String get purchase => 'SATIN AL';
  @override
  String get proFeatures => 'Şarkılarını özelleştir,\nSınırsız sayıda çalma listesi oluştur\nve reklamsız bir deneyim yaşa.';
  @override
  String get promoT1 => 'Şarkılarını özelleştir';
  @override
  String get promoT2 => 'Sınırsız sayıda çalma listesi oluştur';
  @override
  String get promoT3 => 've\nreklamsız bir deneyim yaşa.';
  @override
  String get later => 'SONRA';
  @override
  String get rate => 'DEĞERLENDİR';
  @override
  String get rateTitle => 'Uygulamamızdan memnun musunuz?';
  @override
  String get ratemessage => 'Kısa bir değerlendirme yapmak ister misiniz?';
  @override
  String get rateBildirim => 'Geri bildiriminiz için teşekkür ederiz!';
  @override
  String get greet => ((0 <= DateTime.now().hour && DateTime.now().hour < 6) || DateTime.now().hour > 21)
      ? "İYİ GECELER"
      : (12 < saat && saat < 19)
          ? "İYİ GÜNLER"
          : (18 < saat && saat < 22)
              ? "İYİ AKŞAMLAR"
              : "GÜNAYDIN";
}

class LanguageFR extends Languages {
  @override
  String get musicPlayer => 'joueur de musique';
  @override
  String get designed => 'Conçu par';
  @override
  String get tested => 'Testé par';
  @override
  String get freeVer => 'VERSION GRATUITE';
  @override
  String get paidVer => 'VERSION COMPLÈTE';
  @override
  String get archiveLabel => "ARCHIVES";
  @override
  String get homeLabel => "DOMICILE";
  @override
  String get libraryLabel => "BIBLIOTHÈQUE";
  @override
  String get recLabel1 => "APOLLO RECOMMANDE";
  @override
  String get recLabel2 => "qu'en est-il de...";
  @override
  String get albums => 'ALBUMS';
  @override
  String get libToolTip => 'créer une playlist';
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
  String get shufflePla => 'MÉLANGER';
  @override
  String get playPla => 'JOUER';
  @override
  String get textPla => 'La liste que vous cherchez est vide !';
  @override
  String get text2Pla => 'PLUS DE MUSIQUES';
  @override
  String get delPla => 'EFFACER';
  @override
  String get editPla => 'ÉDITER';
  @override
  String get deleted => 'supprimé';
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
  String get shuffleArc => 'MÉLANGER';
  @override
  String get searchText => 'clear';
  @override
  String get search => 'c h e r c h e r';
  @override
  String get addFav1 => 'ajouter des favoris';
  @override
  String get remFav1 => 'supprimer le favori';
  @override
  String get addFav2 => 'ajouté à vos favoris!';
  @override
  String get remFav2 => 'supprimé de vos favoris!';
  @override
  String get addSongTo => 'musique ajoutée à';
  @override
  String get addToPla => 'ajouter à la playlist';
  @override
  String get newPla => 'nouvelle playlist';
  @override
  String get newPlaWarn1 => 'Le nom ne peut pas être vide.';
  @override
  String get newPlaWarn2 => 'La longueur du nom doit être comprise entre 1 et 18.';
  @override
  String get newPlaWarn3 => 'Veuillez définir un nom.';
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
  String get noSongs => 'Il n\'y a pas de musiques trouvées sur votre appareil.';
  @override
  String get editSong => 'PERSONNALISER';
  @override
  String get customYSong => 'personnalisez votre musique';
  @override
  String get title => 'titre';
  @override
  String get artist => 'artiste';
  @override
  String get remSongFromPla => 'Les musiques sélectionnées seront supprimées de la liste!\nEnregistrer les changements?';
  @override
  String get hideSong => 'MASQUER LES CHANSONS';
  @override
  String get changeCoverPla => 'La couverture de l\'album est modifiée!\nEnregistrer les changements?';
  @override
  String get save => 'enregistrer';
  @override
  String get confirmChanges => 'Confirmez les changements?';
  @override
  String get duration => 'Durée';
  @override
  String get musicError1 => 'La musique ne peut pas être chargée, veuillez réessayer.';
  @override
  String get musicError2 => 'Google Play Billing Services ne peut pas être initialisé, veuillez réessayer.';
  @override
  String get standby0 => 'Recherche de musiques';
  @override
  String get standby1 => 'Récupérer des playlists';
  @override
  String get standby2 => 'Préparer les favoris';
  @override
  String get standby3 => 'Processus Terminé';
  @override
  String get standby4 => 'Initialisation de l\'UI...';
  @override
  String get conRefresh => 'Voulez-vous rafraichir les musiques et les playlists?';
  @override
  String get unlockAllF => 'Débloquez Toutes les Fonctionnalités';
  @override
  String get connecting => 'Connexion...';
  @override
  String get notConnected => 'Pas connecté';
  @override
  String get purchase => 'ACHETER';
  @override
  String get storeIsAvailable => 'Le magasin est disponible';
  @override
  String get storeIsNotAvailable => 'Le magasin est indisponible';
  @override
  String get onPro => 'Vous utilisez déjà la version complète.';
  @override
  String get onFree => 'Vous utilisez la version gratuite.';
  @override
  String get proFeatures => 'Personnalisez toutes vos musiques,\ncréez un nombre illimité de playlist,\net\ns\'amuser d\'une expérience sans publicité.';
  @override
  String get promoT1 => 'Personnalisez toutes vos musiques';
  @override
  String get promoT2 => 'créez un nombre illimité de playlist';
  @override
  String get promoT3 => 'et\ns\'amuser d\'une expérience sans publicité.';
  @override
  String get later => 'PLUS TARD';
  @override
  String get rate => 'ÉVALUER';
  @override
  String get rateTitle => 'Appréciez-vous l\'application jusqu\'à présent?';
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
              ? "BONNE APRÈS-MIDI"
              : "BONJOUR";
}

class LanguageES extends Languages {
  @override
  String get musicPlayer => 'reproductor de música';
  @override
  String get designed => 'Diseñada por';
  @override
  String get tested => 'Probado por';
  @override
  String get freeVer => 'VERSIÓN GRATUITA';
  @override
  String get paidVer => 'VERSIÓN COMPLETA';
  @override
  String get archiveLabel => "ARCHIVO";
  @override
  String get homeLabel => "CASA";
  @override
  String get libraryLabel => "BIBLIOTECA";
  @override
  String get recLabel1 => "APOLLO RECOMIENDA";
  @override
  String get recLabel2 => "qué pasa...";
  @override
  String get albums => 'ÁLBUMES';
  @override
  String get libToolTip => 'crear una lista de reproducción';
  @override
  String get notPlaying => 'No jugando';
  @override
  String get favorites => 'Favoritas';
  @override
  String get playlists => 'playlists';
  @override
  String get noPlaylists => 'Parece que no hay\nlistas de reproducción.';
  @override
  String get favText => '¡Aún no hay favoritos!';
  @override
  String get favText2 => 'MÁS CANCIONES';
  @override
  String get shufflePla => 'BARAJAR';
  @override
  String get playPla => 'TOCAR';
  @override
  String get textPla => '¡La lista que buscas está vacía!';
  @override
  String get text2Pla => 'MÁS CANCIONES';
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
  String get addFav2 => 'Añadido a tus favoritas!';
  @override
  String get remFav2 => 'Eliminada de tus favoritas!';
  @override
  String get addSongTo => 'canción añadida a';
  @override
  String get addToPla => 'agregar a la lista de reproducción';
  @override
  String get newPla => 'nueva playlist';
  @override
  String get newPlaWarn1 => 'El nombre no puede estar vacío.';
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
  String get qEmpty => "la cola está vacía";
  @override
  String get noSongs => 'No se han encontrado canciones en su dispositivo.';
  @override
  String get editSong => 'PERSONALIZAR';
  @override
  String get customYSong => 'personaliza tu canción';
  @override
  String get title => 'título';
  @override
  String get artist => 'artista';
  @override
  String get remSongFromPla => '¡Las canciones seleccionadas serán eliminadas de la lista!\n¿Guardar cambios?';
  @override
  String get hideSong => 'OCULTAR CANCIONES';
  @override
  String get changeCoverPla => '¡La portada está cambiada!\n¿Guardar cambios?';
  @override
  String get save => 'AHORRAR';
  @override
  String get confirmChanges => '¿Confirmar los cambios?';
  @override
  String get duration => 'Duración';
  @override
  String get musicError1 => 'No se puede cargar la música, inténtalo de nuevo.';
  @override
  String get musicError2 => 'Los servicios de facturación de Google Play no se pueden inicializar, inténtalo de nuevo.';
  @override
  String get standby0 => 'Buscando musicas';
  @override
  String get standby1 => 'Obtener listas de reproducción';
  @override
  String get standby2 => 'Preparando favoritos';
  @override
  String get standby3 => 'Proceso Completado';
  @override
  String get standby4 => 'Inicializando UI...';
  @override
  String get conRefresh => '¿Quieres actualizar canciones y listas de reproducción?';
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
  String get storeIsNotAvailable => 'La tienda no está disponible.';
  @override
  String get onPro => 'Ya estás usando la versión completa.';
  @override
  String get onFree => 'Estás usando la versión gratuita.';
  @override
  String get proFeatures => 'Personalice todas sus canciones,\n\ncrear listas de reproducción ilimitadas,\ny\ndisfruta de una experiencia sin publicidad.';
  @override
  String get promoT1 => 'Personalice todas sus canciones';
  @override
  String get promoT2 => 'crear listas de reproducción ilimitadas';
  @override
  String get promoT3 => 'y\ndisfruta de una experiencia sin publicidad.';
  @override
  String get later => 'MÁS TARDE';
  @override
  String get rate => 'CALIFICAR';
  @override
  String get rateTitle => '¿Estás disfrutando de la aplicación hasta ahora?';
  @override
  String get ratemessage => '¿Te gustaría dejar una reseña?';
  @override
  String get rateBildirim => '¡Gracias por tus comentarios!';
  @override
  String get greet => ((0 <= DateTime.now().hour && DateTime.now().hour < 6) || DateTime.now().hour > 21)
      ? "BUENAS NOCHES"
      : (12 < saat && saat < 19)
          ? "BUENAS NOCHES"
          : (18 < saat && saat < 22)
              ? "BUENAS TARDES"
              : "BUENOS DÍAS";
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
