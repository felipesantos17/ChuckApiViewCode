import Foundation

protocol JokeCategoriesPresenterLogic {
    func displayCategories(categories: [String])
}

class JokeCategoriesPresenter: JokeCategoriesPresenterLogic {
    
    weak var viewController: JokeCategoriesDisplayLogic?
    
    func displayCategories(categories: [String]) {
        viewController?.displayCategories(categories: categories)
    }
    
}
