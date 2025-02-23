import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class CommandProvider with ChangeNotifier {
  final Map<String, List<Map<String, String>>> commands = {
    'Git Commands': [
      {
        'name': 'Git Status',
        'command': 'git status',
        'description': 'Mostra o status do repositório',
        'interactive': 'false'
      },
      {
        'name': 'Git Add All',
        'command': 'git add .',
        'description': 'Adiciona todas as alterações',
        'interactive': 'false'
      },
      {
        'name': 'Git Commit',
        'command': 'git commit -m',
        'description': 'Commit das alterações',
        'interactive': 'true'
      },
      {
        'name': 'Git Push',
        'command': 'git push',
        'description': 'Envia alterações para o repositório remoto',
        'interactive': 'false'
      },
      {
        'name': 'Reset to Last Commit',
        'command': 'git reset --hard HEAD',
        'description': 'Reverte para o último commit',
        'interactive': 'false'
      }
    ],
    'Flutter Commands': [
      {
        'name': 'Flutter Clean',
        'command': 'flutter clean',
        'description': 'Limpa a build',
        'interactive': 'false'
      },
      {
        'name': 'Flutter Pub Get',
        'command': 'flutter pub get',
        'description': 'Obtém as dependências',
        'interactive': 'false'
      },
      {
        'name': 'Flutter Run Windows',
        'command': 'flutter run -d windows',
        'description': 'Executa o app no Windows',
        'interactive': 'false'
      }
    ]
  };
  Future<void> executeCommand(BuildContext context, Map<String, String> commandData) async {
    if (commandData['interactive'] == 'true') {
      final textController = TextEditingController();
      final result = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(commandData['name']!),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: commandData['name'] == 'Git Commit' ? 'Digite a mensagem do commit' : 'Digite o valor',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, textController.text),
              child: const Text('Executar'),
            ),
          ],
        ),
      );

      if (result != null && result.isNotEmpty) {
        final command = '${commandData['command']} "$result"';
        await Process.run('git', command.split(' ').skip(1).toList());
      }
    } else {
      await Process.run(
        commandData['command']!.split(' ').first,
        commandData['command']!.split(' ').skip(1).toList(),
      );
    }
  }

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}