import 'dart:convert'; // Pour encoder/décoder du JSON
import 'dart:io' show HttpHeaders;
import 'package:http/http.dart' as http; // Pour les requêtes HTTP

// Fonction pour récupérer tous les produits
Future<void> getProducts(String baseUrl) async {
  final response = await http.get(Uri.parse('$baseUrl/products'));

  if (response.statusCode == 200) {
    List<dynamic> products = jsonDecode(response.body);
    print('🛒 Produits disponibles:');
    for (var product in products) {
      print('🏷️ Nom: ${product['name']}, 💲 Prix: ${product['price']}');
    }
  } else {
    print('❌ Erreur lors de la récupération des produits');
  }
}

// Fonction pour ajouter un nouveau produit
Future<void> addProduct(String baseUrl, Map<String, dynamic> product) async {
  final response = await http.post(
    Uri.parse('$baseUrl/products'),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: jsonEncode(product),
  );

  if (response.statusCode == 201) {
    print('✅ Produit ajouté avec succès: ${product['name']}');
  } else {
    print('❌ Erreur lors de l\'ajout du produit: ${product['name']}');
  }
}

// Fonction pour récupérer toutes les commandes
Future<void> getOrders(String baseUrl) async {
  final response = await http.get(Uri.parse('$baseUrl/orders'));

  if (response.statusCode == 200) {
    List<dynamic> orders = jsonDecode(response.body);
    print('📦 Commandes disponibles:');
    for (var order in orders) {
      print('📋 Produit: ${order['product']}, 🚚 Quantité: ${order['quantity']}');
    }
  } else {
    print('❌ Erreur lors de la récupération des commandes');
  }
}

// Fonction pour créer une nouvelle commande
Future<void> addOrder(String baseUrl, Map<String, dynamic> order) async {
  final response = await http.post(
    Uri.parse('$baseUrl/orders'),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: jsonEncode(order),
  );

  if (response.statusCode == 201) {
    print('✅ Commande créée avec succès: ${order['product']} (Quantité: ${order['quantity']})');
  } else {
    print('❌ Erreur lors de la création de la commande: ${order['product']}');
  }
}


// Fonction principale
void main() async {
  // URL de base de l'API
  final String baseUrl = 'http://localhost:3000';

  // 1. Récupérer tous les produits
  await getProducts(baseUrl);

  // 2. Ajouter un nouveau produit
  final newProduct = {'name': 'Produit 1', 'price': 100};
  await addProduct(baseUrl, newProduct);

  // 3. Récupérer toutes les commandes
  await getOrders(baseUrl);
  

  // 4. Créer une nouvelle commande
  final newOrder = {'product': 'Produit 1', 'quantity': 2};
  await addOrder(baseUrl, newOrder);
}