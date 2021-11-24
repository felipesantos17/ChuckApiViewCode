import Foundation

protocol JokeCategoriesPresenterLogic {
    func displayCategories(categories: [String])
    func displayErrorMessage(error: Error)
}

class JokeCategoriesPresenter: JokeCategoriesPresenterLogic {
    
    weak var viewController: JokeCategoriesDisplayLogic?
    
    func displayCategories(categories: [String]) {
        viewController?.displayCategories(categories: categories)
    }
    
    func displayErrorMessage(error: Error) {
        viewController?.displayErrorMessage(error: error)
    }
    
}
