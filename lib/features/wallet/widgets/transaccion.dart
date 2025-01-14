import 'package:cortijo_app/features/notices/widgets/no_notice.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../widgets/app_bottons.dart';
import '../wallet_view_model.dart';
import 'package:intl/intl.dart' as intl;

class TransaccionesWidget extends StatefulWidget {
  const TransaccionesWidget(
    this.model, {
    Key? key,
  }) : super(key: key);

  final WalletViewModel model;

  @override
  State<TransaccionesWidget> createState() => _TransaccionesWidgetState();
}

class _TransaccionesWidgetState extends State<TransaccionesWidget> {
  List<TransaccionOptClass> opt = [
    TransaccionOptClass(0, ' Todo ', true),
    TransaccionOptClass(1, 'Alimentación', false),
    TransaccionOptClass(2, 'Lavandería', false),
    TransaccionOptClass(3, 'Bicicletas', false)
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: 63,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: opt.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: AppOvalButton(
                    onPressed: () {
                      setState(() {
                        opt[i].selected = true;
                        for (var e in opt) {
                          if (e.name != opt[i].name) {
                            e.selected = false;
                          }
                        }
                      });
                      widget.model.filterTransaction(opt[i].id);
                    },
                    text: opt[i].name,
                    colorButton: opt[i].selected
                        ? AppColors.oliveGreen
                        : AppColors.white,
                    colorText: opt[i].selected
                        ? AppColors.white
                        : AppColors.oliveGreen,
                  ),
                );
              },
            ),
          ),
          if (widget.model.bookingService.isEmpty && !widget.model.busy)
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: NoResultWidget(
                visible:
                    widget.model.bookingService.isEmpty && !widget.model.busy,
                text: "No tienes transacciones",
              ),
            ),
          ...widget.model.bookingService
              .map((e) => Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              e.service?.name ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 5),
                            ...e.items!
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: SizedBox(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                                'X${e.amount} ${e.productName}'),
                                          ),
                                          Text('${e.total} €'),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            Text(
                              'Fecha: ${intl.DateFormat.yMd('es').format(e.startDate ?? DateTime.now())}',
                              style: const TextStyle(color: AppColors.grey),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Total",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  "${e.total ?? ''}€",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
