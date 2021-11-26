
import Foundation

protocol OneJokePresenterLogic {
    func displayOneJokeThisCategory(oneJokeComplete: OneJoke)
}

class OneJokePresenter: OneJokePresenterLogic {
    
    weak var viewController: OneJokeViewController?
    
    private var oneJoke: String = "Empty"
    
    func displayOneJokeThisCategory(oneJokeComplete: OneJoke) {
        self.oneJoke = oneJokeComplete.value
        viewController?.displayOneJoke(oneJoke: self.oneJoke)
    }

}

