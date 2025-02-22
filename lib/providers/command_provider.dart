import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommandProvider with ChangeNotifier {
  final Map<String, List<Map<String, String>>> commands = {
    'Git Commands': [
      {
        'name': 'Git Status',
        'command': 'git status',
        'description': 'Mostra o status do repositório'
      },
      {
        'name': 'Git Add All',
        'command': 'git add .',
        'description': 'Adiciona todas as alterações'
      },
      {
        'name': 'Git Commit',
        'command': 'git commit -m "update"',
        'description': 'Commit das alterações'
      },
      {
        'name': 'Git Push',
        'command': 'git push',
        'description': 'Envia alterações para o repositório remoto'
      }
    ],
    'Flutter Commands': [
      {
        'name': 'Flutter Clean',
        'command': 'flutter clean',
        'description': 'Limpa a build'
      },
      {
        'name': 'Flutter Pub Get',
        'command': 'flutter pub get',
        'description': 'Obtém as dependências'
      },
      {
        'name': 'Flutter Run Windows',
        'command': 'flutter run -d windows',
        'description': 'Executa o app no Windows'
      }
    ]
  };

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}