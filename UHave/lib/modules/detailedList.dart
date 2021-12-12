class detailedList{
  int? id;
  int? categoryId;
  String? konu;
  String? aciklama;
  String? tarih;

  categoryMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['categoryId']= categoryId;
    mapping['konu']= konu;
    mapping['aciklama']= aciklama;
    mapping['tarih']= tarih;

    return mapping;
  }
}