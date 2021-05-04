import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sp_bill/core/common/constants.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/bill_cubit.dart';
import 'package:sp_bill/features/statistic/presentation/bloc/excel_cubit.dart';

import '../../../../responsive.dart';

class TotalExcelButton extends StatelessWidget {
  final bloc = Modular.get<ExcelCubit>();
  @override
  Widget build(BuildContext context) {
    print('build');
    return BlocConsumer<ExcelCubit, ExcelState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is ExcelLoadedPart) {
            bloc.loadData(allPath: state.allPath);
          }
        },
        builder: (context, state) {
          if(state is ExcelLoading || state is ExcelLoadedPart) {
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
          if (state is ExcelFetchSuccess) {
            final exData = state.data.map((e) => e.toJson()).toList();
            return Align(
              alignment: Alignment.topRight,
              child: exData.isNotEmpty ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16) //
                ),
                onPressed: () {
                  exportExcel(data: exData, name: 'total');
                },
                child: Text('xuất excel'),
              ) : const SizedBox(),
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
                      bloc.loadPart();
                    },
                    child: Text('thử lại'),
                  ),
                  Text('không thể xuất excel, tải dữ liệu thất bại', style: TextStyle(inherit: true, color: Colors.black54, fontSize: 16),),
                ],
              ),
            );
          }
          return const SizedBox();
        }
    );
  }
}
