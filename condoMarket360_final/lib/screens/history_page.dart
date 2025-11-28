import 'package:flutter/material.dart';
import '../services/purchase_service.dart';


class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final PurchaseService purchaseService = PurchaseService();
  List<List<Map<String, dynamic>>> historicoCompras = [];

  @override
  void initState() {
    super.initState();
    carregarHistorico();
  }

  Future<void> carregarHistorico() async {
    try {
      final compras = await purchaseService.getAllPurchases();
      setState(() {
        historicoCompras = compras;
      });
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Histórico de Compras")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: historicoCompras.isEmpty
              ? Center(child: Text("Nenhuma compra realizada ainda.", style: TextStyle(color: Theme.of(context).colorScheme.primary)))
              : ListView.builder(
            itemCount: historicoCompras.length,
            itemBuilder: (context, i) {
              final compra = historicoCompras[i];
              final compraTotal = compra.fold(0.0, (sum, item) => sum + item['preco']);
              return Card(
                child: ExpansionTile(
                  iconColor: Theme.of(context).colorScheme.primary,
                  title: Text("Compra #${i + 1} — Total: R\$ ${compraTotal.toStringAsFixed(2)}"),
                  children: compra.map((item) {
                    return ListTile(
                      leading: ClipRRect(borderRadius: BorderRadius.circular(6), child: Image.network(item['img'], width: 40, height: 40, fit: BoxFit.cover)),
                      title: Text(item['nome']),
                      trailing: Text("R\$ ${item['preco'].toStringAsFixed(2)}"),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}