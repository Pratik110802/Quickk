import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExploreCard {
  ExploreCard(this.title, this.cardcolor, this.exploredata, this.cardicon);
  final Color cardcolor;
  final String title;
  final List<ExploreViewdata> exploredata;
  final IconData cardicon;
}

class ExploreViewdata {
  ExploreViewdata(this.viewcolor, this.urltitle, this.url);

  final Color viewcolor;
  final String urltitle;
  final String url;
}
