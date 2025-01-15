//
//  SingleProductInteractor.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 10/01/25.
//

class SingleProductInteractor: SingleProductInteractorProtocol{
    
    weak var presenter: SingleProductPresenterProtocol?
    let repository: ShoppingCartRepository?
    
    init(repository: ShoppingCartRepository) {
        self.repository = repository
    }
    
    
    func saveProduct(product: ProductElement, amoutProduct: Int) {
        repository?.saveProduct(product: product, amountProduct: amoutProduct) { result in
            switch result {
            case .success:
                print("Producto guardado con éxito")
                self.presenter?.onSuccessSaveProduct()
            case .failure(let error):
                print("Error al guardar el producto: \(error.localizedDescription)")
                self.presenter?.onFailedSaveProduct(errorResponse: error)
            }
        }
    }
    
}
