
import UIKit

protocol OneJokeViewProtocol: AnyObject {
    func actionOneMoreJoke()
}

class OneJokeView: UIView {

    // laranja - UIColor(red: 241/255, green: 90/255, blue: 36/255, alpha: 1.0)
    private let primaryColorAPP: UIColor = .black
    
    private weak var delegate: OneJokeViewProtocol?
    
    func delegate(delegate: OneJokeViewProtocol?) {
        self.delegate = delegate
    }
    
    lazy var titleSelectCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = primaryColorAPP
        
        return label
    }()
    
    lazy var oneJokeThisCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var oneMoreJokeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Want one more joke?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = primaryColorAPP
        button.addTarget(self, action: #selector(self.tappedOneMoreJokeButton), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configColorBackGround()
        self.addComponentsView()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configColorBackGround() {
        self.backgroundColor = .white
    }
    
    @objc private func tappedOneMoreJokeButton() {
        self.delegate?.actionOneMoreJoke()
    }
    
    public func setUpTitleSelectCategory(data: String) {
        self.titleSelectCategoryLabel.text = data
    }
    
    public func setUpOneJokeThisCategory(data: String) {
        self.oneJokeThisCategoryLabel.text = data
    }
    
    func addComponentsView() {
        self.addSubview(self.titleSelectCategoryLabel)
        self.addSubview(self.oneJokeThisCategoryLabel)
        self.addSubview(self.oneMoreJokeButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([

            self.titleSelectCategoryLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.titleSelectCategoryLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.titleSelectCategoryLabel.heightAnchor.constraint(equalToConstant: 50),

            self.oneJokeThisCategoryLabel.topAnchor.constraint(equalTo: self.titleSelectCategoryLabel.bottomAnchor, constant: 20),
            self.oneJokeThisCategoryLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.oneJokeThisCategoryLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            self.oneMoreJokeButton.topAnchor.constraint(equalTo: self.oneJokeThisCategoryLabel.bottomAnchor),
            self.oneMoreJokeButton.leadingAnchor.constraint(equalTo: self.oneJokeThisCategoryLabel.leadingAnchor),
            self.oneMoreJokeButton.trailingAnchor.constraint(equalTo: self.oneJokeThisCategoryLabel.trailingAnchor),
            self.oneMoreJokeButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
    }

}
