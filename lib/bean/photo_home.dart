import 'dart:convert';

class PhotoHome {
  static List<PhotoHome> photoHomeListFromJson(String str) {
    if (str.isNotEmpty) {
      return (jsonDecode(str) as List<dynamic>).map((e) => PhotoHome.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  String id;
  String? createdAt;
  String? updatedAt;
  String? promotedAt;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  String? description;
  String? altDescription;
  Urls? urls;
  Links? links;
  List? categories;
  int? likes;
  bool? likedByUser;
  List? currentUserCollections;
  Sponsorship? sponsorship;
  TopicSubmissions? topicSubmissions;
  User? user;

  PhotoHome({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.categories,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.sponsorship,
    this.topicSubmissions,
    this.user,
  });

  factory PhotoHome.fromJson(Map<String, dynamic> json) {
    List categories = [];
    List currentUserCollections = [];
    if (json['categories'] is List) {
      List res = json['categories'] as List;
      for (var category in res) {
        categories.add(category);
      }
    }

    if (json['current_user_collections'] is List) {
      List res = json['current_user_collections'] as List;
      for (var collection in res) {
        currentUserCollections.add(collection);
      }
    }

    return PhotoHome(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      promotedAt: json['promoted_at'],
      width: json['width'],
      height: json['height'],
      color: json['color'],
      blurHash: json['blur_hash'],
      description: json['description'],
      altDescription: json['alt_description'],
      urls: json['urls'] != null ? Urls.fromJson(json['urls']) : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
      categories: categories,
      likes: json['likes'],
      likedByUser: json['liked_by_user'],
      currentUserCollections: currentUserCollections,
      sponsorship: json['sponsorship'] != null ? Sponsorship.fromJson(json['sponsorship']) : null,
      topicSubmissions: json['topic_submissions'] != null
          ? TopicSubmissions.fromJson(json['topic_submissions'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class Urls {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smallS3,
  });

  Urls.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
    smallS3 = json['small_s3'];
  }
}

class Links {
  String? self;
  String? html;
  String? download;
  String? downloadLocation;

  Links({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    html = json['html'];
    download = json['download'];
    downloadLocation = json['download_location'];
  }
}

class Sponsorship {
  List<String>? impressionUrls;
  String? tagline;
  String? taglineUrl;
  Sponsor? sponsor;

  Sponsorship({
    this.impressionUrls,
    this.tagline,
    this.taglineUrl,
    this.sponsor,
  });

  Sponsorship.fromJson(Map<String, dynamic> json) {
    impressionUrls = json['impression_urls'].cast<String>();
    tagline = json['tagline'];
    taglineUrl = json['tagline_url'];
    sponsor = json['sponsor'] != null ? Sponsor.fromJson(json['sponsor']) : null;
  }
}

class Sponsor {
  String? id;
  String? updatedAt;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? twitterUsername;
  String? portfolioUrl;
  String? bio;
  String? location;
  UserLinks? userLinks;
  ProfileImage? profileImage;
  String? instagramUsername;
  int? totalCollections;
  int? totalLikes;
  int? totalPhotos;
  bool? acceptedTos;
  bool? forHire;
  Social? social;

  Sponsor({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.userLinks,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.acceptedTos,
    this.forHire,
    this.social,
  });

  Sponsor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    twitterUsername = json['twitter_username'];
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'];
    userLinks = json['links'] != null ? UserLinks.fromJson(json['links']) : null;
    profileImage =
        json['profile_image'] != null ? ProfileImage.fromJson(json['profile_image']) : null;
    instagramUsername = json['instagram_username'];
    totalCollections = json['total_collections'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    acceptedTos = json['accepted_tos'];
    forHire = json['for_hire'];
    social = json['social'] != null ? Social.fromJson(json['social']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['updated_at'] = updatedAt;
    data['username'] = username;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['twitter_username'] = twitterUsername;
    data['portfolio_url'] = portfolioUrl;
    data['bio'] = bio;
    data['location'] = location;
    if (userLinks != null) {
      data['links'] = userLinks!.toJson();
    }
    if (profileImage != null) {
      data['profile_image'] = profileImage!.toJson();
    }
    data['instagram_username'] = instagramUsername;
    data['total_collections'] = totalCollections;
    data['total_likes'] = totalLikes;
    data['total_photos'] = totalPhotos;
    data['accepted_tos'] = acceptedTos;
    data['for_hire'] = forHire;
    if (social != null) {
      data['social'] = social!.toJson();
    }
    return data;
  }
}

class UserLinks {
  String? self;
  String? html;
  String? photos;
  String? likes;
  String? portfolio;
  String? following;
  String? followers;

  UserLinks({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  UserLinks.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    html = json['html'];
    photos = json['photos'];
    likes = json['likes'];
    portfolio = json['portfolio'];
    following = json['following'];
    followers = json['followers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['self'] = self;
    data['html'] = html;
    data['photos'] = photos;
    data['likes'] = likes;
    data['portfolio'] = portfolio;
    data['following'] = following;
    data['followers'] = followers;
    return data;
  }
}

class ProfileImage {
  String? small;
  String? medium;
  String? large;

  ProfileImage({this.small, this.medium, this.large});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['small'] = small;
    data['medium'] = medium;
    data['large'] = large;
    return data;
  }
}

class Social {
  String? instagramUsername;
  String? portfolioUrl;
  String? twitterUsername;
  String? paypalEmail;

  Social({this.instagramUsername, this.portfolioUrl, this.twitterUsername, this.paypalEmail});

  Social.fromJson(Map<String, dynamic> json) {
    instagramUsername = json['instagram_username'];
    portfolioUrl = json['portfolio_url'];
    twitterUsername = json['twitter_username'];
    paypalEmail = json['paypal_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['instagram_username'] = instagramUsername;
    data['portfolio_url'] = portfolioUrl;
    data['twitter_username'] = twitterUsername;
    data['paypal_email'] = paypalEmail;
    return data;
  }
}

class TopicSubmissions {
  Interiors? interiors;
  Interiors? businessWork;
  Interiors? architectureInterior;

  TopicSubmissions({this.interiors, this.businessWork, this.architectureInterior});

  TopicSubmissions.fromJson(Map<String, dynamic> json) {
    interiors = json['interiors'] != null ? Interiors.fromJson(json['interiors']) : null;
    businessWork = json['business-work'] != null ? Interiors.fromJson(json['business-work']) : null;
    architectureInterior = json['architecture-interior'] != null
        ? Interiors.fromJson(json['architecture-interior'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (interiors != null) {
      data['interiors'] = interiors!.toJson();
    }
    if (businessWork != null) {
      data['business-work'] = businessWork!.toJson();
    }
    if (architectureInterior != null) {
      data['architecture-interior'] = architectureInterior!.toJson();
    }
    return data;
  }
}

class Interiors {
  String? status;
  String? approvedOn;

  Interiors({this.status, this.approvedOn});

  Interiors.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    approvedOn = json['approved_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['approved_on'] = approvedOn;
    return data;
  }
}

class User {
  String? id;
  String? updatedAt;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? twitterUsername;
  String? portfolioUrl;
  String? bio;
  String? location;
  Links? links;
  ProfileImage? profileImage;
  String? instagramUsername;
  int? totalCollections;
  int? totalLikes;
  int? totalPhotos;
  bool? acceptedTos;
  bool? forHire;
  Social? social;

  User({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.links,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.acceptedTos,
    this.forHire,
    this.social,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    twitterUsername = json['twitter_username'];
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    profileImage =
        json['profile_image'] != null ? ProfileImage.fromJson(json['profile_image']) : null;
    instagramUsername = json['instagram_username'];
    totalCollections = json['total_collections'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    acceptedTos = json['accepted_tos'];
    forHire = json['for_hire'];
    social = json['social'] != null ? Social.fromJson(json['social']) : null;
  }
}
