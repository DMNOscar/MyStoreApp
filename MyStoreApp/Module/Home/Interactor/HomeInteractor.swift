//
//  HomeInteractor.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 07/01/25.
//

class HomeInteractor: HomeInteractorProtocol {
   
    
    
    private let homeRepository: HomeRepository
    weak var homePresenter: HomePresenterProtocol?
    init(
        homerpository: HomeRepository
    ){
        self.homeRepository = homerpository
    }
    
    func getAllProductsList() {
        homeRepository.getAllProducts().done{[weak self] response in
            self?.homePresenter?.onSuccessAllProductsList(response: response)
        }.catch { error in
            
            self.homePresenter?.onFailedAllProductsList(errorResponse: error)
            
        }
    }
    
    func getCategories() {
        homeRepository.getCategories().done{[weak self] response in
            self?.homePresenter?.onSuccessGetCategories(response: response)
        }.catch { error in
            
            self.homePresenter?.onFailedGetCategories(errorResponse: error)
            
        }
    }
    
    func getProductsByCategory(name: String){
        homeRepository.getProductsByCategory(name: name).done{[weak self] response in
            self?.homePresenter?.onSuccessAllProductsList(response: response)
        }.catch { error in
            
            self.homePresenter?.onFailedAllProductsList(errorResponse: error)
            
        }
    }
}
