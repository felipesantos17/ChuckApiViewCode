
import UIKit

class OneJokeViewController: UIViewController {
    
    private let selectedCategory: String!
    
    private var titleCategorySelected: String = "The selected category was "
    
    var oneJokeView: OneJokeView?
    
    override func loadView() {
        self.oneJokeView = OneJokeView()
        self.view = oneJokeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.oneJokeView?.delegate(delegate: self)
        self.oneJokeView?.setUpTitleSelectCategory(data: titleCategorySelected + selectedCategory)
        self.fethJoke()
    }
    
    init(selectedCategory: String) {
        self.selectedCategory = selectedCategory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func newURL(name: String) -> String {
        let newSentURL = "random?category=\(name)"
        return newSentURL
    }
    
    func fethJoke() {
        
        let sentCategorySelectedURL = newURL(name: self.selectedCategory)
        
        ChuckAPI.getAPI(urlSent: sentCategorySelectedURL, expecting: OneJoke.self, callback: (
            { [weak self] categoriesJokeResult in
                DispatchQueue.main.async {
                    switch categoriesJokeResult {
                    case let .failure(error):
                        print(error)
                    case let .success(data):
                        self?.oneJokeView?.setUpOneJokeThisCategory(data: data.value)
                    }
                }
            }
        ))
    }
    
}

extension OneJokeViewController: OneJokeViewProtocol {
    func actionOneMoreJoke() {
        fethJoke()
    }

}
