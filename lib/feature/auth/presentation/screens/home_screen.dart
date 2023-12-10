import 'package:api_part2/core/services/service_locator.dart';
import 'package:api_part2/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:api_part2/feature/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>()..login(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is LoginLoadingState){
            Fluttertoast.showToast(msg: state.message);
          }
          if(state is LoginErrorState){
            Fluttertoast.showToast(msg: state.message);
          }

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('HomeScreen'),
              centerTitle: true,
              backgroundColor: Colors.blueGrey,
            ),
            body: Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).logout();
                    },
                    child: Text('LogOut'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).changePassword();
                    },
                    child: Text('ChangePassword'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).deleteChef();
                    },
                    child: Text('Delete Chef'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
