// To parse this JSON data, do
//
//     final slackChannelsModel = slackChannelsModelFromJson(jsonString);

import 'dart:convert';

SlackChannelsModel slackChannelsModelFromJson(String str) => SlackChannelsModel.fromJson(json.decode(str));

String slackChannelsModelToJson(SlackChannelsModel data) => json.encode(data.toJson());

class SlackChannelsModel {
    bool ok;
    List<Channel> channels;
    ResponseMetadata responseMetadata;

    SlackChannelsModel({
        required this.ok,
        required this.channels,
        required this.responseMetadata,
    });

    factory SlackChannelsModel.fromJson(Map<String, dynamic> json) => SlackChannelsModel(
        ok: json["ok"],
        channels: List<Channel>.from(json["channels"].map((x) => Channel.fromJson(x))),
        responseMetadata: ResponseMetadata.fromJson(json["response_metadata"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "channels": List<dynamic>.from(channels.map((x) => x.toJson())),
        "response_metadata": responseMetadata.toJson(),
    };
}

class Channel {
    String id;
    String name;
    bool isChannel;
    bool isGroup;
    bool isIm;
    bool isMpim;
    bool isPrivate;
    int created;
    bool isArchived;
    bool isGeneral;
    int unlinked;
    String nameNormalized;
    bool isShared;
    bool isOrgShared;
    bool isPendingExtShared;
    List<dynamic> pendingShared;
    String contextTeamId;
    int updated;
    dynamic parentConversation;
    Creator creator;
    bool isExtShared;
    List<String> sharedTeamIds;
    List<dynamic> pendingConnectedTeamIds;
    bool isMember;
    Purpose topic;
    Purpose purpose;
    int numMembers;
    List<dynamic>? previousNames;

    Channel({
        required this.id,
        required this.name,
        required this.isChannel,
        required this.isGroup,
        required this.isIm,
        required this.isMpim,
        required this.isPrivate,
        required this.created,
        required this.isArchived,
        required this.isGeneral,
        required this.unlinked,
        required this.nameNormalized,
        required this.isShared,
        required this.isOrgShared,
        required this.isPendingExtShared,
        required this.pendingShared,
        required this.contextTeamId,
        required this.updated,
        this.parentConversation,
        required this.creator,
        required this.isExtShared,
        required this.sharedTeamIds,
        required this.pendingConnectedTeamIds,
        required this.isMember,
        required this.topic,
        required this.purpose,
        required this.numMembers,
        this.previousNames,
    });

    factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        id: json["id"],
        name: json["name"],
        isChannel: json["is_channel"],
        isGroup: json["is_group"],
        isIm: json["is_im"],
        isMpim: json["is_mpim"],
        isPrivate: json["is_private"],
        created: json["created"],
        isArchived: json["is_archived"],
        isGeneral: json["is_general"],
        unlinked: json["unlinked"],
        nameNormalized: json["name_normalized"],
        isShared: json["is_shared"],
        isOrgShared: json["is_org_shared"],
        isPendingExtShared: json["is_pending_ext_shared"],
        pendingShared: List<dynamic>.from(json["pending_shared"].map((x) => x)),
        contextTeamId: json["context_team_id"],
        updated: json["updated"],
        parentConversation: json["parent_conversation"],
        creator: creatorValues.map[json["creator"]]!,
        isExtShared: json["is_ext_shared"],
        sharedTeamIds: List<String>.from(json["shared_team_ids"].map((x) => x)),
        pendingConnectedTeamIds: List<dynamic>.from(json["pending_connected_team_ids"].map((x) => x)),
        isMember: json["is_member"],
        topic: Purpose.fromJson(json["topic"]),
        purpose: Purpose.fromJson(json["purpose"]),
        numMembers: json["num_members"],
        previousNames: json["previous_names"] == null ? [] : List<dynamic>.from(json["previous_names"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_channel": isChannel,
        "is_group": isGroup,
        "is_im": isIm,
        "is_mpim": isMpim,
        "is_private": isPrivate,
        "created": created,
        "is_archived": isArchived,
        "is_general": isGeneral,
        "unlinked": unlinked,
        "name_normalized": nameNormalized,
        "is_shared": isShared,
        "is_org_shared": isOrgShared,
        "is_pending_ext_shared": isPendingExtShared,
        "pending_shared": List<dynamic>.from(pendingShared.map((x) => x)),
        "context_team_id": contextTeamId,
        "updated": updated,
        "parent_conversation": parentConversation,
        "creator": creatorValues.reverse[creator],
        "is_ext_shared": isExtShared,
        "shared_team_ids": List<dynamic>.from(sharedTeamIds.map((x) => x)),
        "pending_connected_team_ids": List<dynamic>.from(pendingConnectedTeamIds.map((x) => x)),
        "is_member": isMember,
        "topic": topic.toJson(),
        "purpose": purpose.toJson(),
        "num_members": numMembers,
        "previous_names": previousNames == null ? [] : List<dynamic>.from(previousNames!.map((x) => x)),
    };
}

enum Creator { EMPTY, U05_DHK589_JM, U05_CYB9642_J }

final creatorValues = EnumValues({
    "": Creator.EMPTY,
    "U05CYB9642J": Creator.U05_CYB9642_J,
    "U05DHK589JM": Creator.U05_DHK589_JM
});

class Purpose {
    String value;
    Creator creator;
    int lastSet;

    Purpose({
        required this.value,
        required this.creator,
        required this.lastSet,
    });

    factory Purpose.fromJson(Map<String, dynamic> json) => Purpose(
        value: json["value"],
        creator: creatorValues.map[json["creator"]]!,
        lastSet: json["last_set"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "creator": creatorValues.reverse[creator],
        "last_set": lastSet,
    };
}

class ResponseMetadata {
    String nextCursor;

    ResponseMetadata({
        required this.nextCursor,
    });

    factory ResponseMetadata.fromJson(Map<String, dynamic> json) => ResponseMetadata(
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
