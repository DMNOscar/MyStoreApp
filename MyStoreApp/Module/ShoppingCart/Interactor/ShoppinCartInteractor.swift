//
//  ShoppinCartInteractor.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 13/01/25.
//

class ShoppinCartInteractor: ShoppinCartInteractorProtocol{
    
    weak var presenter: ShoppingCartPresenterProtocol?
    let repository: ShoppingCartRepository?
    
    init(repository: ShoppingCartRepository) {
        self.repository = repository
    }
    
    
    func getShoppinCart(){
        repository?.getShoppinCart { result in
            switch result {
            case .success(let products):
                print("Productos obtenidos: \(products)")
                self.presenter?.onSuccessGetShoppinCart(response: products)
            case .failure(let error):
                print("Error al obtener los productos: \(error.localizedDescription)")
                self.presenter?.onFailedGetShoppinCart(errorResponse: error)
            }
        }
    }
    
    func deleteProduct(by id: Int) {
        repository?.deleteProduct(by: id) { result in
            switch result {
            case .success:
                print("Producto eliminado con éxito")
                self.presenter?.onSuccessDeleteProduct()
            case .failure(let error):
                print("Error al eliminar el producto: \(error.localizedDescription)")
                self.presenter?.onFailedDeleteProduct(errorResponse: error)
            }
        }
    }
    
    func updateProduct(id: Int, newCount: Int) {
        
        repository?.updateProduct(id: id, newCount: newCount) { result in
            switch result {
            case .success:
                print("Producto actualizado con éxito")
                self.presenter?.onSuccessUpdateProduct()
            case .failure(let error):
                print("Error al actualizar el producto: \(error.localizedDescription)")
                self.presenter?.onFailedUpdateProduct(errorResponse: error)
            }
        }
    }
    
}
