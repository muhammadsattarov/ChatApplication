//
//  ActiveChatCell.swift
//  ChatApp
//
//  Created by user on 18/05/24.
//

import UIKit

// MARK: - UICollectionViewCell
class ActiveChatCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "ActiveChatCell"
    
    private let imageOfView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .laoSangamMN20()
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .laoSangamMN18()
        return label
    }()
    
    private let gradient = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.8309458494, green: 0.7057176232, blue: 0.9536159635, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        gradient.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageOfView)
        contentView.addSubview(gradient)
        self.backgroundColor = .clear
        contentView.layer.cornerRadius = 4
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
    }
    
    
    func configure<U>(with model: U) where U : Hashable {
        guard let user: MChat = model as? MChat else { return }
        imageOfView.sd_setImage(with: URL(string: user.friendImageStringUrl))
        titleLabel.text = user.friendUserName
        messageLabel.text = user.lastMessage
    }
    
    
}

// MARK: - Constrains
extension ActiveChatCell {
    private func setConstrains() {
        let stack = UIStackView(arrangedSubviews: [titleLabel, messageLabel],
                                axis: .vertical, spacing: 4)
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        
        let imageSize: CGFloat = contentView.frame.height
        NSLayoutConstraint.activate([
            imageOfView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageOfView.widthAnchor.constraint(equalToConstant: imageSize),
            imageOfView.heightAnchor.constraint(equalToConstant: imageSize)
        ])
        
        NSLayoutConstraint.activate([
            gradient.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            gradient.heightAnchor.constraint(equalToConstant: imageSize),
            gradient.widthAnchor.constraint(equalToConstant: 8)
        ])
        
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: imageOfView.rightAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: gradient.leftAnchor, constant: 10),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
