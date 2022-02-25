class Movie {
  final String title;
  final String imgUrl;
  final String overview;
  Movie({
    required this.title,
    required this.imgUrl,
    required this.overview,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie && other.title == title && other.imgUrl == imgUrl && other.overview == overview;
  }

  @override
  int get hashCode => title.hashCode ^ imgUrl.hashCode ^ overview.hashCode;
}
