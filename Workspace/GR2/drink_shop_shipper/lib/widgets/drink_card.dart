import 'package:flutter/material.dart';

class DrinkCard extends StatelessWidget {
  const DrinkCard(
      {super.key,
      required this.itemName,
      required this.basePrice,
      required this.thumbnail});
  final String itemName;
  final int basePrice;
  final String thumbnail;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 332,
      height: 104.75,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 332,
              height: 104.75,
              decoration: ShapeDecoration(
                color: const Color(0xFFFFF5E9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 18,
            top: 25,
            child: SizedBox(
              width: 152,
              height: 18.02,
              child: Text(
                itemName,
                style: const TextStyle(
                  color: Color(0xFF230C02),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.16,
                ),
              ),
            ),
          ),
          Positioned(
            left: 18,
            top: 60,
            child: SizedBox(
              width: 152,
              height: 38.29,
              child: Text(
                '${basePrice.toString()}đ',
                style: const TextStyle(
                  color: Color(0xFF230C02),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.07,
                ),
              ),
            ),
          ),
          Positioned(
            left: 256,
            top: 6,
            child: Container(
              width: 70,
              height: 93,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
