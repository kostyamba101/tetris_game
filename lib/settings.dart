import 'package:flutter/material.dart';
import 'package:tetris_game/values.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var edit = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Скорость: $speed'),
            trailing: IconButton(
                onPressed: () {
                  edit = true;
                  setState(() {});
                },
                icon: const Icon(Icons.speed)),
          ),
          if (edit)
            Slider(
                value: speed,
                min: 0,
                max: 300,
                onChanged: (value) {
                  setState(() {
                    speed = value;
                  });
                })
          //Text('Скорость: $speed'),
        ],
      ),
    ));
  }
}
