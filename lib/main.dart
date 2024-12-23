import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculatorPage(),
    );
  }
}

class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  double height = 180.0;
  double weight = 70.0;
  int age = 23;
  double bmi = 0.0;
  String bmiCategory = "Normal";
  Color bmiColor = Colors.green;

  void calculateBMI() {
    setState(() {
      bmi = weight / ((height / 100) * (height / 100));

      if (bmi < 16.0) {
        bmiCategory = "Severely Underweight";
        bmiColor = Colors.blue;
      } else if (bmi < 18.5) {
        bmiCategory = "Underweight";
        bmiColor = Colors.lightBlue;
      } else if (bmi < 25.0) {
        bmiCategory = "Normal";
        bmiColor = Colors.green;
      } else if (bmi < 30.0) {
        bmiCategory = "Overweight";
        bmiColor = Colors.yellow;
      } else if (bmi < 35.0) {
        bmiCategory = "Obese Class I";
        bmiColor = Colors.orange;
      } else if (bmi < 40.0) {
        bmiCategory = "Obese Class II";
        bmiColor = Colors.deepOrange;
      } else {
        bmiCategory = "Obese Class III";
        bmiColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Height: ${height.toStringAsFixed(1)} cm',
              style: TextStyle(fontSize: 18.0),
            ),
            Slider(
              value: height,
              min: 100.0,
              max: 220.0,
              onChanged: (value) {
                setState(() {
                  height = value;
                });
              },
            ),
            Text(
              'Weight: ${weight.toStringAsFixed(1)} kg',
              style: TextStyle(fontSize: 18.0),
            ),
            Slider(
              value: weight,
              min: 30.0,
              max: 150.0,
              onChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
            ),
            Text(
              'Age: $age years',
              style: TextStyle(fontSize: 18.0),
            ),
            Slider(
              value: age.toDouble(),
              min: 10.0,
              max: 100.0,
              onChanged: (value) {
                setState(() {
                  age = value.toInt();
                });
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  Text(
                    'BMI: ${bmi.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    bmiCategory,
                    style: TextStyle(fontSize: 20.0, color: bmiColor),
                  ),
                  SizedBox(height: 20.0),
                  SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 10,
                        maximum: 40,
                        ranges: <GaugeRange>[
                          GaugeRange(
                            startValue: 10,
                            endValue: 16,
                            color: Colors.blue,
                          ),
                          GaugeRange(
                            startValue: 16,
                            endValue: 18.5,
                            color: Colors.lightBlue,
                          ),
                          GaugeRange(
                            startValue: 18.5,
                            endValue: 25,
                            color: Colors.green,
                          ),
                          GaugeRange(
                            startValue: 25,
                            endValue: 30,
                            color: Colors.yellow,
                          ),
                          GaugeRange(
                            startValue: 30,
                            endValue: 35,
                            color: Colors.orange,
                          ),
                          GaugeRange(
                            startValue: 35,
                            endValue: 40,
                            color: Colors.red,
                          ),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(value: bmi),
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Text(
                              bmi.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            angle: 90,
                            positionFactor: 0.5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
