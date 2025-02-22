import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/command_provider.dart';
import 'command_category.dart';

class CommandCategories extends StatelessWidget {
  const CommandCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CommandProvider>(
      builder: (context, commandProvider, _) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: commandProvider.commands.length,
          itemBuilder: (context, index) {
            final category = commandProvider.commands.keys.elementAt(index);
            final commands = commandProvider.commands[category]!;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CommandCategory(
                title: category,
                commands: commands,
              ),
            );
          },
        );
      },
    );
  }
}