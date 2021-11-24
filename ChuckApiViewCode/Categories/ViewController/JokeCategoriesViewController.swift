
import UIKit

protocol JokeCategoriesDisplayLogic: AnyObject {
    func displayCategories(categories: [String])
    func displayErrorMessage(error: Error)
}

class JokeCategoriesViewController: UIViewController {
    
    var jokeCategoriesView: JokeCategoriesView?
    
    var categories: [String] = ["Carregando..."]
    
    private let interactor: JokeCategoriesInteractorLogic
    
    init(interactor: JokeCategoriesInteractorLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.jokeCategoriesView = JokeCategoriesView()
        self.view = jokeCategoriesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jokeCategoriesView?.configTableViewPotocols(delegate: self, dataSource: self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.fetchCategories()
    }
}

extension JokeCategoriesViewController: JokeCategoriesDisplayLogic {
    
    func displayCategories(categories: [String]) {
        self.categories = categories
        self.jokeCategoriesView?.tableView.reloadData()
    }
    
    func displayErrorMessage(error: Error) {
        print("Aconteceu um erro")
    }
    
}


extension JokeCategoriesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK:- Scene One Joke ViewController
        
        func createOneJokeViewController() -> OneJokeViewController {
            let presenter = OneJokePresenter()

            let interactor = OneJokeInteractor(
                presenter: presenter,
                chuckAPIGeneric: ChuckAPIGeneric()
            )
            
            let viewController = OneJokeViewController(
                selectedCategory: categories[indexPath.row],
                interactor: interactor
            )
            
            presenter.viewController = viewController
            
            return viewController
        }
        
        let viewController = createOneJokeViewController()
        self.navigationController?.pushViewController(viewController, animated: true)

        self.jokeCategoriesView?.tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension JokeCategoriesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JokeCategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: JokeCategoryTableViewCell.identifier, for: indexPath) as! JokeCategoryTableViewCell

        let category = categories[indexPath.row]
        cell.setUpCell(data: category)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
