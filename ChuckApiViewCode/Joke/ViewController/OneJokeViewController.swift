
import UIKit

protocol OneJokeDisplayLogic {
    func displayOneJoke(oneJoke: String)
}

class OneJokeViewController: UIViewController {
    
    private let selectedCategory: String
    
    private var titleCategorySelected: String = "The selected category was "
    
    private let interactor: OneJokeInteractorLogic
    
    var oneJokeView: OneJokeView?
    
    override func loadView() {
        self.oneJokeView = OneJokeView()
        self.view = oneJokeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.oneJokeView?.delegate(delegate: self)
        self.oneJokeView?.setUpTitleSelectCategory(data: titleCategorySelected + selectedCategory)
    }
    
    init(selectedCategory: String, interactor: OneJokeInteractorLogic) {
        self.selectedCategory = selectedCategory
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.fetchOneJoke(category: selectedCategory)
    }
    
}

extension OneJokeViewController: OneJokeViewProtocol {
    func actionOneMoreJoke() {
        interactor.fetchOneJoke(category: selectedCategory)
    }
}

extension OneJokeViewController: OneJokeDisplayLogic {
    
    func displayOneJoke(oneJoke: String) {
        self.oneJokeView?.setUpOneJokeThisCategory(data: oneJoke)
    }
 
}

