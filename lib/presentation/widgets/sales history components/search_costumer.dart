import 'package:flutter/material.dart';

class SearchCostumer extends StatelessWidget {
  const SearchCostumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: TextField(
          decoration: InputDecoration(
              hintText: "Search with Name / Phone Number",
              filled: true,
              fillColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                padding: const EdgeInsets.all(0),
              )),
        ),
      ),
    );
  }
}
