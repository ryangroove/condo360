import 'package:flutter/material.dart';
import '../data.dart';
import '../services/purchase_service.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final PurchaseService purchaseService = PurchaseService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double total = carrinho.fold(0, (sum, item) => sum + item['preco']);
    return Scaffold(
      appBar: AppBar(title: Text("Carrinho")),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: carrinho.isEmpty
                  ? Center(child: Text("Seu carrinho está vazio.", style: TextStyle(color: theme.colorScheme.primary)))
                  : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: carrinho.length,
                itemBuilder: (context, i) {
                  final item = carrinho[i];
                  return Card(
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(item['img'], width: 50, height: 50, fit: BoxFit.cover),
                      ),
                      title: Text(item['nome']),
                      subtitle: Text("R\$ ${item['preco'].toStringAsFixed(2)}"),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red.shade600),
                        onPressed: () {
                          setState(() {
                            final original = produtos.firstWhere((p) => p['nome'] == item['nome'], orElse: () => {});
                            if (original.isNotEmpty) original['qtd'] += 1;
                            carrinho.removeAt(i);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Total", style: theme.textTheme.bodyLarge),
                  Text("R\$ ${total.toStringAsFixed(2)}", style: theme.textTheme.titleMedium),
                ]),
                FilledButton(
                  onPressed: carrinho.isEmpty
                      ? null
                      : () async {
                    await purchaseService.savePurchase(carrinho);
                    historico.add(List.from(carrinho));
                    carrinho.clear();
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Compra finalizada com sucesso!")));
                    Navigator.pop(context);
                  },
                  child: Text("Finalizar Compra"),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}