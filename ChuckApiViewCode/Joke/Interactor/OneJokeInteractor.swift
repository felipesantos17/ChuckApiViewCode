
import Foundation

protocol OneJokeInteractorLogic {
    func fetchOneJoke(category: String)
}

protocol OneJokeDataStore {
    var oneJoke: OneJoke? { get }
}

class OneJokeInteractor: OneJokeInteractorLogic, OneJokeDataStore {
    
    private let presenter: OneJokePresenterLogic
    private let chuckAPIGeneric: ChuckAPIGeneric?
    
    var oneJoke: OneJoke?
    
    init(presenter: OneJokePresenterLogic, chuckAPIGeneric: ChuckAPIGeneric) {
        self.presenter = presenter
        self.chuckAPIGeneric = chuckAPIGeneric
    }
    
    func pathOneJokeCategoryAPI(category: String) -> String {
        let newURL = "random?category=" + category
        
        return newURL
    }
    
    
    func fetchOneJoke(category: String) {
        
        let sendCategorySelectedURL = pathOneJokeCategoryAPI(category: category)

        chuckAPIGeneric?.getAPI(urlSent: sendCategorySelectedURL, expecting: OneJoke.self, callback: (
            { [weak self] categoriesJokeResult in
                DispatchQueue.main.async {
                    switch categoriesJokeResult {
                    case let .failure(error):
                        print(error)
                    case let .success(data):
                        print(data)
                        self?.oneJoke = data
                        self?.presenter.displayOneJokeThisCategory(oneJoke: self?.oneJoke?.value ?? "Não veio a piada")
                    }
                }
            }
        ))
    }
}
