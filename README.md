# Flutter Radio And Verse App(+ PHP/MySql)
 
 # Packages

flutter_radio: ^0.1.8

  scoped_model: ^1.0.1
  
  google_fonts:
  
  esys_flutter_share:
  
  cached_network_image:
  
  image_gallery_saver:
  
  permission_handler:
  
  photo_view:
  
  fluttertoast:
  
  dio:
  
# Steps to Run the gallery With PHP/MySql

1) Create a table with phpmyadmin

CREATE TABLE `radioapp` (
  `id` int(255) NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `radioapp`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `radioapp`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

2) Change the link in the gallery.dart to Your link. PHP file is provided in the repo.


# ScreenShot

<img src="https://github.com/stevie1mat/Flutter-Christian-Radio-And-Verse-App/blob/main/radioapp.png">

