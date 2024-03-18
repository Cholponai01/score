import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score/features/score/presentation/cubit/score_cubit.dart';
import 'package:score/features/score/presentation/pages/score/score_page.dart';
import 'package:score/service_locator.dart';
import 'service_locator.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]).then((_) async {
    await di.init();
    runApp(
      const MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<ScoreCubit>())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PlayerScorePage(),
      ),
    );
  }
}
