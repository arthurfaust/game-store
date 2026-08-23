// N1-E1 - GameStore Dart
// Complete os trechos marcados com TODO.
// O programa deve funcionar no DartPad sem entrada pelo terminal.

String dinheiro(double valor) => 'R\$ ${valor.toStringAsFixed(2)}';

class Jogo {
  final String titulo;
  final String plataforma;
  final double preco;

  // Construtor principal.
  const Jogo({
    required this.titulo,
    required this.plataforma,
    required this.preco,
  });

  // Construtor nomeado para criar um jogo com preço promocional.
  Jogo.promocional({
    required String titulo,
    required String plataforma,
    required double precoOriginal,
    required double percentualDesconto,
  }) : assert(precoOriginal >= 0, 'O preço original não pode ser negativo.'),
       assert(
         percentualDesconto >= 0 && percentualDesconto <= 100,
         'O desconto deve estar entre 0 e 100.',
       ),
       titulo = titulo,
       plataforma = plataforma,
       // TODO 1:
       // Calcular o preço final aplicando o percentual de desconto.
       preco = precoOriginal * (1 - percentualDesconto / 100);
}

class ItemCarrinho {
  final Jogo jogo;
  final int quantidade;
  final double descontoExtra;

  const ItemCarrinho({
    required this.jogo,
    required this.quantidade,
    this.descontoExtra = 0,
  }) : assert(quantidade > 0, 'A quantidade deve ser maior que zero.'),
       assert(
         descontoExtra >= 0 && descontoExtra <= 50,
         'O desconto extra deve estar entre 0 e 50.',
       );

  // TODO 2:
  // Retornar preço do jogo × quantidade, aplicando o desconto extra.
  double get subtotal {
    double valorSemDesconto = jogo.preco * quantidade;
    double valorDesconto = valorSemDesconto * (descontoExtra / 100);

    return valorSemDesconto - valorDesconto;
  }
}

class Pedido {
  final String cliente;
  final List<ItemCarrinho> itens;
  final String? cupom;

  const Pedido({required this.cliente, required this.itens, this.cupom});

  // TODO 3:
  // Somar o subtotal de todos os itens.
  double get subtotalDosItens {
    double total = 0;

    for (final item in itens) {
      total += item.subtotal;
    }
    return total;
  }

  // TODO 4:
  // Retornar 10% do subtotal quando o cupom for ALUNO10.
  // A comparação deve ignorar letras maiúsculas e minúsculas.
  double get valorDoDesconto {
    if (cupom?.toUpperCase() == 'ALUNO10') {
      return subtotalDosItens * 0.10;
    }
    return 0;
  }

  // TODO 5:
  // Frete grátis para subtotal igual ou maior que R$ 250,00.
  // Caso contrário, o frete custa R$ 20,00.
  double get valorDoFrete {
    if (subtotalDosItens >= 250) {
      return 0;
    }
    return 20;
  }

  // TODO 6:
  // subtotalDosItens - valorDoDesconto + valorDoFrete
  double get totalFinal {
    return subtotalDosItens - valorDoDesconto + valorDoFrete;
  }

  // TODO 7:
  // Menor que 150: Pedido econômico
  // De 150 até 300: Pedido padrão
  // Maior que 300: Pedido premium
  String get classificacao {
    if (totalFinal < 150) {
      return 'Pedido econômico';
    } else if (totalFinal <= 300) {
      return 'Pedido padrão';
    } else {
      return 'Pedido premium';
    }
  }

  // TODO 8:
  // Somar as quantidades de todos os itens.
  int get quantidadeTotalDeUnidades {
    int total = 0;

    for (final item in itens) {
      total += item.quantidade;
    }

    return total;
  }
}

void imprimirRecibo(Pedido pedido) {
  print('============== RECIBO =============');
  print('Cliente: ${pedido.cliente}');
  print('Cupom: ${pedido.cupom}');
  print('');
  print('Carrinho');
  print('-----------------------------------');

  for (final item in pedido.itens) {
    print('${item.jogo.titulo} ');
    print('Plataforma: ${item.jogo.plataforma}');
    print('Preço: ${dinheiro(item.jogo.preco)} ');
    print('Quantidade: ${item.quantidade} ');
    print('Desconto Extra: ${item.descontoExtra}%');
    print('Subtotal: ${dinheiro(item.subtotal)} ');
    print('-----------------------------------');
  }
  print('');
  print('Subtotal do Carrinho: ${dinheiro(pedido.subtotalDosItens)}');
  print('Desconto: ${dinheiro(pedido.valorDoDesconto)}');
  print('Frete: ${dinheiro(pedido.valorDoFrete)}');
  print('');
  print('Total: ${dinheiro(pedido.totalFinal)}');
  print('Classificação: ${pedido.classificacao}');
  print('');
  print('Quantidade de produtos: ${pedido.quantidadeTotalDeUnidades}');
  print('Produtos diferentes: ${pedido.itens.length}');
  print('===================================');
}

void main() {
  final jogo1 = Jogo(titulo: 'Galaxy Battle', plataforma: 'PC', preco: 99.90);

  final jogo2 = Jogo(
    titulo: 'Kart Turbo',
    plataforma: 'Nintendo Switch',
    preco: 189.90,
  );

  final jogo3 = Jogo.promocional(
    titulo: 'Dungeon Quest',
    plataforma: 'PlayStation 5',
    precoOriginal: 200.00,
    percentualDesconto: 20,
  );

  final jogo4 = Jogo(titulo: 'Pixel Farm', plataforma: 'PC', preco: 39.90);

  // Cabeçalho
  print('===================================');
  print('             GAMESTORE');
  print('===================================');
  // Catálogo com quatro jogos.
  final catalogo = <Jogo>[jogo1, jogo2, jogo3, jogo4];
  print('Catálogo carregado: ${catalogo.length} jogos');
  print('');

  final itens = <ItemCarrinho>[
    ItemCarrinho(jogo: jogo1, quantidade: 1),
    ItemCarrinho(jogo: jogo2, quantidade: 1, descontoExtra: 10),
    ItemCarrinho(jogo: jogo4, quantidade: 2),
  ];

  final pedido = Pedido(cliente: 'Ana', itens: itens, cupom: 'ALUNO10');

  imprimirRecibo(pedido);
}
