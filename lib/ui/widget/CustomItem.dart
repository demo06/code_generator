import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

class CustomItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final Widget child;

  const CustomItem({super.key, required this.icon, required this.title, required this.subTitle, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: HoverContainer(
        // color: Colors.white,
        // hoverColor: const Color(0XFFF5F6F9),
        hoverDecoration: BoxDecoration(
          color: const Color(0XFFF5F6F9),
          border: Border.all(color: const Color(0XFFE8E8E8)),
          borderRadius: BorderRadius.circular(4),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0XFFE8E8E8)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FractionallySizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(icon, size: 24,color: Colors.grey,),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 15, color: Color(0xFF1A1A1A)),
                        ),
                        Text(
                          subTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 15, color: Color(0xFF5D5E5F)),
                        )
                      ],
                    ),
                  )
                ],
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
