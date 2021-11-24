
import UIKit

class JokeCategoryTableViewCell: UITableViewCell {
    
    private let primaryColorAPP: UIColor = .black
    
    static let identifier: String = "JokeCategoryTableViewCell"
    
    lazy var categoryJokeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = self.primaryColorAPP
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubView()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        self.contentView.addSubview(self.categoryJokeLabel)
    }
    
    public func setUpCell(data: String) {
        self.categoryJokeLabel.text = data.uppercased()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            self.categoryJokeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.categoryJokeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
        ])
    }

}
