import 'package:flutter/material.dart';
import 'package:flutter_base/models/entity/movie_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

typedef void MovieCellPressed(MovieEntity movieEntity);

class MovieCell extends StatelessWidget {
  MovieEntity _movieEntity;
  MovieCellPressed _onPressed;

  MovieCell(this._movieEntity, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[100], width: 1.0),
              borderRadius: new BorderRadius.all(Radius.circular(2.0)),
              image: DecorationImage(
                image: CachedNetworkImageProvider(_movieEntity.getPosterPath()),
                fit: BoxFit.cover,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              if (_onPressed != null) {
                _onPressed(_movieEntity);
              }
            },
            child: Container(),
          ),
        ],
      ),
    );
  }
}

class LoadingMovieCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.white,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
                height: 16.0,
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
                height: 16.0,
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
                height: 32.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}