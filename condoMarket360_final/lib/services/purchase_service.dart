import '../database/app_database.dart';

class PurchaseService {
  final db = AppDatabase.instance;

  /// Salva uma compra com seus itens
  Future<void> savePurchase(List<Map<String, dynamic>> items) async {
    final database = await db.database;

    // cria a compra
    int purchaseId = await database.insert(
      'purchases',
      { 'date': DateTime.now().toIso8601String() },
    );

    // salva os itens da compra
    for (var item in items) {
      await database.insert(
        'purchase_items',
        {
          'purchase_id': purchaseId,
          'nome': item['nome'],
          'preco': item['preco'],
          'img': item['img'],
        },
      );
    }
  }

  /// Retorna TODAS as compras com seus itens
  Future<List<List<Map<String, dynamic>>>> getAllPurchases() async {
    final database = await db.database;

    final purchases = await database.query('purchases', orderBy: "id DESC");

    List<List<Map<String, dynamic>>> results = [];

    for (var purchase in purchases) {
      final items = await database.query(
        'purchase_items',
        where: 'purchase_id = ?',
        whereArgs: [purchase['id']],
      );
      results.add(items);
    }

    return results;
  }
}
