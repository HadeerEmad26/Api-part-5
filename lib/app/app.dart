import 'package:api_part2/core/database/cache/cache_helper.dart';
import 'package:api_part2/core/services/service_locator.dart';
import 'package:api_part2/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../feature/auth/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.initCache();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthCubit>(),
        ),
        BlocProvider(create: (context) => getIt<AuthCubit>()),
      ],
      child: const MaterialApp(
        title: 'Api',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

