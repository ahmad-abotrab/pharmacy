class costs {
  String typeOfCost;
  double cost;
  String notes;
  String formattedDate;
  costs({
    String typeOfCost,
    double cost,
    String notes,
    String formattedDate,
  }) {
    this.typeOfCost = typeOfCost;
    this.cost = cost;
    this.notes = notes;
    this.formattedDate = formattedDate;
  }

  Map<String, dynamic> toJson() => {
        'typeOfCost': typeOfCost,
        'cost': cost,
        'notes': notes,
        'formattedDate': formattedDate,
      };
}
