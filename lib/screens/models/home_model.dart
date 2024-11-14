class HomeModel {
  String? name, number, email, image;
  bool? isFavourite, isHidden;

  HomeModel({
    this.name,
    this.number,
    this.email,
    this.image,
    this.isFavourite,
  });
}

class RecentModel {
  String? name, number, email, image;
  DateTime? date;

  RecentModel({
    this.name,
    this.number,
    this.email,
    this.image,
    this.date,
  });
}
