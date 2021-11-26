
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
    
    var oldJoke: OneJoke?
    
    var sendCategorySelected: String?
    
    init(presenter: OneJokePresenterLogic, chuckAPIGeneric: ChuckAPIGeneric) {
        self.presenter = presenter
        self.chuckAPIGeneric = chuckAPIGeneric
    }
    
    func pathOneJokeCategoryAPI(category: String) -> String {
        let newURL = "random?category=" + category
        
        return newURL
    }
    
    
    func fetchOneJoke(category: String) {
        
        self.sendCategorySelected = category
        
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
                        self?.sameJoke()
                        self?.presenter.displayOneJokeThisCategory(oneJokeComplete: data)
                    }
                }
            }
        ))
        
    }
    
    var maxCount: Int = 3
    var currentIndex: Int = 0
    
    func sameJoke() {
    
        guard oldJoke?.id == oneJoke?.id && currentIndex < maxCount else {
            oldJoke = oneJoke
            currentIndex = 0
            return
        }
        
        print("Mesma piada, chamei o sameJoke")
        print(currentIndex)
        fetchOneJoke(category: self.sendCategorySelected ?? "")
        currentIndex += 1
    }
}
