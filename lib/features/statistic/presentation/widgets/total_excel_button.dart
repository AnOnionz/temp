import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/excel_cubit.dart';


class TotalExcelButton extends StatelessWidget {
  final String user;
  final bloc = Modular.get<ExcelCubit>();

  TotalExcelButton({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExcelCubit, ExcelState>(
        bloc: bloc,
        builder: (context, state) {
          if(state is ExcelInitial || state is ExcelFetchSuccess) {
            return Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16) //
                ),
                onPressed: () {
                  bloc.loadPart(user: user);
                },
                child: Text('xuất excel'),
              ),
            );

          }
          if(state is ExcelFailure){
            return Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16) //
                    ),
                    onPressed: () {
                      bloc.loadPart(user: user);
                    },
                    child: Text('thử lại'),
                  ),
                  Text('không thể xuất excel, tải dữ liệu thất bại', style: TextStyle(inherit: true, color: Colors.black54, fontSize: 16),),
                ],
              ),
            );
          }
          return Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16) //
              ),
              onPressed: () {
              },
              child: Container(
                height: 20,
                width: 20,
                child: Center(
                    child: Theme(
                        data: Theme.of(context).copyWith(accentColor: Colors.white),
                        child: CircularProgressIndicator())
                ),
              ),
            ),
          );
        }
    );
  }
}
