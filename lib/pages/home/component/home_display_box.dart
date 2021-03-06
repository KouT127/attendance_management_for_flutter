import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class HomeRadialChartBox extends StatelessWidget {
  const HomeRadialChartBox({
    Key key,
    this.title,
    this.workedTime,
    this.totalTime,
  }) : super(key: key);

  final String title;
  final double workedTime;
  final double totalTime;
  final _chartSize = const Size(250.0, 250.0);

  @override
  Widget build(BuildContext context) {
    final double workedTimePercentage = workedTime / totalTime;
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 5),
            Row(
              children: <Widget>[
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
            totalTime == 0
                ? SizedBox(height: 250)
                : AnimatedCircularChart(
                    size: _chartSize,
                    initialChartData: buildChart(
                        context,
                        workedTimePercentage.isNaN
                            ? 0.0
                            : workedTimePercentage),
                    chartType: CircularChartType.Radial,
                    percentageValues: true,
                    holeLabel: '$workedTime / $totalTime',
                    labelStyle: Theme.of(context).textTheme.headline1,
                  ),
          ],
        ),
      ),
    );
  }

  List<CircularStackEntry> buildChart(
    BuildContext context,
    double workedTimePercentage,
  ) {
    final stackList = [
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            workedTimePercentage * 100,
            workedTimePercentage > 1
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.primaryVariant,
            rankKey: 'worked',
          ),
          CircularSegmentEntry(
            (1 - workedTimePercentage) * 100,
            Theme.of(context).colorScheme.primary,
            rankKey: 'total',
          ),
        ],
        rankKey: 'percentage',
      ),
    ];

    if (workedTimePercentage > 1.0) {
      stackList.add(CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            (workedTimePercentage - 1) * 100,
            Theme.of(context).colorScheme.error,
          ),
        ],
        rankKey: 'overpercentage',
      ));
    }

    return stackList;
  }
}
