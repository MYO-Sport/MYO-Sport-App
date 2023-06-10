class PicureModel {
  late String fileName;
  late String filePath;
  late String fileExt;

  PicureModel({this.fileName='', this.filePath='', this.fileExt=''});

  PicureModel.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    filePath = json['filePath']??"";
    fileExt = json['fileExt']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['filePath'] = this.filePath;
    data['fileExt'] = this.fileExt;
    return data;
  }
}