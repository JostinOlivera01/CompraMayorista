import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test01/business_logic/models/ad_model.dart';
import 'package:test01/views/widgets/adpreviu_.dart';
import 'package:test01/views/widgets/grouppreviu_.dart';

class AdCard extends StatelessWidget {
  final Ad ad;

  const AdCard({super.key, required this.ad});

  void _showBottomSheet(BuildContext context) {
    // Dependiendo del tipo de publicación, mostrar el BottomSheet adecuado
    if (ad.publicationType == "Individual") {
      showModalBottomSheet(
        context: context,
        builder: (context) => IndividualPurchaseBottomSheet(ad: ad),
      );
    } else if (ad.publicationType == "Group") {
      showModalBottomSheet(
        context: context,
        builder: (context) => GroupPurchaseBottomSheet(ad: ad),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context), // Detectar el toque en la tarjeta
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen destacada
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9, // Proporción de imagen ajustable
                child: Image.network(
                  ad.imgUrl ?? 'https://img.freepik.com/free-photo/still-life-graphic-design-office_23-2151345410.jpg?t=st=1731011093~exp=1731014693~hmac=15ce315f93b1e43178fecde6a19ecff5e6e9a3d639c53abc260f21c4e3d2e81d&w=996',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título del producto y tipo de publicación alineado a la derecha
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          ad.productName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (ad.publicationType == "Group" || ad.publicationType == "Individual")
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: ad.publicationType == "Group" ? Colors.blue : Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            ad.publicationType,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Categoría: ${ad.category}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Precio
                      Row(
                        children: [
                          const Icon(Icons.price_check, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(
                            '\$${ad.precioProduct?.toStringAsFixed(0) ?? '-'}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      // Stock
                      Row(
                        children: [
                          const Icon(Icons.inventory, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text(
                            'Stock: ${ad.publishedStock}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Fecha de publicación
                  Text(
                    'Publicado: ${DateFormat('dd/MM/yyyy').format(ad.publicationDate)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}