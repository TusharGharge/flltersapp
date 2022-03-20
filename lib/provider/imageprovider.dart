import 'package:demoapp/provider/imageinfo.dart';
import 'package:flutter/cupertino.dart';

class Imagedataprovider with ChangeNotifier {
  final List<image> imageclass = [image(imagedata: "https://i.pinimg.com/originals/1b/f3/46/1bf3463c3ecd0911b891aecb7c11a91a.jpg",),image(imagedata: 'https://upload.wikimedia.org/wikipedia/commons/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg',),
  image(imagedata: 'https://variety.com/wp-content/uploads/2021/07/Logan-Paul.jpeg'),
   image(imagedata: 'https://variety.com/wp-content/uploads/2021/07/Logan-Paul.jpeg'),
    image(imagedata: 'https://variety.com/wp-content/uploads/2021/07/Logan-Paul.jpeg'),

  ];

  List<image> get orders {
    return [...imageclass];
  }


}
