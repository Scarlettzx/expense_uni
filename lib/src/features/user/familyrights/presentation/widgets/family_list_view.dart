import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';

// import '../../../../../../injection_container.dart';
// import '../../../../../core/features/user/presentation/provider/profile_provider.dart';
import '../../domain/entities/entities.dart';
// import '../bloc/familyrights_bloc.dart';
// import '../bloc/familyrights_bloc.dart';
import 'family_card.dart';

class FamilyList extends StatefulWidget {
  final List<GetAllrightsEmployeeFamilyEntity> familyData;
  const FamilyList({super.key, required this.familyData});

  @override
  State<FamilyList> createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  @override
  Widget build(BuildContext context) {
    print("checckkkkkkkkkkkkkkkkkkk");
    print(widget.familyData);
    return Expanded(
      child: SizedBox(
        // height: 500,
        width: double.infinity,
        child: ListView.builder(
            itemCount: widget.familyData.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: [
                      Familycard(familyData: widget.familyData[index]),
                     const Gap(30)
                    ],
                  ));
            }),
      ),
    );
  }
}
