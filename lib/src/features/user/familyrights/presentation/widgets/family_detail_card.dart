import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../domain/entities/entities.dart';
import 'accident_Insurance_detail.dart';
import 'health_Insurance_detail.dart';

class FamilyDetailsCard extends StatelessWidget {
  final bool isExpanded;
  final int? idFamily;
  final List<AllRightEntity> allrights;

  const FamilyDetailsCard({
    Key? key,
    required this.isExpanded,
    required this.idFamily,
    required this.allrights,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 6),
      curve: Curves.fastOutSlowIn,
      child: isExpanded
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: allrights.map((allright) {
                    return Column(
                      children: [
                        if (allright.principle == "totalLimit")
                          HealthInsuranceDetail(allright: allright),
                        if (allright.principle == "detail") ...[
                          const Gap(17),
                          AccidentInsuranceDetail(allright: allright),
                        ]
                      ],
                    );
                  }).toList(),
                );
              },
            )
          : const SizedBox.shrink(),
    );
  }
}
