



import 'dart:convert';

ChannelMessagesResponse channelMessagesFromJson(String str) => ChannelMessagesResponse.fromJson(json.decode(str));

String channelMessagesToJson(ChannelMessagesResponse data) => json.encode(data.toJson());

class ChannelMessagesResponse {
  bool? _ok;
  List<Messages>? _messages;
  bool? _hasMore;
  int? _pinCount;
  int? _channelActionsTs;
  int? _channelActionsCount;

  ChannelMessagesResponse(
      {bool? ok,
      List<Messages>? messages,
      bool? hasMore,
      int? pinCount,
      int? channelActionsTs,
      int? channelActionsCount}) {
    if (ok != null) {
      this._ok = ok;
    }
    if (messages != null) {
      this._messages = messages;
    }
    if (hasMore != null) {
      this._hasMore = hasMore;
    }
    if (pinCount != null) {
      this._pinCount = pinCount;
    }
    if (channelActionsTs != null) {
      this._channelActionsTs = channelActionsTs;
    }
    if (channelActionsCount != null) {
      this._channelActionsCount = channelActionsCount;
    }
  }

  bool? get ok => _ok;
  set ok(bool? ok) => _ok = ok;
  List<Messages>? get messages => _messages;
  set messages(List<Messages>? messages) => _messages = messages;
  bool? get hasMore => _hasMore;
  set hasMore(bool? hasMore) => _hasMore = hasMore;
  int? get pinCount => _pinCount;
  set pinCount(int? pinCount) => _pinCount = pinCount;
  int? get channelActionsTs => _channelActionsTs;
  set channelActionsTs(int? channelActionsTs) =>
      _channelActionsTs = channelActionsTs;
  int? get channelActionsCount => _channelActionsCount;
  set channelActionsCount(int? channelActionsCount) =>
      _channelActionsCount = channelActionsCount;

  ChannelMessagesResponse.fromJson(Map<String, dynamic> json) {
    _ok = json['ok'];
    if (json['messages'] != null) {
      _messages = <Messages>[];
      json['messages'].forEach((v) {
        _messages!.add(new Messages.fromJson(v));
      });
    }
    _hasMore = json['has_more'];
    _pinCount = json['pin_count'];
    _channelActionsTs = json['channel_actions_ts'];
    _channelActionsCount = json['channel_actions_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this._ok;
    if (this._messages != null) {
      data['messages'] = this._messages!.map((v) => v.toJson()).toList();
    }
    data['has_more'] = this._hasMore;
    data['pin_count'] = this._pinCount;
    data['channel_actions_ts'] = this._channelActionsTs;
    data['channel_actions_count'] = this._channelActionsCount;
    return data;
  }
}

class Messages {
  String? _type;
  String? _text;
  List<Files>? _files;
  bool? _upload;
  String? _user;
  bool? _displayAsBot;
  String? _ts;
  List<Blocks>? _blocks;
  String? _clientMsgId;
  String? _subtype;

  Messages(
      {String? type,
      String? text,
      List<Files>? files,
      bool? upload,
      String? user,
      bool? displayAsBot,
      String? ts,
      List<Blocks>? blocks,
      String? clientMsgId,
      String? subtype}) {
    if (type != null) {
      this._type = type;
    }
    if (text != null) {
      this._text = text;
    }
    if (files != null) {
      this._files = files;
    }
    if (upload != null) {
      this._upload = upload;
    }
    if (user != null) {
      this._user = user;
    }
    if (displayAsBot != null) {
      this._displayAsBot = displayAsBot;
    }
    if (ts != null) {
      this._ts = ts;
    }
    if (blocks != null) {
      this._blocks = blocks;
    }
    if (clientMsgId != null) {
      this._clientMsgId = clientMsgId;
    }
    if (subtype != null) {
      this._subtype = subtype;
    }
  }

  String? get type => _type;
  set type(String? type) => _type = type;
  String? get text => _text;
  set text(String? text) => _text = text;
  List<Files>? get files => _files;
  set files(List<Files>? files) => _files = files;
  bool? get upload => _upload;
  set upload(bool? upload) => _upload = upload;
  String? get user => _user;
  set user(String? user) => _user = user;
  bool? get displayAsBot => _displayAsBot;
  set displayAsBot(bool? displayAsBot) => _displayAsBot = displayAsBot;
  String? get ts => _ts;
  set ts(String? ts) => _ts = ts;
  List<Blocks>? get blocks => _blocks;
  set blocks(List<Blocks>? blocks) => _blocks = blocks;
  String? get clientMsgId => _clientMsgId;
  set clientMsgId(String? clientMsgId) => _clientMsgId = clientMsgId;
  String? get subtype => _subtype;
  set subtype(String? subtype) => _subtype = subtype;

  Messages.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _text = json['text'];
    if (json['files'] != null) {
      _files = <Files>[];
      json['files'].forEach((v) {
        _files!.add(new Files.fromJson(v));
      });
    }
    _upload = json['upload'];
    _user = json['user'];
    _displayAsBot = json['display_as_bot'];
    _ts = json['ts'];
    if (json['blocks'] != null) {
      _blocks = <Blocks>[];
      json['blocks'].forEach((v) {
        _blocks!.add(new Blocks.fromJson(v));
      });
    }
    _clientMsgId = json['client_msg_id'];
    _subtype = json['subtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['text'] = this._text;
    if (this._files != null) {
      data['files'] = this._files!.map((v) => v.toJson()).toList();
    }
    data['upload'] = this._upload;
    data['user'] = this._user;
    data['display_as_bot'] = this._displayAsBot;
    data['ts'] = this._ts;
    if (this._blocks != null) {
      data['blocks'] = this._blocks!.map((v) => v.toJson()).toList();
    }
    data['client_msg_id'] = this._clientMsgId;
    data['subtype'] = this._subtype;
    return data;
  }
}

class Files {
  String? _id;
  int? _created;
  int? _timestamp;
  String? _name;
  String? _title;
  String? _mimetype;
  String? _filetype;
  String? _prettyType;
  String? _user;
  String? _userTeam;
  bool? _editable;
  int? _size;
  String? _mode;
  bool? _isExternal;
  String? _externalType;
  bool? _isPublic;
  bool? _publicUrlShared;
  bool? _displayAsBot;
  String? _username;
  String? _urlPrivate;
  String? _urlPrivateDownload;
  String? _mediaDisplayType;
  String? _convertedPdf;
  String? _thumbPdf;
  int? _thumbPdfW;
  int? _thumbPdfH;
  String? _permalink;
  String? _permalinkPublic;
  bool? _isStarred;
  bool? _hasRichPreview;
  String? _fileAccess;
  Transcription? _transcription;
  String? _mp4;
  String? _vtt;
  String? _hls;
  String? _hlsEmbed;
  String? _mp4Low;
  int? _durationMs;
  String? _thumbVideo;
  int? _thumbVideoW;
  int? _thumbVideoH;

  Files(
      {String? id,
      int? created,
      int? timestamp,
      String? name,
      String? title,
      String? mimetype,
      String? filetype,
      String? prettyType,
      String? user,
      String? userTeam,
      bool? editable,
      int? size,
      String? mode,
      bool? isExternal,
      String? externalType,
      bool? isPublic,
      bool? publicUrlShared,
      bool? displayAsBot,
      String? username,
      String? urlPrivate,
      String? urlPrivateDownload,
      String? mediaDisplayType,
      String? convertedPdf,
      String? thumbPdf,
      int? thumbPdfW,
      int? thumbPdfH,
      String? permalink,
      String? permalinkPublic,
      bool? isStarred,
      bool? hasRichPreview,
      String? fileAccess,
      Transcription? transcription,
      String? mp4,
      String? vtt,
      String? hls,
      String? hlsEmbed,
      String? mp4Low,
      int? durationMs,
      String? thumbVideo,
      int? thumbVideoW,
      int? thumbVideoH}) {
    if (id != null) {
      this._id = id;
    }
    if (created != null) {
      this._created = created;
    }
    if (timestamp != null) {
      this._timestamp = timestamp;
    }
    if (name != null) {
      this._name = name;
    }
    if (title != null) {
      this._title = title;
    }
    if (mimetype != null) {
      this._mimetype = mimetype;
    }
    if (filetype != null) {
      this._filetype = filetype;
    }
    if (prettyType != null) {
      this._prettyType = prettyType;
    }
    if (user != null) {
      this._user = user;
    }
    if (userTeam != null) {
      this._userTeam = userTeam;
    }
    if (editable != null) {
      this._editable = editable;
    }
    if (size != null) {
      this._size = size;
    }
    if (mode != null) {
      this._mode = mode;
    }
    if (isExternal != null) {
      this._isExternal = isExternal;
    }
    if (externalType != null) {
      this._externalType = externalType;
    }
    if (isPublic != null) {
      this._isPublic = isPublic;
    }
    if (publicUrlShared != null) {
      this._publicUrlShared = publicUrlShared;
    }
    if (displayAsBot != null) {
      this._displayAsBot = displayAsBot;
    }
    if (username != null) {
      this._username = username;
    }
    if (urlPrivate != null) {
      this._urlPrivate = urlPrivate;
    }
    if (urlPrivateDownload != null) {
      this._urlPrivateDownload = urlPrivateDownload;
    }
    if (mediaDisplayType != null) {
      this._mediaDisplayType = mediaDisplayType;
    }
    if (convertedPdf != null) {
      this._convertedPdf = convertedPdf;
    }
    if (thumbPdf != null) {
      this._thumbPdf = thumbPdf;
    }
    if (thumbPdfW != null) {
      this._thumbPdfW = thumbPdfW;
    }
    if (thumbPdfH != null) {
      this._thumbPdfH = thumbPdfH;
    }
    if (permalink != null) {
      this._permalink = permalink;
    }
    if (permalinkPublic != null) {
      this._permalinkPublic = permalinkPublic;
    }
    if (isStarred != null) {
      this._isStarred = isStarred;
    }
    if (hasRichPreview != null) {
      this._hasRichPreview = hasRichPreview;
    }
    if (fileAccess != null) {
      this._fileAccess = fileAccess;
    }
    if (transcription != null) {
      this._transcription = transcription;
    }
    if (mp4 != null) {
      this._mp4 = mp4;
    }
    if (vtt != null) {
      this._vtt = vtt;
    }
    if (hls != null) {
      this._hls = hls;
    }
    if (hlsEmbed != null) {
      this._hlsEmbed = hlsEmbed;
    }
    if (mp4Low != null) {
      this._mp4Low = mp4Low;
    }
    if (durationMs != null) {
      this._durationMs = durationMs;
    }
    if (thumbVideo != null) {
      this._thumbVideo = thumbVideo;
    }
    if (thumbVideoW != null) {
      this._thumbVideoW = thumbVideoW;
    }
    if (thumbVideoH != null) {
      this._thumbVideoH = thumbVideoH;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  int? get created => _created;
  set created(int? created) => _created = created;
  int? get timestamp => _timestamp;
  set timestamp(int? timestamp) => _timestamp = timestamp;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get mimetype => _mimetype;
  set mimetype(String? mimetype) => _mimetype = mimetype;
  String? get filetype => _filetype;
  set filetype(String? filetype) => _filetype = filetype;
  String? get prettyType => _prettyType;
  set prettyType(String? prettyType) => _prettyType = prettyType;
  String? get user => _user;
  set user(String? user) => _user = user;
  String? get userTeam => _userTeam;
  set userTeam(String? userTeam) => _userTeam = userTeam;
  bool? get editable => _editable;
  set editable(bool? editable) => _editable = editable;
  int? get size => _size;
  set size(int? size) => _size = size;
  String? get mode => _mode;
  set mode(String? mode) => _mode = mode;
  bool? get isExternal => _isExternal;
  set isExternal(bool? isExternal) => _isExternal = isExternal;
  String? get externalType => _externalType;
  set externalType(String? externalType) => _externalType = externalType;
  bool? get isPublic => _isPublic;
  set isPublic(bool? isPublic) => _isPublic = isPublic;
  bool? get publicUrlShared => _publicUrlShared;
  set publicUrlShared(bool? publicUrlShared) =>
      _publicUrlShared = publicUrlShared;
  bool? get displayAsBot => _displayAsBot;
  set displayAsBot(bool? displayAsBot) => _displayAsBot = displayAsBot;
  String? get username => _username;
  set username(String? username) => _username = username;
  String? get urlPrivate => _urlPrivate;
  set urlPrivate(String? urlPrivate) => _urlPrivate = urlPrivate;
  String? get urlPrivateDownload => _urlPrivateDownload;
  set urlPrivateDownload(String? urlPrivateDownload) =>
      _urlPrivateDownload = urlPrivateDownload;
  String? get mediaDisplayType => _mediaDisplayType;
  set mediaDisplayType(String? mediaDisplayType) =>
      _mediaDisplayType = mediaDisplayType;
  String? get convertedPdf => _convertedPdf;
  set convertedPdf(String? convertedPdf) => _convertedPdf = convertedPdf;
  String? get thumbPdf => _thumbPdf;
  set thumbPdf(String? thumbPdf) => _thumbPdf = thumbPdf;
  int? get thumbPdfW => _thumbPdfW;
  set thumbPdfW(int? thumbPdfW) => _thumbPdfW = thumbPdfW;
  int? get thumbPdfH => _thumbPdfH;
  set thumbPdfH(int? thumbPdfH) => _thumbPdfH = thumbPdfH;
  String? get permalink => _permalink;
  set permalink(String? permalink) => _permalink = permalink;
  String? get permalinkPublic => _permalinkPublic;
  set permalinkPublic(String? permalinkPublic) =>
      _permalinkPublic = permalinkPublic;
  bool? get isStarred => _isStarred;
  set isStarred(bool? isStarred) => _isStarred = isStarred;
  bool? get hasRichPreview => _hasRichPreview;
  set hasRichPreview(bool? hasRichPreview) => _hasRichPreview = hasRichPreview;
  String? get fileAccess => _fileAccess;
  set fileAccess(String? fileAccess) => _fileAccess = fileAccess;
  Transcription? get transcription => _transcription;
  set transcription(Transcription? transcription) =>
      _transcription = transcription;
  String? get mp4 => _mp4;
  set mp4(String? mp4) => _mp4 = mp4;
  String? get vtt => _vtt;
  set vtt(String? vtt) => _vtt = vtt;
  String? get hls => _hls;
  set hls(String? hls) => _hls = hls;
  String? get hlsEmbed => _hlsEmbed;
  set hlsEmbed(String? hlsEmbed) => _hlsEmbed = hlsEmbed;
  String? get mp4Low => _mp4Low;
  set mp4Low(String? mp4Low) => _mp4Low = mp4Low;
  int? get durationMs => _durationMs;
  set durationMs(int? durationMs) => _durationMs = durationMs;
  String? get thumbVideo => _thumbVideo;
  set thumbVideo(String? thumbVideo) => _thumbVideo = thumbVideo;
  int? get thumbVideoW => _thumbVideoW;
  set thumbVideoW(int? thumbVideoW) => _thumbVideoW = thumbVideoW;
  int? get thumbVideoH => _thumbVideoH;
  set thumbVideoH(int? thumbVideoH) => _thumbVideoH = thumbVideoH;

  Files.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _created = json['created'];
    _timestamp = json['timestamp'];
    _name = json['name'];
    _title = json['title'];
    _mimetype = json['mimetype'];
    _filetype = json['filetype'];
    _prettyType = json['pretty_type'];
    _user = json['user'];
    _userTeam = json['user_team'];
    _editable = json['editable'];
    _size = json['size'];
    _mode = json['mode'];
    _isExternal = json['is_external'];
    _externalType = json['external_type'];
    _isPublic = json['is_public'];
    _publicUrlShared = json['public_url_shared'];
    _displayAsBot = json['display_as_bot'];
    _username = json['username'];
    _urlPrivate = json['url_private'];
    _urlPrivateDownload = json['url_private_download'];
    _mediaDisplayType = json['media_display_type'];
    _convertedPdf = json['converted_pdf'];
    _thumbPdf = json['thumb_pdf'];
    _thumbPdfW = json['thumb_pdf_w'];
    _thumbPdfH = json['thumb_pdf_h'];
    _permalink = json['permalink'];
    _permalinkPublic = json['permalink_public'];
    _isStarred = json['is_starred'];
    _hasRichPreview = json['has_rich_preview'];
    _fileAccess = json['file_access'];
    _transcription = json['transcription'] != null
        ? new Transcription.fromJson(json['transcription'])
        : null;
    _mp4 = json['mp4'];
    _vtt = json['vtt'];
    _hls = json['hls'];
    _hlsEmbed = json['hls_embed'];
    _mp4Low = json['mp4_low'];
    _durationMs = json['duration_ms'];
    _thumbVideo = json['thumb_video'];
    _thumbVideoW = json['thumb_video_w'];
    _thumbVideoH = json['thumb_video_h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['created'] = this._created;
    data['timestamp'] = this._timestamp;
    data['name'] = this._name;
    data['title'] = this._title;
    data['mimetype'] = this._mimetype;
    data['filetype'] = this._filetype;
    data['pretty_type'] = this._prettyType;
    data['user'] = this._user;
    data['user_team'] = this._userTeam;
    data['editable'] = this._editable;
    data['size'] = this._size;
    data['mode'] = this._mode;
    data['is_external'] = this._isExternal;
    data['external_type'] = this._externalType;
    data['is_public'] = this._isPublic;
    data['public_url_shared'] = this._publicUrlShared;
    data['display_as_bot'] = this._displayAsBot;
    data['username'] = this._username;
    data['url_private'] = this._urlPrivate;
    data['url_private_download'] = this._urlPrivateDownload;
    data['media_display_type'] = this._mediaDisplayType;
    data['converted_pdf'] = this._convertedPdf;
    data['thumb_pdf'] = this._thumbPdf;
    data['thumb_pdf_w'] = this._thumbPdfW;
    data['thumb_pdf_h'] = this._thumbPdfH;
    data['permalink'] = this._permalink;
    data['permalink_public'] = this._permalinkPublic;
    data['is_starred'] = this._isStarred;
    data['has_rich_preview'] = this._hasRichPreview;
    data['file_access'] = this._fileAccess;
    if (this._transcription != null) {
      data['transcription'] = this._transcription!.toJson();
    }
    data['mp4'] = this._mp4;
    data['vtt'] = this._vtt;
    data['hls'] = this._hls;
    data['hls_embed'] = this._hlsEmbed;
    data['mp4_low'] = this._mp4Low;
    data['duration_ms'] = this._durationMs;
    data['thumb_video'] = this._thumbVideo;
    data['thumb_video_w'] = this._thumbVideoW;
    data['thumb_video_h'] = this._thumbVideoH;
    return data;
  }
}

class Transcription {
  String? _status;
  String? _locale;
  Preview? _preview;

  Transcription({String? status, String? locale, Preview? preview}) {
    if (status != null) {
      this._status = status;
    }
    if (locale != null) {
      this._locale = locale;
    }
    if (preview != null) {
      this._preview = preview;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  String? get locale => _locale;
  set locale(String? locale) => _locale = locale;
  Preview? get preview => _preview;
  set preview(Preview? preview) => _preview = preview;

  Transcription.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _locale = json['locale'];
    _preview =
        json['preview'] != null ? new Preview.fromJson(json['preview']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['locale'] = this._locale;
    if (this._preview != null) {
      data['preview'] = this._preview!.toJson();
    }
    return data;
  }
}

class Preview {
  String? _content;
  bool? _hasMore;

  Preview({String? content, bool? hasMore}) {
    if (content != null) {
      this._content = content;
    }
    if (hasMore != null) {
      this._hasMore = hasMore;
    }
  }

  String? get content => _content;
  set content(String? content) => _content = content;
  bool? get hasMore => _hasMore;
  set hasMore(bool? hasMore) => _hasMore = hasMore;

  Preview.fromJson(Map<String, dynamic> json) {
    _content = json['content'];
    _hasMore = json['has_more'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this._content;
    data['has_more'] = this._hasMore;
    return data;
  }
}

class Blocks {
  String? _type;
  String? _blockId;
  List<Elements>? _elements;

  Blocks({String? type, String? blockId, List<Elements>? elements}) {
    if (type != null) {
      this._type = type;
    }
    if (blockId != null) {
      this._blockId = blockId;
    }
    if (elements != null) {
      this._elements = elements;
    }
  }

  String? get type => _type;
  set type(String? type) => _type = type;
  String? get blockId => _blockId;
  set blockId(String? blockId) => _blockId = blockId;
  List<Elements>? get elements => _elements;
  set elements(List<Elements>? elements) => _elements = elements;

  Blocks.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _blockId = json['block_id'];
    if (json['elements'] != null) {
      _elements = <Elements>[];
      json['elements'].forEach((v) {
        _elements!.add(new Elements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['block_id'] = this._blockId;
    if (this._elements != null) {
      data['elements'] = this._elements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Elements {
  String? _type;
  List<Elements>? _elements;

  Elements({String? type, List<Elements>? elements}) {
    if (type != null) {
      this._type = type;
    }
    if (elements != null) {
      this._elements = elements;
    }
  }

  String? get type => _type;
  set type(String? type) => _type = type;
  List<Elements>? get elements => _elements;
  set elements(List<Elements>? elements) => _elements = elements;

  Elements.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    if (json['elements'] != null) {
      _elements = <Elements>[];
      json['elements'].forEach((v) {
        _elements!.add(new Elements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    if (this._elements != null) {
      data['elements'] = this._elements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

