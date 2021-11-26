
import UIKit

class JokeCategoryTableViewCell: UITableViewCell {
    
    static let identifier: String = "JokeCategoryTableViewCell"
 
    lazy var categoryJokeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
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
            
            self.categoryJokeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.categoryJokeLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.categoryJokeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.categoryJokeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
            
        ])
    }

}
