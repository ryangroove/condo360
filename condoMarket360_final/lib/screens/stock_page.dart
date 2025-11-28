import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data.dart';

class StockPage extends StatefulWidget {
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final nome = TextEditingController();
  final preco = TextEditingController();
  final qtd = TextEditingController();
  final img = TextEditingController(); // agora começa vazio

  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  Future<void> _selecionarImagem() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
        img.text = image.path; // caminho local da imagem
      });
    }
  }

  void adicionarProduto() {
    if (nome.text.isEmpty || preco.text.isEmpty || qtd.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Preencha todos os campos!")),
      );
      return;
    }

    setState(() {
      produtos.add({
        'nome': nome.text,
        'preco': double.tryParse(preco.text) ?? 0,
        'qtd': int.tryParse(qtd.text) ?? 0,
        'img': img.text, // pode ser URL ou caminho local
      });
    });

    nome.clear();
    preco.clear();
    qtd.clear();
    img.clear();
    _pickedImage = null;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Produto adicionado!")),
    );
  }

  Widget _buildImagemProduto(String path) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(path),
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Controle de Estoque")),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Adicionar Produto",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: nome,
                    decoration:
                    InputDecoration(labelText: "Nome do produto"),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: preco,
                    decoration: InputDecoration(labelText: "Preço"),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: qtd,
                    decoration: InputDecoration(labelText: "Quantidade"),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: img,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Imagem (URL ou caminho local)",
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.photo_library),
                        onPressed: _selecionarImagem,
                        tooltip: "Selecionar da galeria",
                      ),
                    ],
                  ),
                  if (_pickedImage != null) ...[
                    SizedBox(height: 8),
                    SizedBox(
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_pickedImage!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 12),
                  FilledButton(
                    onPressed: adicionarProduto,
                    child: Text("Adicionar"),
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: produtos.length,
                itemBuilder: (context, i) {
                  final p = produtos[i];
                  return Card(
                    margin:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: _buildImagemProduto(p['img']),
                      ),
                      title: Text(p['nome']),
                      subtitle: Text(
                        "Preço: R\$ ${p['preco'].toStringAsFixed(2)}\nEstoque: ${p['qtd']}",
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            setState(() => produtos.removeAt(i)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
