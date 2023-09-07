import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

class DailyItem extends StatelessWidget {
  final bool isSelect;
  final String title;
  final GestureTapCallback onChanged;

  const DailyItem({super.key, required this.title, required this.isSelect, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: HoverContainer(
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
                        child: Checkbox(
                          value: isSelect,
                          onChanged: (bool? value) {},
                        ),
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
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
