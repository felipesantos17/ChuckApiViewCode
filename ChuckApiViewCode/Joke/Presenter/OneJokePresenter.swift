
import Foundation

protocol OneJokePresenterLogic {
    func displayOneJokeThisCategory(oneJoke: String)
}

class OneJokePresenter: OneJokePresenterLogic {
    
    weak var viewController: OneJokeViewController?
    
    func displayOneJokeThisCategory(oneJoke: String) {
        viewController?.displayOneJoke(oneJoke: oneJoke)
    }

}

