import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_admax_flutter/one_admax_flutter.dart';

import '../model/mediation.dart';
import '../viewmodel/mediation_viewmodel.dart';

class HomeDetailScreen extends ConsumerStatefulWidget {
  const HomeDetailScreen({super.key});

  @override
  ConsumerState<HomeDetailScreen> createState() => _HomeDetailState();
}

class _HomeDetailState extends ConsumerState<HomeDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(mediationProvider);
    initAdMax();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          children: Mediation.values.map((mediation) {
            return mediationListTile(
              mediation.toString().split('.').last,
              mediation.subtitle,
              mediation,
              selected.mediation,
              (selectedMediation) {
                ref
                    .read(mediationProvider.notifier)
                    .setMediation(selectedMediation);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void initAdMax() {
    ONEAdMax.initialize((bool isSuccess) {
      ONEAdMax.setLogEnabled(true);
    });
  }

  void unInitAdMax() {
    ONEAdMax.dispose();
  }
}



Widget mediationListTile(
  String title,
  String subtitle,
  Mediation item,
  Mediation selected,
  Function(Mediation) onChanged,
) {
  return Card(
    child: CheckboxListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      selected: selected == item,
      value: selected == item,
      onChanged: (bool? value) {
        onChanged(item);
      },
    ),
  );
}
