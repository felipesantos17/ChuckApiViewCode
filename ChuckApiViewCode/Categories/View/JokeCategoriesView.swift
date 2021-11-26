
import UIKit

class JokeCategoriesView: UIView {
    
    private let primaryColorAPP: UIColor = .black
    
    lazy var titleTableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = primaryColorAPP
        label.text = "Select a category to see a Chuck joke"
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(JokeCategoryTableViewCell.self, forCellReuseIdentifier: JokeCategoryTableViewCell.identifier)
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.addTableView()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configBackGround(){
        self.backgroundColor = .white
    }
    
    public func configTableViewPotocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    func addTableView() {
        self.addSubview(self.titleTableLabel)
        self.addSubview(self.tableView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            self.titleTableLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.titleTableLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.titleTableLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            self.tableView.topAnchor.constraint(equalTo: self.titleTableLabel.bottomAnchor, constant: 10),
            self.tableView.leftAnchor.constraint(equalTo: self.titleTableLabel.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.titleTableLabel.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
