String tipoUsuario = "comprador";

List<Map<String, dynamic>> produtos = [
  {
    'nome': 'Água Mineral 500ml',
    'preco': 3.50,
    'qtd': 20,
    'img': 'https://i.imgur.com/8Km9tLL.png',
  },
  {
    'nome': 'Refrigerante Lata',
    'preco': 5.20,
    'qtd': 15,
    'img': 'https://i.imgur.com/8Km9tLL.png',
  },
  {
    'nome': 'Chocolate Barra',
    'preco': 7.00,
    'qtd': 10,
    'img': 'https://i.imgur.com/8Km9tLL.png',
  },
];

List<Map<String, dynamic>> carrinho = [];

List<List<Map<String, dynamic>>> historico = []; // sem acento