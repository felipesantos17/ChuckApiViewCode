
import UIKit

class JokeCategoriesViewController: UIViewController {
    
    var categories: [String] = ["Carregando..."]
    
    private let pathCategories: String = "categories"

    var jokeCategoriesView: JokeCategoriesView?
    
    override func loadView() {
        self.jokeCategoriesView = JokeCategoriesView()
        self.view = jokeCategoriesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jokeCategoriesView?.configTableViewPotocols(delegate: self, dataSource: self)
        self.fetch()
    }
    
    func fetch() {
        ChuckAPI.getAPI(urlSent: pathCategories, expecting: [String].self, callback: (
            { [weak self] categoriesJokeResult in
                DispatchQueue.main.async {
                    switch categoriesJokeResult {
                    case let .failure(error):
                        print(error)
                    case let .success(data):
                        print(data)
                        self?.categories = data
                        self?.jokeCategoriesView?.tableView.reloadData()
                    }
                }
                
            }
        ))
    }

    
}

extension JokeCategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("valor é \(categories[indexPath.row])")
        let viewController: OneJokeViewController = OneJokeViewController(selectedCategory: categories[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
        
        self.jokeCategoriesView?.tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension JokeCategoriesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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
