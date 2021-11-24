
import Foundation

protocol JokeCategoriesInteractorLogic {
    func fetchCategories()
}

protocol JokeCategoriesDataStore {
    var categories: [String]? { get }
}

class JokeCategoriesInteractor: JokeCategoriesInteractorLogic, JokeCategoriesDataStore {
    
    private let presenter: JokeCategoriesPresenterLogic
    private let jokeCategoriesService: JokeCategoriesService
    
    
    var categories: [String]?
    
    init(presenter: JokeCategoriesPresenterLogic, jokeCategoriesService: JokeCategoriesService) {
        self.presenter = presenter
        self.jokeCategoriesService = jokeCategoriesService
    }
    
    func fetchCategories() {
        jokeCategoriesService.fetchJokeCategories { [weak self] (categories: [String]) in
            guard let self = self else {
                return
            }
            self.categories = categories
            self.presenter.displayCategories(categories: categories)
        } onFailure: { [weak self] (error: Error) in
            guard let self = self else {
                return
            }
            
            self.presenter.displayErrorMessage(error: error)
        }
    }
}
