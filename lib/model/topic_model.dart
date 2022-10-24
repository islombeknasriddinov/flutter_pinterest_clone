import 'dart:convert';

List<Topic> topicFromJson(String str) => List<Topic>.from(json.decode(str).map((x) => Topic.fromJson(x)));

String topicToJson(List<Topic> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Topic {
  Topic({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.updatedAt,
    required this.startsAt,
    required this.endsAt,
    required this.onlySubmissionsAfter,
    required this.visibility,
    required this.featured,
    required this.totalPhotos,
    required this.currentUserContributions,
    required this.totalCurrentUserSubmissions,
    required this.links,
    required this.status,
    required this.owners,
    required this.coverPhoto,
    required this.previewPhotos,
  });

  String id;
  String slug;
  String title;
  String description;
  DateTime publishedAt;
  DateTime updatedAt;
  DateTime startsAt;
  DateTime endsAt;
  dynamic onlySubmissionsAfter;
  Visibility visibility;
  bool featured;
  int totalPhotos;
  List<dynamic> currentUserContributions;
  dynamic totalCurrentUserSubmissions;
  TopicLinks links;
  TopicStatus status;
  List<Owner> owners;
  CoverPhoto coverPhoto;
  List<PreviewPhoto> previewPhotos;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    id: json["id"],
    slug: json["slug"],
    title: json["title"],
    description: json["description"],
    publishedAt: DateTime.parse(json["published_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    startsAt: DateTime.parse(json["starts_at"]),
    endsAt:DateTime.parse(json["ends_at"]),
    onlySubmissionsAfter: json["only_submissions_after"],
    visibility: visibilityValues.map[json["visibility"]]!,
    featured: json["featured"],
    totalPhotos: json["total_photos"],
    currentUserContributions: List<dynamic>.from(json["current_user_contributions"].map((x) => x)),
    totalCurrentUserSubmissions: json["total_current_user_submissions"],
    links: TopicLinks.fromJson(json["links"]),
    status: topicStatusValues.map[json["status"]]!,
    owners: List<Owner>.from(json["owners"].map((x) => Owner.fromJson(x))),
    coverPhoto: CoverPhoto.fromJson(json["cover_photo"]),
    previewPhotos: List<PreviewPhoto>.from(json["preview_photos"].map((x) => PreviewPhoto.fromJson(x))),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "title": title,
    "description": description,
    "published_at": publishedAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "starts_at": startsAt.toIso8601String(),
    "ends_at": endsAt == null ? null : endsAt.toIso8601String(),
    "only_submissions_after": onlySubmissionsAfter,
    "visibility": visibilityValues.reverse[visibility],
    "featured": featured,
    "total_photos": totalPhotos,
    "current_user_contributions": List<dynamic>.from(currentUserContributions.map((x) => x)),
    "total_current_user_submissions": totalCurrentUserSubmissions,
    "links": links.toJson(),
    "status": topicStatusValues.reverse[status],
    "owners": List<dynamic>.from(owners.map((x) => x.toJson())),
    "cover_photo": coverPhoto.toJson(),
    "preview_photos": List<dynamic>.from(previewPhotos.map((x) => x.toJson())),
  };
}

class CoverPhoto {
  CoverPhoto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.promotedAt,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    required this.description,
    required this.altDescription,
    required this.urls,
    required this.links,
    required this.likes,
    required this.likedByUser,
    required this.currentUserCollections,
    required this.sponsorship,
    required this.topicSubmissions,
    required this.user,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? promotedAt;
  int width;
  int height;
  String color;
  String blurHash;
  String description;
  String altDescription;
  Urls urls;
  CoverPhotoLinks links;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  dynamic sponsorship;
  TopicSubmissions topicSubmissions;
  Owner user;

  factory CoverPhoto.fromJson(Map<String, dynamic> json) => CoverPhoto(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    promotedAt:DateTime.parse(json["promoted_at"]),
    width: json["width"],
    height: json["height"],
    color: json["color"],
    blurHash: json["blur_hash"],
    description: json["description"] == null ? null : json["description"],
    altDescription: json["alt_description"] == null ? null : json["alt_description"],
    urls: Urls.fromJson(json["urls"]),
    links: CoverPhotoLinks.fromJson(json["links"]),
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    currentUserCollections: List<dynamic>.from(json["current_user_collections"].map((x) => x)),
    sponsorship: json["sponsorship"],
    topicSubmissions: TopicSubmissions.fromJson(json["topic_submissions"]),
    user: Owner.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "promoted_at": promotedAt,
    "width": width,
    "height": height,
    "color": color,
    "blur_hash": blurHash,
    "description": description == null ? null : description,
    "alt_description": altDescription == null ? null : altDescription,
    "urls": urls.toJson(),
    "links": links.toJson(),
    "likes": likes,
    "liked_by_user": likedByUser,
    "current_user_collections": List<dynamic>.from(currentUserCollections.map((x) => x)),
    "sponsorship": sponsorship,
    "topic_submissions": topicSubmissions.toJson(),
    "user": user.toJson(),
  };
}

class CoverPhotoLinks {
  CoverPhotoLinks({
    required this.self,
    required this.html,
    required this.download,
    required this.downloadLocation,
  });

  String self;
  String html;
  String download;
  String downloadLocation;

  factory CoverPhotoLinks.fromJson(Map<String, dynamic> json) => CoverPhotoLinks(
    self: json["self"],
    html: json["html"],
    download: json["download"],
    downloadLocation: json["download_location"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "download": download,
    "download_location": downloadLocation,
  };
}

class TopicSubmissions {
  TopicSubmissions({
    required this.foodDrink,
    required this.currentEvents,
    required this.wallpapers,
    required this.film,
    required this.spirituality,
    required this.travel,
    required this.nature,
    required this.texturesPatterns,
    required this.the3DRenders,
    required this.artsCulture,
    required this.experimental,
    required this.architecture,
    required this.businessWork,
    required this.fashion,
  });

  The3DRenders foodDrink;
  The3DRenders currentEvents;
  The3DRenders wallpapers;
  ArtsCulture film;
  ArtsCulture spirituality;
  ArtsCulture travel;
  The3DRenders nature;
  The3DRenders texturesPatterns;
  The3DRenders the3DRenders;
  ArtsCulture artsCulture;
  The3DRenders experimental;
  The3DRenders architecture;
  The3DRenders businessWork;
  The3DRenders fashion;

  factory TopicSubmissions.fromJson(Map<String, dynamic> json) => TopicSubmissions(
    foodDrink:The3DRenders.fromJson(json["food-drink"]),
    currentEvents: The3DRenders.fromJson(json["current-events"]),
    wallpapers:The3DRenders.fromJson(json["wallpapers"]),
    film:ArtsCulture.fromJson(json["film"]),
    spirituality:ArtsCulture.fromJson(json["spirituality"]),
    travel:ArtsCulture.fromJson(json["travel"]),
    nature:The3DRenders.fromJson(json["nature"]),
    texturesPatterns:The3DRenders.fromJson(json["textures-patterns"]),
    the3DRenders:The3DRenders.fromJson(json["3d-renders"]),
    artsCulture:ArtsCulture.fromJson(json["arts-culture"]),
    experimental:The3DRenders.fromJson(json["experimental"]),
    architecture:The3DRenders.fromJson(json["architecture"]),
    businessWork:The3DRenders.fromJson(json["business-work"]),
    fashion:The3DRenders.fromJson(json["fashion"]),
  );

  Map<String, dynamic> toJson() => {
    "food-drink": foodDrink == null ? null : foodDrink.toJson(),
    "current-events": currentEvents == null ? null : currentEvents.toJson(),
    "wallpapers": wallpapers == null ? null : wallpapers.toJson(),
    "film": film == null ? null : film.toJson(),
    "spirituality": spirituality == null ? null : spirituality.toJson(),
    "travel": travel == null ? null : travel.toJson(),
    "nature": nature == null ? null : nature.toJson(),
    "textures-patterns": texturesPatterns == null ? null : texturesPatterns.toJson(),
    "3d-renders": the3DRenders == null ? null : the3DRenders.toJson(),
    "arts-culture": artsCulture == null ? null : artsCulture.toJson(),
    "experimental": experimental == null ? null : experimental.toJson(),
    "architecture": architecture == null ? null : architecture.toJson(),
    "business-work": businessWork == null ? null : businessWork.toJson(),
    "fashion": fashion == null ? null : fashion.toJson(),
  };
}

class The3DRenders {
  The3DRenders({
    required this.status,
    required this.approvedOn,
  });

  The3DRendersStatus status;
  DateTime approvedOn;
  factory The3DRenders.fromJson(Map<String, dynamic> json) => The3DRenders(
    status: the3DRendersStatusValues.map[json["status"]]!,
    approvedOn:DateTime.parse(json["approved_on"]),
  );

  Map<String, dynamic> toJson() => {
    "status": the3DRendersStatusValues.reverse[status],
    "approved_on": approvedOn == null ? null : approvedOn.toIso8601String(),
  };
}

enum The3DRendersStatus { APPROVED, UNEVALUATED }

final the3DRendersStatusValues = EnumValues({
  "approved": The3DRendersStatus.APPROVED,
  "unevaluated": The3DRendersStatus.UNEVALUATED
});

class ArtsCulture {
  ArtsCulture({
    required this.status,
  });

  String status;

  factory ArtsCulture.fromJson(Map<String, dynamic> json) => ArtsCulture(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}

class Urls {
  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  String raw;
  String full;
  String regular;
  String small;
  String thumb;
  String smallS3;


  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    raw: json["raw"],
    full: json["full"],
    regular: json["regular"],
    small: json["small"],
    thumb: json["thumb"],
    smallS3: json["small_s3"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "full": full,
    "regular": regular,
    "small": small,
    "thumb": thumb,
    "small_s3": smallS3,
  };
}

class Owner {
  Owner({
    required this.id,
    required this.updatedAt,
    required this.username,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.twitterUsername,
    required this.portfolioUrl,
    required this.bio,
    required this.location,
    required this.links,
    required this.profileImage,
    required this.instagramUsername,
    required this.totalCollections,
    required this.totalLikes,
    required this.totalPhotos,
    required this.acceptedTos,
    required this.forHire,
    required this.social,
  });

  String id;
  DateTime updatedAt;
  String username;
  String name;
  String firstName;
  String? lastName;
  String twitterUsername;
  String portfolioUrl;
  String bio;
  String location;
  OwnerLinks links;
  ProfileImage profileImage;
  String instagramUsername;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  bool acceptedTos;
  bool forHire;
  Social social;
  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    username: json["username"],
    name: json["name"],
    firstName: json["first_name"],
    lastName:json["last_name"],
    twitterUsername:json["twitter_username"],
    portfolioUrl:json["portfolio_url"],
    bio:json["bio"],
    location:json["location"],
    links: OwnerLinks.fromJson(json["links"]),
    profileImage: ProfileImage.fromJson(json["profile_image"]),
    instagramUsername:json["instagram_username"],
    totalCollections: json["total_collections"],
    totalLikes: json["total_likes"],
    totalPhotos: json["total_photos"],
    acceptedTos: json["accepted_tos"],
    forHire: json["for_hire"],
    social: Social.fromJson(json["social"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "updated_at": updatedAt.toIso8601String(),
    "username": username,
    "name": name,
    "first_name": firstName,
    //"last_name":lastName,
    "twitter_username": twitterUsername == null ? null : twitterUsername,
    "portfolio_url": portfolioUrl == null ? null : portfolioUrl,
    "bio": bio == null ? null : bio,
    "location": location == null ? null : location,
    "links": links.toJson(),
    "profile_image": profileImage.toJson(),
    "instagram_username": instagramUsername == null ? null : instagramUsername,
    "total_collections": totalCollections,
    "total_likes": totalLikes,
    "total_photos": totalPhotos,
    "accepted_tos": acceptedTos,
    "for_hire": forHire,
    "social": social.toJson(),
  };
}

class OwnerLinks {
  OwnerLinks({
    required this.self,
    required this.html,
    required this.photos,
    required this.likes,
    required this.portfolio,
    required this.following,
    required this.followers,
  });

  String self;
  String html;
  String photos;
  String likes;
  String portfolio;
  String following;
  String followers;

  factory OwnerLinks.fromJson(Map<String, dynamic> json) => OwnerLinks(
    self: json["self"],
    html: json["html"],
    photos: json["photos"],
    likes: json["likes"],
    portfolio: json["portfolio"],
    following: json["following"],
    followers: json["followers"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "photos": photos,
    "likes": likes,
    "portfolio": portfolio,
    "following": following,
    "followers": followers,
  };
}

class ProfileImage {
  ProfileImage({
    required this.small,
    required this.medium,
    required this.large,
  });

  String small;
  String medium;
  String large;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
    small: json["small"],
    medium: json["medium"],
    large: json["large"],
  );

  Map<String, dynamic> toJson() => {
    "small": small,
    "medium": medium,
    "large": large,
  };
}

class Social {
  Social({
    required this.instagramUsername,
    required this.portfolioUrl,
    required this.twitterUsername,
    required this.paypalEmail,
  });

  String instagramUsername;
  String portfolioUrl;
  String twitterUsername;
  dynamic paypalEmail;


  factory Social.fromJson(Map<String, dynamic> json) => Social(
    instagramUsername: json["instagram_username"] == null ? null : json["instagram_username"],
    portfolioUrl: json["portfolio_url"] == null ? null : json["portfolio_url"],
    twitterUsername: json["twitter_username"] == null ? null : json["twitter_username"],
    paypalEmail: json["paypal_email"],
  );

  Map<String, dynamic> toJson() => {
    "instagram_username": instagramUsername == null ? null : instagramUsername,
    "portfolio_url": portfolioUrl == null ? null : portfolioUrl,
    "twitter_username": twitterUsername == null ? null : twitterUsername,
    "paypal_email": paypalEmail,
  };
}

class TopicLinks {
  TopicLinks({
    required this.self,
    required this.html,
    required this.photos,
  });

  String self;
  String html;
  String photos;

  factory TopicLinks.fromJson(Map<String, dynamic> json) => TopicLinks(
    self: json["self"],
    html: json["html"],
    photos: json["photos"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "photos": photos,
  };
}

class PreviewPhoto {
  PreviewPhoto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.blurHash,
    required this.urls,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String blurHash;
  Urls urls;

  factory PreviewPhoto.fromJson(Map<String, dynamic> json) => PreviewPhoto(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    blurHash: json["blur_hash"],
    urls: Urls.fromJson(json["urls"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "blur_hash": blurHash,
    "urls": urls.toJson(),
  };
}

enum TopicStatus { OPEN }

final topicStatusValues = EnumValues({
  "open": TopicStatus.OPEN
});

enum Visibility { FEATURED }

final visibilityValues = EnumValues({
  "featured": Visibility.FEATURED
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
