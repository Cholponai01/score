import 'package:get_it/get_it.dart';
import 'package:score/features/score/presentation/cubit/score_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => ScoreCubit());
}
