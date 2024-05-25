//
//  WaitingChatCell.swift
//  ChatApp
//
//  Created by user on 18/05/24.
//

import UIKit
import SDWebImage

class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseId: String = "WaitingChatCell"
    
    private let imageOfView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .lightGray
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with model: U) where U : Hashable {
        guard let chat: MChat = model as? MChat else { return }
        imageOfView.sd_setImage(with: URL(string: chat.friendImageStringUrl))
    }
    
    
    private func setup() {
        self.backgroundColor = .clear
        contentView.addSubview(imageOfView)
        contentView.layer.cornerRadius = 4
        contentView.clipsToBounds = true
    }
}


extension WaitingChatCell {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            imageOfView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageOfView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageOfView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageOfView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
