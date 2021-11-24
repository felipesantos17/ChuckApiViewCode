
import Foundation

protocol JokeCategoriesServiceProtocol {
    func fetchCategories(success: @escaping (_ category: [String])-> Void, failure: @escaping (_ error: Error)-> Void)
}

class JokeCategoriesService {
    
    var categoriesStore: JokeCategoriesServiceProtocol
    
    init(categoriesStore: JokeCategoriesServiceProtocol) {
        self.categoriesStore = categoriesStore
    }
    
    func fetchJokeCategories(onSuccess: @escaping (_ categories: [String]) -> Void, onFailure: @escaping (_ error: Error) -> Void) {
        categoriesStore.fetchCategories { (response) in
            DispatchQueue.main.async {
                onSuccess(response)
            }
        } failure: { (error: Error) in
            DispatchQueue.main.async {
                onFailure(error)
            }
        }
    }
}
