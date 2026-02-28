import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theming/cubit/cubit.dart';
import '../../models/categories_model.dart';

class CategoriesView extends StatelessWidget {
  Function onClick;

  CategoriesView({super.key, required this.onClick});

  var categories = CategoriesModel.getCategories();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemingCubit.get(context).colors.primary,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning\nHere is Some News For You",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),

            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: 12),

              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onClick(categories[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Stack(
                      alignment: index.isOdd
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      children: [
                        Stack(
                          alignment: index.isOdd
                              ? Alignment.bottomLeft
                              : Alignment.bottomRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(categories[index].image),
                            ),

                            Container(
                              padding: EdgeInsets.only(
                                left: index.isOdd ? 0 : 12,
                                right: index.isEven ? 0 : 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xFF8C8C8C),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,

                                children: [
                                  Visibility(
                                    visible: index.isOdd,
                                    child: Image.asset(
                                      "assets/images/arrow_back_rwhite.png",
                                    ),
                                  ),
                                  Text(
                                    " View All ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Visibility(
                                    visible: index.isEven,
                                    child: Image.asset(
                                      "assets/images/arrow_back_lwhite.png",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 40.0,
                            right: 30,
                          ),
                          child: Text(
                            categories[index].label,
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: categories.length,
            ),
          ],
        ),
      ),
    );
  }
}