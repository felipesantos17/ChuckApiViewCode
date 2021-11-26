
import Foundation

protocol JokeCategoriesInteractorLogic {
    func fetchCategories()
}

protocol JokeCategoriesDataStore {
    var categories: [String]? { get }
}

class JokeCategoriesInteractor: JokeCategoriesInteractorLogic, JokeCategoriesDataStore {
    
    private let presenter: JokeCategoriesPresenterLogic
    private let chuckAPIGeneric: ChuckAPIGeneric?
    private let sendURLCategories: String = "categories"
    
    var categories: [String]?
    
    init(presenter: JokeCategoriesPresenterLogic, chuckAPIGeneric: ChuckAPIGeneric) {
        self.presenter = presenter
        self.chuckAPIGeneric = chuckAPIGeneric
    }
  
    func fetchCategories() {
        chuckAPIGeneric?.getAPI(urlSent: sendURLCategories, expecting: [String].self, callback: (
            { [weak self] categoriesJokeResult in
                DispatchQueue.main.async {
                    switch categoriesJokeResult {
                    case let .failure(error):
                        print(error)
                    case let .success(data):
                        self?.categories = data
                        self?.presenter.displayCategories(categories: data)
                    }
                }
            }
        ))
    }
}
