
import 'package:e2ea/newModels/models/consumptionModel.dart';
import 'package:flutter/material.dart';

class ConsumptionRate extends StatefulWidget {
  ConsumptionRate({
    Key key,
    this.consumptionRateMax,
    this.consumptionRateMin,
  }) : super(key: key);
  final ConsumptionRateModel consumptionRateMax;
  final ConsumptionRateModel consumptionRateMin;

  @override
  _ConsumptionRateState createState() => _ConsumptionRateState();
}

class _ConsumptionRateState extends State<ConsumptionRate> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Consumption rate'),
        content: Column(
          children: [
            Row(
              children: [
                Text('max consumption : '),
                Text(widget.consumptionRateMax.name),
                Text(widget.consumptionRateMax.quantity.toString()),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.06),
                    Row(
              children: [
                Text('min consumption : '),
                Text(widget.consumptionRateMin.name),
                Text(widget.consumptionRateMin.quantity.toString()),
              ],
            ),
          ],
        ));
  }
}
