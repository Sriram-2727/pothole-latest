import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
      routes: {
        '/tank-capacity': (context) => TankCapacityScreen(),
        '/usage-stats': (context) => UsageStatsScreen(),
      },
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isMotorOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Hydrosense'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular Water Level Indicator
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: 0.3, // Example: 30%
                        strokeWidth: 12,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                      ),
                    ),
                    Text(
                      '30%',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Stats Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard('Total Capacity', '12000 L', Icons.water,
                      onTap: () {
                    Navigator.pushNamed(context, '/tank-capacity');
                  }),
                  _buildStatCard('Usage', '6000 L', Icons.opacity, onTap: () {
                    Navigator.pushNamed(context, '/usage-stats');
                  }),
                ],
              ),

              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard('Motor', isMotorOn ? 'On' : 'Off',
                      Icons.power_settings_new,
                      isSwitch: true),
                  _buildStatCard('Sump Level', '93%', Icons.speed),
                ],
              ),

              SizedBox(height: 24),

              // Additional Sections
              Text(
                'Device Control & Stats',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 8),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Additional controls and statistics will be displayed here.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon,
      {bool isSwitch = false, VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: Colors.blueAccent, size: 28),
                  if (isSwitch)
                    Switch(
                      value: isMotorOn,
                      onChanged: (value) {
                        setState(() {
                          isMotorOn = value;
                        });
                      },
                      activeColor: Colors.blueAccent,
                    ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class TankCapacityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tank Capacities'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildTankCard('Tank 1', '3000 L'),
          _buildTankCard('Tank 2', '4000 L'),
          _buildTankCard('Tank 3', '2000 L'),
          _buildTankCard('Tank 4', '3000 L'),
        ],
      ),
    );
  }

  Widget _buildTankCard(String tankName, String capacity) {
    return Card(
      child: ListTile(
        title: Text(tankName),
        subtitle: Text('Capacity: $capacity'),
        leading: Icon(Icons.water, color: Colors.blueAccent),
      ),
    );
  }
}




class UsageStatsScreen extends StatelessWidget {
  final List<DailyUsage> dailyData = List.generate(
    7, 
    (index) => DailyUsage(
      'Day ${index + 1}', 
      Random().nextInt(100), // Random daily usage between 0 and 100
    ),
  );

  final List<WeeklyUsage> weeklyData = List.generate(
    4, 
    (index) => WeeklyUsage(
      index, 
      Random().nextInt(1500), // Random weekly usage between 0 and 1500
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usage Statistics'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Consumption: 500 L',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(height: 16),
            Text(
              'Weekly Consumption: 3500 L',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(height: 32),
            Text(
              'Random Daily Consumption Graph',
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
            SizedBox(height: 16),
            _buildDailyBarChart(),
            SizedBox(height: 32),
            Text(
              'Random Weekly Consumption Graph',
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
            SizedBox(height: 16),
            _buildWeeklyLineChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyBarChart() {
    return charts.BarChart(
      [
        charts.Series<DailyUsage, String>(
          id: 'DailyUsage',
          domainFn: (DailyUsage usage, _) => usage.day,
          measureFn: (DailyUsage usage, _) => usage.usage,
          data: dailyData,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        ),
      ],
      animate: true,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: charts.OrdinalAxisSpec(),
    );
  }

  Widget _buildWeeklyLineChart() {
    return charts.LineChart(
      [
        charts.Series<WeeklyUsage, int>(
          id: 'WeeklyUsage',
          domainFn: (WeeklyUsage usage, _) => usage.week,
          measureFn: (WeeklyUsage usage, _) => usage.usage,
          data: weeklyData,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          fillColorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault.lighter,
        ),
      ],
      animate: true,
      defaultRenderer: charts.LineRendererConfig(),
      domainAxis: charts.NumericAxisSpec(),
    );
  }
}

class DailyUsage {
  final String day;
  final int usage;

  DailyUsage(this.day, this.usage);
}

class WeeklyUsage {
  final int week;
  final int usage;

  WeeklyUsage(this.week, this.usage);
}
