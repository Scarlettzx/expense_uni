import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/entities.dart';
import 'family_detail_card.dart';

class Familycard extends StatefulWidget {
  final GetAllrightsEmployeeFamilyEntity familyData;
  const Familycard({super.key, required this.familyData});

  @override
  State<Familycard> createState() => _FamilycardState();
}

class _FamilycardState extends State<Familycard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 8,
      shadowColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF846AFF),
              Color(0xFF755EE8),
              Colors.purpleAccent,
              Colors.amber,
            ],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: FadeInImage(
                              placeholder: AssetImage(
                                  "assets/images/default_profile.png"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                        "assets/images/default_profile.png"));
                              },
                              image: (widget.familyData.imageUrl != null)
                                  ? Image.network(
                                      widget.familyData.imageUrl!,
                                    ).image
                                  : const AssetImage(
                                      "assets/images/default_profile.png",
                                    ),
                              fit: BoxFit.cover,
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Text(
                        "สิทธิ${widget.familyData.relationship!}",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                  Gap(10),
                  Expanded(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text.rich(
                          TextSpan(
                            text:
                                "${widget.familyData.firstnameTh} ${widget.familyData.lastnameTh}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          // style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Gap(10),
                        Container(
                          width: double.infinity,
                          // width: 70,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            border: Border.all(
                                strokeAlign: 5,
                                width: 1,
                                color: Colors.white),
                            color: Color(0xffff99ca),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).devicePixelRatio * 6,
                            vertical:
                                MediaQuery.of(context).devicePixelRatio * 3,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isExpanded = !_isExpanded;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.touch_app, color: Colors.white),
                                  Text(
                                    'ดูรายละเอียดสิทธิ',
                                    style: TextStyle(color: Colors.white, fontSize: 11),
                                  ),
                                  Gap(10),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Gap(10),
              FamilyDetailsCard(
                  isExpanded: _isExpanded,
                  idFamily: widget.familyData.idFamily,
                  allrights: widget.familyData.allRights!)
            ],
          ),
        ),
      ),
    );
  }
}
