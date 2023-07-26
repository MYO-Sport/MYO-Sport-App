// To parse this JSON data, do
//
//     final slackUsersModel = slackUsersModelFromJson(jsonString);

import 'dart:convert';

SlackUsersModel slackUsersModelFromJson(String str) =>
    SlackUsersModel.fromJson(json.decode(str));

String slackUsersModelToJson(SlackUsersModel data) =>
    json.encode(data.toJson());

class SlackUsersModel {
  bool ok;
  List<Member> members;
  int cacheTs;
  ResponseMetadata responseMetadata;

  SlackUsersModel({
    required this.ok,
    required this.members,
    required this.cacheTs,
    required this.responseMetadata,
  });

  factory SlackUsersModel.fromJson(Map<String, dynamic> json) =>
      SlackUsersModel(
        ok: json["ok"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        cacheTs: json["cache_ts"],
        responseMetadata: ResponseMetadata.fromJson(json["response_metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "cache_ts": cacheTs,
        "response_metadata": responseMetadata.toJson(),
      };
}

class Member {
  String id;
  Team teamId;
  String name;
  bool deleted;
  String color;
  String realName;
  Tz tz;
  TzLabel tzLabel;
  int tzOffset;
  Profile profile;
  bool isAdmin;
  bool isOwner;
  bool isPrimaryOwner;
  bool isRestricted;
  bool isUltraRestricted;
  bool isBot;
  bool isAppUser;
  int updated;
  bool isEmailConfirmed;
  WhoCanShareContactCard whoCanShareContactCard;
  bool? has2Fa;

  Member({
    required this.id,
    required this.teamId,
    required this.name,
    required this.deleted,
    required this.color,
    required this.realName,
    required this.tz,
    required this.tzLabel,
    required this.tzOffset,
    required this.profile,
    required this.isAdmin,
    required this.isOwner,
    required this.isPrimaryOwner,
    required this.isRestricted,
    required this.isUltraRestricted,
    required this.isBot,
    required this.isAppUser,
    required this.updated,
    required this.isEmailConfirmed,
    required this.whoCanShareContactCard,
    this.has2Fa,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        teamId: teamValues.map[json["team_id"]]!,
        name: json["name"],
        deleted: json["deleted"],
        color: json["color"],
        realName: json["real_name"],
        tz: tzValues.map[json["tz"]]!,
        tzLabel: tzLabelValues.map[json["tz_label"]]!,
        tzOffset: json["tz_offset"],
        profile: Profile.fromJson(json["profile"]),
        isAdmin: json["is_admin"],
        isOwner: json["is_owner"],
        isPrimaryOwner: json["is_primary_owner"],
        isRestricted: json["is_restricted"],
        isUltraRestricted: json["is_ultra_restricted"],
        isBot: json["is_bot"],
        isAppUser: json["is_app_user"],
        updated: json["updated"],
        isEmailConfirmed: json["is_email_confirmed"],
        whoCanShareContactCard: whoCanShareContactCardValues
            .map[json["who_can_share_contact_card"]]!,
        has2Fa: json["has_2fa"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "team_id": teamValues.reverse[teamId],
        "name": name,
        "deleted": deleted,
        "color": color,
        "real_name": realName,
        "tz": tzValues.reverse[tz],
        "tz_label": tzLabelValues.reverse[tzLabel],
        "tz_offset": tzOffset,
        "profile": profile.toJson(),
        "is_admin": isAdmin,
        "is_owner": isOwner,
        "is_primary_owner": isPrimaryOwner,
        "is_restricted": isRestricted,
        "is_ultra_restricted": isUltraRestricted,
        "is_bot": isBot,
        "is_app_user": isAppUser,
        "updated": updated,
        "is_email_confirmed": isEmailConfirmed,
        "who_can_share_contact_card":
            whoCanShareContactCardValues.reverse[whoCanShareContactCard],
        "has_2fa": has2Fa,
      };
}

class Profile {
  String title;
  Phone phone;
  String skype;
  String realName;
  String realNameNormalized;
  String displayName;
  String displayNameNormalized;
  Fields? fields;
  String statusText;
  String statusEmoji;
  List<dynamic> statusEmojiDisplayInfo;
  int statusExpiration;
  String avatarHash;
  bool? alwaysActive;
  String firstName;
  String lastName;
  String image24;
  String image32;
  String image48;
  String image72;
  String image192;
  String image512;
  String statusTextCanonical;
  Team team;
  String? imageOriginal;
  bool? isCustomImage;
  String? email;
  String? huddleState;
  int? huddleStateExpirationTs;
  String? image1024;
  WhoCanShareContactCard? whoCanShareContactCard;
  String? apiAppId;
  String? botId;

  Profile({
    required this.title,
    required this.phone,
    required this.skype,
    required this.realName,
    required this.realNameNormalized,
    required this.displayName,
    required this.displayNameNormalized,
    this.fields,
    required this.statusText,
    required this.statusEmoji,
    required this.statusEmojiDisplayInfo,
    required this.statusExpiration,
    required this.avatarHash,
    this.alwaysActive,
    required this.firstName,
    required this.lastName,
    required this.image24,
    required this.image32,
    required this.image48,
    required this.image72,
    required this.image192,
    required this.image512,
    required this.statusTextCanonical,
    required this.team,
    this.imageOriginal,
    this.isCustomImage,
    this.email,
    this.huddleState,
    this.huddleStateExpirationTs,
    this.image1024,
    this.whoCanShareContactCard,
    this.apiAppId,
    this.botId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        title: json["title"],
        phone: phoneValues.map[json["phone"]]!,
        skype: json["skype"],
        realName: json["real_name"],
        realNameNormalized: json["real_name_normalized"],
        displayName: json["display_name"],
        displayNameNormalized: json["display_name_normalized"],
        fields: json["fields"] == null ? null : Fields.fromJson(json["fields"]),
        statusText: json["status_text"],
        statusEmoji: json["status_emoji"],
        statusEmojiDisplayInfo:
            List<dynamic>.from(json["status_emoji_display_info"].map((x) => x)),
        statusExpiration: json["status_expiration"],
        avatarHash: json["avatar_hash"],
        alwaysActive: json["always_active"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image24: json["image_24"],
        image32: json["image_32"],
        image48: json["image_48"],
        image72: json["image_72"],
        image192: json["image_192"],
        image512: json["image_512"],
        statusTextCanonical: json["status_text_canonical"],
        team: teamValues.map[json["team"]]!,
        imageOriginal: json["image_original"],
        isCustomImage: json["is_custom_image"],
        email: json["email"],
        huddleState: json["huddle_state"],
        huddleStateExpirationTs: json["huddle_state_expiration_ts"],
        image1024: json["image_1024"],
        whoCanShareContactCard: whoCanShareContactCardValues
            .map[json["who_can_share_contact_card"]],
        apiAppId: json["api_app_id"],
        botId: json["bot_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "phone": phoneValues.reverse[phone],
        "skype": skype,
        "real_name": realName,
        "real_name_normalized": realNameNormalized,
        "display_name": displayName,
        "display_name_normalized": displayNameNormalized,
        "fields": fields?.toJson(),
        "status_text": statusText,
        "status_emoji": statusEmoji,
        "status_emoji_display_info":
            List<dynamic>.from(statusEmojiDisplayInfo.map((x) => x)),
        "status_expiration": statusExpiration,
        "avatar_hash": avatarHash,
        "always_active": alwaysActive,
        "first_name": firstName,
        "last_name": lastName,
        "image_24": image24,
        "image_32": image32,
        "image_48": image48,
        "image_72": image72,
        "image_192": image192,
        "image_512": image512,
        "status_text_canonical": statusTextCanonical,
        "team": teamValues.reverse[team],
        "image_original": imageOriginal,
        "is_custom_image": isCustomImage,
        "email": email,
        "huddle_state": huddleState,
        "huddle_state_expiration_ts": huddleStateExpirationTs,
        "image_1024": image1024,
        "who_can_share_contact_card":
            whoCanShareContactCardValues.reverse[whoCanShareContactCard],
        "api_app_id": apiAppId,
        "bot_id": botId,
      };
}

class Fields {
  Fields();

  factory Fields.fromJson(Map<String, dynamic> json) => Fields();

  Map<String, dynamic> toJson() => {};
}

enum Phone { EMPTY, THE_03028490697 }

final phoneValues =
    EnumValues({"": Phone.EMPTY, "03028490697": Phone.THE_03028490697});

enum Team { T05_D22_FFEN9 }

final teamValues = EnumValues({"T05D22FFEN9": Team.T05_D22_FFEN9});

enum WhoCanShareContactCard { EVERYONE, TEAM_MEMBERS }

final whoCanShareContactCardValues = EnumValues({
  "EVERYONE": WhoCanShareContactCard.EVERYONE,
  "TEAM_MEMBERS": WhoCanShareContactCard.TEAM_MEMBERS
});

enum Tz { AMERICA_LOS_ANGELES, ASIA_KARACHI }

final tzValues = EnumValues({
  "America/Los_Angeles": Tz.AMERICA_LOS_ANGELES,
  "Asia/Karachi": Tz.ASIA_KARACHI
});

enum TzLabel { PACIFIC_DAYLIGHT_TIME, PAKISTAN_STANDARD_TIME }

final tzLabelValues = EnumValues({
  "Pacific Daylight Time": TzLabel.PACIFIC_DAYLIGHT_TIME,
  "Pakistan Standard Time": TzLabel.PAKISTAN_STANDARD_TIME
});

class ResponseMetadata {
  String nextCursor;

  ResponseMetadata({
    required this.nextCursor,
  });

  factory ResponseMetadata.fromJson(Map<String, dynamic> json) =>
      ResponseMetadata(
        nextCursor: json["next_cursor"],
      );

  Map<String, dynamic> toJson() => {
        "next_cursor": nextCursor,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
