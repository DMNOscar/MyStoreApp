//
//  ShoppingCartAPI.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 13/01/25.
//

import CoreData

public class ShoppingCartRepository {
    private let context = CoreDataManager.shared.context

    // Guardar un producto
    func saveProduct(product: ProductElement, amountProduct: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", product.id ?? 0) // Busca por el ID del producto

        do {
            let results = try context.fetch(fetchRequest)

            if let existingProduct = results.first {
                // Si el producto ya existe, actualiza la cantidad
                existingProduct.count = Int64(amountProduct) // Incrementa la cantidad
            } else {
                // Si el producto no existe, crea uno nuevo
                let newProduct = Product(context: context)
                newProduct.id = Int64(product.id ?? 0)
                newProduct.title = product.title
                newProduct.price = product.price ?? 0.0
                newProduct.productDescription = product.description ?? ""
                newProduct.category = product.category?.rawValue
                newProduct.image = product.image
                newProduct.rate = product.rating?.rate ?? 0.0
                newProduct.count = Int64(amountProduct)
            }

            // Guarda los cambios en el contexto
            try context.save()
            completion(.success(())) // Notifica éxito
        } catch {
            completion(.failure(error)) // Notifica el error
        }
    }


    // Obtener productos
    func getShoppinCart(completion: @escaping (Result<[Product], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            let products = try context.fetch(fetchRequest)
            completion(.success(products)) // Notifica éxito y pasa los productos
        } catch {
            completion(.failure(error)) // Notifica el error
        }
    }

    // Eliminar un producto
    func deleteProduct(by id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            if let product = try context.fetch(fetchRequest).first {
                context.delete(product)
                try context.save()
                completion(.success(())) // Notifica éxito
            } else {
                completion(.failure(NSError(domain: "ProductRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "Producto no encontrado"])))
            }
        } catch {
            completion(.failure(error)) // Notifica el error
        }
    }

    // Actualizar un producto
    func updateProduct(id: Int, newCount: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            if let product = try context.fetch(fetchRequest).first {
                product.count = Int64(newCount)
                try context.save()
                completion(.success(())) // Notifica éxito
            } else {
                completion(.failure(NSError(domain: "ProductRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "Producto no encontrado"])))
            }
        } catch {
            completion(.failure(error)) // Notifica el error
        }
    }
}
