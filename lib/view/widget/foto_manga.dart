import 'package:flutter/material.dart';
import 'package:mdesk/view/dto/manga.dart';

class FotoManga extends StatelessWidget{
  final Manga manga;
  final double? altura;
  final double? largura;
  const FotoManga({required this.manga, this.altura = 100, this.largura = 100, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    String url = manga.urlAvatar;
    if(Uri.tryParse(url)!.isAbsolute){
      return Container(
        width: largura,
        height: altura,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(url),
          ),
        ),
      );
    }else {
      return Container(
        width: largura,
        height: altura,
        color: Colors.grey,
        child: Icon(
          Icons.book,
          color: Colors.white,
        ),
      );
    }
  }
}