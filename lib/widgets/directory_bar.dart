import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/directory_provider.dart';

class DirectoryBar extends StatelessWidget {
  const DirectoryBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DirectoryProvider>(
      builder: (context, directoryProvider, _) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    directoryProvider.currentDirectory ?? 'Select a directory',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.folder_open, color: Theme.of(context).primaryColor),
                onPressed: () async {
                  String? path = await FilePicker.platform.getDirectoryPath();
                  if (path != null) {
                    await directoryProvider.setDirectory(path);
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.save, color: Theme.of(context).primaryColor),
                onPressed: directoryProvider.currentDirectory == null ? null : () {
                  // Save current directory as default
                },
              ),
            ],
          ),
        );
      },
    );
  }
}