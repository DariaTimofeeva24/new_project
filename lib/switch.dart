import 'package:flutter/material.dart';

class SwitchesDemo extends StatefulWidget {
  const SwitchesDemo({Key? key}) : super(key: key);

  @override
  State<SwitchesDemo> createState() => _SwitchesDemoState();
}

enum SkillLevel { junior, middle, senior }

class _SwitchesDemoState extends State<SwitchesDemo> {
  bool _checked = false;
  bool _confirmAgreement = true;
  SkillLevel? _skillLevel = SkillLevel.junior;

  void _onCheckedChange(bool? val) {
    setState(() {
      _checked = !_checked;
    });
  }

  void _onSkillLevelChanged(SkillLevel? value) {
    setState(() {
      _skillLevel = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(),
            body: Center(
                child: Column(children: [
                  Row(
                    children: [
                      Checkbox(value: _checked, onChanged: _onCheckedChange),
                      const Text('выбор'),
                    ],
                  ),
                  CheckboxListTile(
                      title: const Text('Принять'),
                      value: _confirmAgreement, onChanged: (val) {
                    setState(() {
                      _confirmAgreement = !_confirmAgreement;
                    });
                  }),
                  Row(
                    children: [
                      Switch(value: _checked, onChanged: _onCheckedChange),
                      const Text('Включить')
                    ],
                  ),
                  SwitchListTile(
                      title: const Text ('Включить'),
                      value: _checked,
                      onChanged: _onCheckedChange
                  ),
                  const Text ('Уровень навыков: '),
                  RadioListTile<SkillLevel>(
                    title: const Text('junior'),
                    value: SkillLevel.junior,
                    groupValue: _skillLevel,
                    onChanged: _onSkillLevelChanged,
                  ),
                  RadioListTile<SkillLevel>(
                    title: const Text('middle'),
                    value: SkillLevel.middle,
                    groupValue: _skillLevel,
                    onChanged: _onSkillLevelChanged,
                  ),
                  RadioListTile<SkillLevel>(
                    title: const Text('senior'),
                    value: SkillLevel.senior,
                    groupValue: _skillLevel,
                    onChanged: _onSkillLevelChanged,
                  ),
                ]))));
  }
}