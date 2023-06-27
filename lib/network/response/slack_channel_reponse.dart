// To parse this JSON data, do
//
//     final slackChannelsModels = slackChannelsModelsFromJson(jsonString);

import 'dart:convert';

SlackChannelsModels slackChannelsModelsFromJson(String str) => SlackChannelsModels.fromJson(json.decode(str));

String slackChannelsModelsToJson(SlackChannelsModels data) => json.encode(data.toJson());

class SlackChannelsModels {
    bool ok;
    List<Channel> channels;
    ResponseMetadata responseMetadata;

    SlackChannelsModels({
        required this.ok,
        required this.channels,
        required this.responseMetadata,
    });

    factory SlackChannelsModels.fromJson(Map<String, dynamic> json) => SlackChannelsModels(
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
    int created;
    String creator;
    bool isArchived;
    bool isGeneral;
    int unlinked;
    String nameNormalized;
    bool isShared;
    bool isExtShared;
    bool isOrgShared;
    List<dynamic> pendingShared;
    bool isPendingExtShared;
    bool isMember;
    bool isPrivate;
    bool isMpim;
    int updated;
    Purpose topic;
    Purpose purpose;
    List<dynamic> previousNames;
    int numMembers;

    Channel({
        required this.id,
        required this.name,
        required this.isChannel,
        required this.isGroup,
        required this.isIm,
        required this.created,
        required this.creator,
        required this.isArchived,
        required this.isGeneral,
        required this.unlinked,
        required this.nameNormalized,
        required this.isShared,
        required this.isExtShared,
        required this.isOrgShared,
        required this.pendingShared,
        required this.isPendingExtShared,
        required this.isMember,
        required this.isPrivate,
        required this.isMpim,
        required this.updated,
        required this.topic,
        required this.purpose,
        required this.previousNames,
        required this.numMembers,
    });

    factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        id: json["id"],
        name: json["name"],
        isChannel: json["is_channel"],
        isGroup: json["is_group"],
        isIm: json["is_im"],
        created: json["created"],
        creator: json["creator"],
        isArchived: json["is_archived"],
        isGeneral: json["is_general"],
        unlinked: json["unlinked"],
        nameNormalized: json["name_normalized"],
        isShared: json["is_shared"],
        isExtShared: json["is_ext_shared"],
        isOrgShared: json["is_org_shared"],
        pendingShared: List<dynamic>.from(json["pending_shared"].map((x) => x)),
        isPendingExtShared: json["is_pending_ext_shared"],
        isMember: json["is_member"],
        isPrivate: json["is_private"],
        isMpim: json["is_mpim"],
        updated: json["updated"],
        topic: Purpose.fromJson(json["topic"]),
        purpose: Purpose.fromJson(json["purpose"]),
        previousNames: List<dynamic>.from(json["previous_names"].map((x) => x)),
        numMembers: json["num_members"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_channel": isChannel,
        "is_group": isGroup,
        "is_im": isIm,
        "created": created,
        "creator": creator,
        "is_archived": isArchived,
        "is_general": isGeneral,
        "unlinked": unlinked,
        "name_normalized": nameNormalized,
        "is_shared": isShared,
        "is_ext_shared": isExtShared,
        "is_org_shared": isOrgShared,
        "pending_shared": List<dynamic>.from(pendingShared.map((x) => x)),
        "is_pending_ext_shared": isPendingExtShared,
        "is_member": isMember,
        "is_private": isPrivate,
        "is_mpim": isMpim,
        "updated": updated,
        "topic": topic.toJson(),
        "purpose": purpose.toJson(),
        "previous_names": List<dynamic>.from(previousNames.map((x) => x)),
        "num_members": numMembers,
    };
}

class Purpose {
    String value;
    String creator;
    int lastSet;

    Purpose({
        required this.value,
        required this.creator,
        required this.lastSet,
    });

    factory Purpose.fromJson(Map<String, dynamic> json) => Purpose(
        value: json["value"],
        creator: json["creator"],
        lastSet: json["last_set"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "creator": creator,
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
