// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import '../data.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void atualizar() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("CondoMarket 360°")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: theme.colorScheme.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.storefront_rounded, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text("Menu Principal", style: TextStyle(fontSize: 22, color: Colors.white)),
                ],
              ),
            ),
            if (tipoUsuario == "vendedor")
              ListTile(
                leading: Icon(Icons.inventory, color: theme.colorScheme.primary),
                title: Text("Controle de Estoque"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/stock');
                },
              ),
            ListTile(
              leading: Icon(Icons.shopping_cart, color: theme.colorScheme.primary),
              title: Text("Carrinho"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart');
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: theme.colorScheme.primary),
              title: Text("Histórico de Compras"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/history');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: produtos.length,
        itemBuilder: (context, i) {
          final p = produtos[i];
          return Card(
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(p['img'], width: 56, height: 56, fit: BoxFit.cover),
              ),
              title: Text(p['nome']),
              subtitle: Text("R\$ ${p['preco'].toStringAsFixed(2)} • Estoque: ${p['qtd']}"),
              trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart, color: theme.colorScheme.primary),
                onPressed: () {
                  if (p['qtd'] > 0) {
                    setState(() {
                      carrinho.add(Map.from(p));
                      p['qtd'] -= 1;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Adicionado ao carrinho!")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Produto sem estoque!")));
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}