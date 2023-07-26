// To parse this JSON data, do
//
//     final clubsResponse = clubsResponseFromJson(jsonString);

import 'dart:convert';

ClubsResponse clubsResponseFromJson(String str) =>
    ClubsResponse.fromJson(json.decode(str));

String clubsResponseToJson(ClubsResponse data) => json.encode(data.toJson());

class ClubsResponse {
  List<AssignedClub> assignedClubs;
  List<AllClub> allClubs;
  int assCl;
  int allCl;

  ClubsResponse({
    required this.assignedClubs,
    required this.allClubs,
    required this.assCl,
    required this.allCl,
  });

  factory ClubsResponse.fromJson(Map<String, dynamic> json) => ClubsResponse(
        assignedClubs: List<AssignedClub>.from(
            json["assignedClubs"].map((x) => AssignedClub.fromJson(x))),
        allClubs: List<AllClub>.from(
            json["allClubs"].map((x) => AllClub.fromJson(x))),
        assCl: json["ass_cl"],
        allCl: json["all_cl"],
      );

  Map<String, dynamic> toJson() => {
        "assignedClubs":
            List<dynamic>.from(assignedClubs.map((x) => x.toJson())),
        "allClubs": List<dynamic>.from(allClubs.map((x) => x.toJson())),
        "ass_cl": assCl,
        "all_cl": allCl,
      };
}

class AllClub {
  Picture picture;
  List<String> associations;
  String id;
  List<Member> members;
  List<Team> teams;
  String clubName;
  String? about;
  String? cell;
  String? address;
  String city;
  String location;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<dynamic> equipmentCategories;
  String? email;
  String? website;
  String? fbLink;

  AllClub.toAssignedClub({
    required this.picture,
    required this.associations,
    required this.id,
    required this.members,
    required this.teams,
    required this.clubName,
    required this.about,
    required this.cell,
    required this.address,
    required this.city,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.equipmentCategories,
  });
  AllClub({
    required this.picture,
    required this.associations,
    required this.id,
    required this.members,
    required this.teams,
    required this.clubName,
    this.about,
    this.cell,
    this.address,
    required this.city,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.equipmentCategories,
    this.email,
    this.website,
    this.fbLink,
  });

  factory AllClub.fromJson(Map<String, dynamic> json) => AllClub(
        picture: Picture.fromJson(json["picture"] ?? {}),
        associations: List<String>.from(json["associations"].map((x) => x)),
        id: json["_id"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        teams: List<Team>.from(json["teams"].map((x) => Team.fromJson(x))),
        clubName: json["club_name"] ?? '',
        about: json["about"] ?? '',
        cell: json["cell"] ?? '',
        address: json["address"],
        city: json["city"] ?? '',
        location: json["location"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        equipmentCategories:
            List<dynamic>.from(json["equipment_categories"].map((x) => x)),
        email: json["email"],
        website: json["website"],
        fbLink: json["fb_link"],
      );

  Map<String, dynamic> toJson() => {
        "picture": picture.toJson(),
        "associations": List<dynamic>.from(associations.map((x) => x)),
        "_id": id,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "teams": List<dynamic>.from(teams.map((x) => x.toJson())),
        "club_name": clubName,
        "about": about,
        "cell": cell,
        "address": address,
        "city": city,
        "location": location,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "equipment_categories":
            List<dynamic>.from(equipmentCategories.map((x) => x)),
        "email": email,
        "website": website,
        "fb_link": fbLink,
      };
}

class Member {
  String id;
  String memberId;
  bool? isClubAdmin;
  bool? isClubMod;

  Member({
    required this.id,
    required this.memberId,
    this.isClubAdmin,
    this.isClubMod,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["_id"],
        memberId: json["member_id"],
        isClubAdmin: json["is_Club_Admin"],
        isClubMod: json["is_Club_Mod"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "member_id": memberId,
        "is_Club_Admin": isClubAdmin,
        "is_Club_Mod": isClubMod,
      };
}

class Picture {
  String fileName;
  String? filePath;
  String? fileExt;

  Picture({
    required this.fileName,
    this.filePath,
    this.fileExt,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        fileName: json["fileName"] ?? '',
        filePath: json["filePath"] ?? '',
        fileExt: json["fileExt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "filePath": filePath,
        "fileExt": fileExt,
      };
}

class Team {
  String id;
  String teamId;

  Team({
    required this.id,
    required this.teamId,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["_id"],
        teamId: json["team_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "team_id": teamId,
      };
}

class AssignedClub {
  String id;
  Picture picture;
  List<String> associations;
  List<Member> members;
  List<Team> teams;
  String clubName;
  String about;
  String cell;
  String address;
  String city;
  String location;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<EquipmentCategory> equipmentCategories;

  AssignedClub({
    required this.id,
    required this.picture,
    required this.associations,
    required this.members,
    required this.teams,
    required this.clubName,
    required this.about,
    required this.cell,
    required this.address,
    required this.city,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.equipmentCategories,
  });

  factory AssignedClub.fromJson(Map<String, dynamic> json) => AssignedClub(
        id: json["_id"],
        picture: Picture.fromJson(json["picture"]),
        associations: List<String>.from(json["associations"].map((x) => x)),
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        teams: List<Team>.from(json["teams"].map((x) => Team.fromJson(x))),
        clubName: json["club_name"],
        about: json["about"],
        cell: json["cell"],
        address: json["address"],
        city: json["city"],
        location: json["location"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        equipmentCategories: List<EquipmentCategory>.from(
            json["equipment_categories"]
                .map((x) => EquipmentCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "picture": picture.toJson(),
        "associations": List<dynamic>.from(associations.map((x) => x)),
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "teams": List<dynamic>.from(teams.map((x) => x.toJson())),
        "club_name": clubName,
        "about": about,
        "cell": cell,
        "address": address,
        "city": city,
        "location": location,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "equipment_categories":
            List<dynamic>.from(equipmentCategories.map((x) => x.toJson())),
      };
}

class EquipmentCategory {
  String id;
  String categoryId;

  EquipmentCategory({
    required this.id,
    required this.categoryId,
  });

  factory EquipmentCategory.fromJson(Map<String, dynamic> json) =>
      EquipmentCategory(
        id: json["_id"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category_id": categoryId,
      };
}

AllClub allClubFromAssignedClub(AssignedClub assignedClub) {
  AllClub club = AllClub.toAssignedClub(
      associations: assignedClub.associations,
      id: assignedClub.id,
      members: assignedClub.members,
      teams: assignedClub.teams,
      clubName: assignedClub.clubName,
      createdAt: assignedClub.createdAt,
      updatedAt: assignedClub.updatedAt,
      v: assignedClub.v,
      equipmentCategories: assignedClub.equipmentCategories,
      about: assignedClub.about,
      address: assignedClub.address,
      cell: assignedClub.cell,
      city: assignedClub.city,
      location: assignedClub.location,
      picture: assignedClub.picture);

  return club;
}
