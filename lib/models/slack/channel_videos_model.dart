// To parse this JSON data, do
//
//     final channelVideosModel = channelVideosModelFromJson(jsonString);

import 'dart:convert';

ChannelVideosModel channelVideosModelFromJson(String str) => ChannelVideosModel.fromJson(json.decode(str));

String channelVideosModelToJson(ChannelVideosModel data) => json.encode(data.toJson());

class ChannelVideosModel {
    bool ok;
    List<Message> messages;
    bool hasMore;
    int pinCount;
    dynamic channelActionsTs;
    int channelActionsCount;

    ChannelVideosModel({
        required this.ok,
        required this.messages,
        required this.hasMore,
        required this.pinCount,
        this.channelActionsTs,
        required this.channelActionsCount,
    });

    factory ChannelVideosModel.fromJson(Map<String, dynamic> json) => ChannelVideosModel(
        ok: json["ok"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
        hasMore: json["has_more"],
        pinCount: json["pin_count"],
        channelActionsTs: json["channel_actions_ts"],
        channelActionsCount: json["channel_actions_count"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "has_more": hasMore,
        "pin_count": pinCount,
        "channel_actions_ts": channelActionsTs,
        "channel_actions_count": channelActionsCount,
    };
}

class Message {
    Type type;
    String text;
    List<FileElement>? files;
    bool? upload;
    String user;
    bool? displayAsBot;
    String ts;
    String? clientMsgId;
    String? subtype;

    Message({
        required this.type,
        required this.text,
        this.files,
        this.upload,
        required this.user,
        this.displayAsBot,
        required this.ts,
        this.clientMsgId,
        this.subtype,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        type: typeValues.map[json["type"]]!,
        text: json["text"],
        files: json["files"] == null ? [] : List<FileElement>.from(json["files"]!.map((x) => FileElement.fromJson(x))),
        upload: json["upload"],
        user: json["user"],
        displayAsBot: json["display_as_bot"],
        ts: json["ts"],
        clientMsgId: json["client_msg_id"],
        subtype: json["subtype"],
    );

    Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "text": text,
        "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x.toJson())),
        "upload": upload,
        "user": user,
        "display_as_bot": displayAsBot,
        "ts": ts,
        "client_msg_id": clientMsgId,
        "subtype": subtype,
    };
}

class FileElement {
    String id;
    int created;
    int timestamp;
    String name;
    String title;
    String mimetype;
    String filetype;
    String prettyType;
    String user;
    String userTeam;
    bool editable;
    int size;
    String mode;
    bool isExternal;
    String externalType;
    bool isPublic;
    bool publicUrlShared;
    bool displayAsBot;
    String username;
    Transcription transcription;
    String mp4;
    String urlPrivate;
    String urlPrivateDownload;
    String? vtt;
    String hls;
    String hlsEmbed;
    String mp4Low;
    int durationMs;
    String mediaDisplayType;
    String thumbVideo;
    int thumbVideoW;
    int thumbVideoH;
    String permalink;
    String permalinkPublic;
    bool isStarred;
    bool hasRichPreview;
    String fileAccess;

    FileElement({
        required this.id,
        required this.created,
        required this.timestamp,
        required this.name,
        required this.title,
        required this.mimetype,
        required this.filetype,
        required this.prettyType,
        required this.user,
        required this.userTeam,
        required this.editable,
        required this.size,
        required this.mode,
        required this.isExternal,
        required this.externalType,
        required this.isPublic,
        required this.publicUrlShared,
        required this.displayAsBot,
        required this.username,
        required this.transcription,
        required this.mp4,
        required this.urlPrivate,
        required this.urlPrivateDownload,
        this.vtt,
        required this.hls,
        required this.hlsEmbed,
        required this.mp4Low,
        required this.durationMs,
        required this.mediaDisplayType,
        required this.thumbVideo,
        required this.thumbVideoW,
        required this.thumbVideoH,
        required this.permalink,
        required this.permalinkPublic,
        required this.isStarred,
        required this.hasRichPreview,
        required this.fileAccess,
    });

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"],
        created: json["created"],
        timestamp: json["timestamp"],
        name: json["name"],
        title: json["title"],
        mimetype: json["mimetype"],
        filetype: json["filetype"],
        prettyType: json["pretty_type"],
        user: json["user"],
        userTeam: json["user_team"],
        editable: json["editable"],
        size: json["size"],
        mode: json["mode"],
        isExternal: json["is_external"],
        externalType: json["external_type"],
        isPublic: json["is_public"],
        publicUrlShared: json["public_url_shared"],
        displayAsBot: json["display_as_bot"],
        username: json["username"],
        transcription: Transcription.fromJson(json["transcription"]),
        mp4: json["mp4"],
        urlPrivate: json["url_private"],
        urlPrivateDownload: json["url_private_download"],
        vtt: json["vtt"],
        hls: json["hls"],
        hlsEmbed: json["hls_embed"],
        mp4Low: json["mp4_low"],
        durationMs: json["duration_ms"],
        mediaDisplayType: json["media_display_type"],
        thumbVideo: json["thumb_video"],
        thumbVideoW: json["thumb_video_w"],
        thumbVideoH: json["thumb_video_h"],
        permalink: json["permalink"],
        permalinkPublic: json["permalink_public"],
        isStarred: json["is_starred"],
        hasRichPreview: json["has_rich_preview"],
        fileAccess: json["file_access"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created": created,
        "timestamp": timestamp,
        "name": name,
        "title": title,
        "mimetype": mimetype,
        "filetype": filetype,
        "pretty_type": prettyType,
        "user": user,
        "user_team": userTeam,
        "editable": editable,
        "size": size,
        "mode": mode,
        "is_external": isExternal,
        "external_type": externalType,
        "is_public": isPublic,
        "public_url_shared": publicUrlShared,
        "display_as_bot": displayAsBot,
        "username": username,
        "transcription": transcription.toJson(),
        "mp4": mp4,
        "url_private": urlPrivate,
        "url_private_download": urlPrivateDownload,
        "vtt": vtt,
        "hls": hls,
        "hls_embed": hlsEmbed,
        "mp4_low": mp4Low,
        "duration_ms": durationMs,
        "media_display_type": mediaDisplayType,
        "thumb_video": thumbVideo,
        "thumb_video_w": thumbVideoW,
        "thumb_video_h": thumbVideoH,
        "permalink": permalink,
        "permalink_public": permalinkPublic,
        "is_starred": isStarred,
        "has_rich_preview": hasRichPreview,
        "file_access": fileAccess,
    };
}

class Transcription {
    String status;
    String? locale;
    Preview? preview;

    Transcription({
        required this.status,
        this.locale,
        this.preview,
    });

    factory Transcription.fromJson(Map<String, dynamic> json) => Transcription(
        status: json["status"],
        locale: json["locale"],
        preview: json["preview"] == null ? null : Preview.fromJson(json["preview"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "locale": locale,
        "preview": preview?.toJson(),
    };
}

class Preview {
    String content;
    bool hasMore;

    Preview({
        required this.content,
        required this.hasMore,
    });

    factory Preview.fromJson(Map<String, dynamic> json) => Preview(
        content: json["content"],
        hasMore: json["has_more"],
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "has_more": hasMore,
    };
}

enum Type { MESSAGE }

final typeValues = EnumValues({
    "message": Type.MESSAGE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
