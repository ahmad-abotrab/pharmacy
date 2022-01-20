import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  String name;
  String id;
  double price;
  double original_price;
  String manifacture_company;
  int choiceQuantity;
  int quantity_limit;
  DateTime expireDate;
  String barcode;
  String theraputicCategoires;
  String manufactureCompany;
  String indications;
  List notUses;
  String warnings;
  String sideReactions;
  bool ifCanUseWithoutPrescription;
  String precautions;
  String from;
  int packing;
  int indexing;
  List composition;
  int basicQuantity;
  String urlImage;
  DateTime limitDateOfMedicine;
  String whereIsThere;
  int restOfAmount = 0;
  double count_for_consumption;
  String place;

  Medicine({
    this.place,
    this.id,
    this.name,
    this.barcode,
    this.theraputicCategoires,
    this.composition,
    this.packing,
    this.from,
    this.manufactureCompany,
    this.indexing,
    this.indications,
    this.ifCanUseWithoutPrescription,
    this.notUses,
    this.sideReactions,
    this.warnings,
    this.precautions,
    this.urlImage,
    this.price,
    this.original_price,
    this.manifacture_company,
    this.choiceQuantity,
    this.quantity_limit,
    this.expireDate,
    this.limitDateOfMedicine,
    this.whereIsThere,
    this.restOfAmount,
    this.count_for_consumption,
  });
  Map<String, dynamic> toJson() => {
        'id': this.id,
        'name': this.name,
        'barCode': this.barcode,
        'theraputicCategoires': this.theraputicCategoires,
        'composition': this.composition,
        'packing': this.packing,
        'from': this.from,
        'manufacture_company': this.manufactureCompany,
        'indexing': this.indexing,
        'indications': this.indications,
        'ifCanUseWithoutPrescription': this.ifCanUseWithoutPrescription,
        'notUses': this.notUses,
        'sideReactions': this.sideReactions,
        'Warnings': this.warnings,
        'precautions': this.precautions,
        'urlImage': this.urlImage,
        'restOfAmount': this.restOfAmount,
      };

  getcount_for_consumption() {
    return this.count_for_consumption;
  }

  setcount_for_consumption(count_for_consumption) {
    this.count_for_consumption = count_for_consumption;
  }

  getLimitTimeMed() {
    return this.limitDateOfMedicine;
  }

  void setLimitTimeOfMedicien(DateTime time) {
    this.limitDateOfMedicine = time;
  }

  getbarcode() {
    return this.barcode;
  }

  getTheraputicCategoires() {
    return this.theraputicCategoires;
  }

  void setTheraputicCategoires(theraputicCategoires) =>
      this.theraputicCategoires = theraputicCategoires;

  getManufactureCompany() {
    return this.manufactureCompany;
  }

  void setManufactureCompany(manufactureCompany) =>
      this.manufactureCompany = manufactureCompany;

  getIndications() {
    return this.indications;
  }

  void setIndications(indications) => this.indications = indications;

  getNotUses() {
    return this.notUses;
  }

  void setNotUses(notUses) => this.notUses = notUses;

  getWarnings() {
    return this.warnings;
  }

  void setWarnings(warnings) => this.warnings = warnings;

  getSideReactions() {
    return this.sideReactions;
  }

  void setSideReactions(sideReactions) => this.sideReactions = sideReactions;

  getIfCanUseWithoutPrescription() {
    return this.ifCanUseWithoutPrescription;
  }

  void setIfCanUseWithoutPrescription(ifCanUseWithoutPrescription) =>
      this.ifCanUseWithoutPrescription = ifCanUseWithoutPrescription;

  getPrecautions() {
    return this.precautions;
  }

  void setPrecautions(precautions) => this.precautions = precautions;

  getFrom() {
    return this.from;
  }

  void setFrom(from) => this.from = from;

  getPacking() {
    return this.packing;
  }

  void setPacking(packing) => this.packing = packing;

  getIndexing() {
    return this.indexing;
  }

  void setIndexing(indexing) => this.indexing = indexing;

  getComposition() {
    return this.composition;
  }

  void setComposition(composition) => this.composition = composition;

  getBasicQuantity() {
    return this.basicQuantity;
  }

  void setBasicQuantity(basicQuantity) => this.basicQuantity = basicQuantity;

  getUrlImage() {
    return this.urlImage;
  }

  void setUrlImage(urlImage) => this.urlImage = urlImage;

  void setName(String name) {
    this.name = name;
  }

  void setId(String id) {
    this.id = id;
  }

  void setPrice(double price) {
    this.price = price;
  }

  void setOriginalPrice(double originalPrice) {
    this.original_price = originalPrice;
  }

  void setManifacture(String manifacture) {
    this.manifacture_company = manifacture;
  }

  void setQuantity(int quantity) {
    this.choiceQuantity = quantity;
  }

  void setExpire(DateTime expire) {
    this.expireDate = expire;
  }

  void set_quantity_limit(int quantity_limit) {
    this.quantity_limit = quantity_limit;
  }

  String getName() {
    return name;
  }

  String getId() {
    return id;
  }

  double getOriginalPrice() {
    return original_price;
  }

  double getPrice() {
    return price;
  }

  String getManifacture() {
    return manifacture_company;
  }

  int getQuantity() {
    return choiceQuantity;
  }

  DateTime getExpire() {
    return expireDate;
  }

  int get_quantity_limit() {
    return quantity_limit;
  }
}
