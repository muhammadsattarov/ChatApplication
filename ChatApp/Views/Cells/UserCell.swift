//
//  UserCell.swift
//  ChatApp
//
//  Created by user on 18/05/24.
//

import UIKit

class UserCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseId: String = "UserCell"
    
    private let imageOfView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.backgroundColor = .lightGray
        return image
    }()
    
    private let usernameLabel = UILabel(text: "User", font: .laoSangamMN20())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConstrains()
    }
    
    private func setup() {
        self.backgroundColor = .clear
        self.layer.shadowColor = #colorLiteral(red: 0.787740171, green: 0.787740171, blue: 0.787740171, alpha: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        
        contentView.addSubview(imageOfView)
        contentView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with model: U) where U : Hashable {
        guard let user: MUser = model as? MUser else { return }
        usernameLabel.text = user.username
        imageOfView.sd_setImage(with: URL(string: user.avatarStringURL))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageOfView.image = nil
        usernameLabel.text = nil
    }
}

extension UserCell {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            imageOfView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageOfView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageOfView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageOfView.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: imageOfView.bottomAnchor),
            usernameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            usernameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            usernameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
