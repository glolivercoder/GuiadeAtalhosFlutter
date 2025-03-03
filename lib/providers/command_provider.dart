import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert'; // Added this import for utf8

class CommandProvider with ChangeNotifier {
  // Removed final to allow modifications
  Map<String, List<Map<String, String>>> commands = {
    'Git Init Commands': [
      {
        'name': 'Init Repository',
        'command': 'git init',
        'description': 'Inicializa um novo repositório',
        'interactive': 'false'
      },
      {
        'name': 'Add Remote',
        'command': 'git remote add origin',
        'description': 'Adiciona repositório remoto',
        'interactive': 'true'
      },
      {
        'name': 'Initial Commit',
        'command': 'git add . && git commit -m',
        'description': 'Adiciona todos os arquivos e faz o commit inicial',
        'interactive': 'true'
      },
      {
        'name': 'Push to Main',
        'command': 'git push -u origin main',
        'description': 'Envia para o repositório remoto',
        'interactive': 'false'
      },
      {
        'name': 'Create Main2 Branch',
        'command': 'git checkout -b main2',
        'description': 'Cria e muda para a branch main2',
        'interactive': 'false'
      },
      {
        'name': 'Push Main2',
        'command': 'git push -u origin main2',
        'description': 'Envia a branch main2 para o repositório remoto',
        'interactive': 'false'
      },
      {
        'name': 'Switch to Main2',
        'command': 'git checkout main2',
        'description': 'Muda para a branch main2',
        'interactive': 'false'
      },
      {
        'name': 'Copy to Main2',
        'command': 'git checkout main && git pull && git checkout main2 && git merge main',
        'description': 'Copia o conteúdo da main para main2',
        'interactive': 'false'
      }
    ],
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
      },
      {
        'name': 'Clean Untracked Files',
        'command': 'git clean -fd',
        'description': 'Remove arquivos não rastreados',
        'interactive': 'false'
      },
      {
        'name': 'Create Fork',
        'command': 'git remote add upstream',
        'description': 'Cria um fork do repositório',
        'interactive': 'true'
      },
      {
        'name': 'Sync Fork',
        'command': 'git fetch upstream && git merge upstream/main',
        'description': 'Sincroniza o fork com o repositório original',
        'interactive': 'false'
      },
      {
        'name': 'Show Remotes',
        'command': 'git remote -v',
        'description': 'Mostra os repositórios remotos',
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
    ],  // Added missing comma
    'Flutter Windows Fix': [
      {
        'name': 'Clean All',
        'command': 'flutter clean && rd /s /q build && rd /s /q .dart_tool',
        'description': 'Limpa todos os arquivos de build',
        'interactive': 'false'
      },
      {
        'name': 'Remove Windows',
        'command': 'rd /s /q windows',
        'description': 'Remove pasta windows atual',
        'interactive': 'false'
      },
      {
        'name': 'Enable Windows Desktop',
        'command': 'flutter config --enable-windows-desktop',
        'description': 'Habilita desenvolvimento Windows',
        'interactive': 'false'
      },
      {
        'name': 'Recreate Windows',
        'command': 'flutter create --platforms=windows .',
        'description': 'Recria arquivos Windows',
        'interactive': 'false'
      },
      {
        'name': 'Update Dependencies',
        'command': 'flutter pub get && flutter pub upgrade',
        'description': 'Atualiza todas as dependências',
        'interactive': 'false'
      }
    ],  // Vírgula adicionada aqui
    'Docker Commands': [
      {
        'name': 'List Containers',
        'command': 'wsl docker ps -a',
        'description': 'Lista todos os containers',
        'interactive': 'false'
      },
      {
        'name': 'List Images',
        'command': 'wsl docker images',
        'description': 'Lista todas as imagens',
        'interactive': 'false'
      },
      {
        'name': 'Pull Image',
        'command': 'wsl docker pull',
        'description': 'Baixa uma imagem do Docker Hub',
        'interactive': 'true'
      },
      {
        'name': 'Run Container',
        'command': 'wsl docker run -d -p',
        'description': 'Executa um container com porta',
        'interactive': 'true'
      },
      {
        'name': 'Stop Container',
        'command': 'wsl docker stop',
        'description': 'Para um container específico',
        'interactive': 'true'
      },
      {
        'name': 'Remove Container',
        'command': 'wsl docker rm',
        'description': 'Remove um container específico',
        'interactive': 'true'
      },
      {
        'name': 'Container Logs',
        'command': 'wsl docker logs -f',
        'description': 'Mostra logs do container em tempo real',
        'interactive': 'true'
      },
      {
        'name': 'Execute in Container',
        'command': 'wsl docker exec -it',
        'description': 'Executa comando no container',
        'interactive': 'true'
      },
      {
        'name': 'Build Image',
        'command': 'wsl docker build -t',
        'description': 'Constrói uma imagem Docker',
        'interactive': 'true'
      },
      {
        'name': 'Compose Up',
        'command': 'wsl docker-compose up -d',
        'description': 'Inicia todos os serviços',
        'interactive': 'false'
      },
      {
        'name': 'Compose Down',
        'command': 'wsl docker-compose down',
        'description': 'Para e remove todos os serviços',
        'interactive': 'false'
      },
      {
        'name': 'Compose Build',
        'command': 'wsl docker-compose build',
        'description': 'Constrói todos os serviços',
        'interactive': 'false'
      },
      {
        'name': 'Clean System',
        'command': 'wsl docker system prune -a --volumes',
        'description': 'Remove todos recursos não usados',
        'interactive': 'false'
      },
      {
        'name': 'Network List',
        'command': 'wsl docker network ls',
        'description': 'Lista todas as redes Docker',
        'interactive': 'false'
      },
      {
        'name': 'Volume List',
        'command': 'wsl docker volume ls',
        'description': 'Lista todos os volumes Docker',
        'interactive': 'false'
      }
    ]
  }; // Fechamento do Map commands

  void addCategory(String categoryName) {
    if (!commands.containsKey(categoryName)) {
      commands[categoryName] = [];
      notifyListeners();
    }
  }

  void addCommand(String category, Map<String, String> command) {
    if (commands.containsKey(category)) {
      commands[category]?.add(command);
      notifyListeners();
    }
  }

  Future<void> executeCommand(BuildContext context, Map<String, String> commandData) async {
    try {
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
          final process = await Process.start(
            'cmd.exe',
            ['/K', command], // /K keeps the window open
            runInShell: true,
            mode: ProcessStartMode.detached,
          );
    
          // Real-time output monitoring
          process.stdout.transform(utf8.decoder).listen((data) {
            print('Output: $data');
          });
    
          process.stderr.transform(utf8.decoder).listen((data) {
            print('Error: $data');
          });
        }
      } else {
        final process = await Process.start(
          'cmd.exe',
          ['/K', commandData['command']!], // /K keeps the window open
          runInShell: true,
          mode: ProcessStartMode.detached,
        );
    
        // Real-time output monitoring
        process.stdout.transform(utf8.decoder).listen((data) {
          print('Output: $data');
        });
    
        process.stderr.transform(utf8.decoder).listen((data) {
          print('Error: $data');
        });
      }
    } catch (e) {
      print('Command execution error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao executar comando: $e')),
        );
      }
    }
  }
  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
} // Fechamento da classe CommandProvider