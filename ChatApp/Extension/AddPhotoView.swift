//
//  AddPhotoView.swift
//  ChatApp
//
//  Created by user on 15/05/24.
//

import UIKit

class AddPhotoView: UIView {
    
    let circleImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "avatar")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        return image
    }()
    
    let plusButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        let img = #imageLiteral(resourceName: "plus")
        btn.setImage(img, for: .normal)
        btn.tintColor = .darkColor
        return btn
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(circleImageView)
        addSubview(plusButton)
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleImageView.layer.masksToBounds = true
        circleImageView.layer.cornerRadius = circleImageView.frame.width/2
    }
    
    private func setConstrains() {
        NSLayoutConstraint.activate([
            circleImageView.topAnchor.constraint(equalTo: self.topAnchor),
            circleImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            circleImageView.widthAnchor.constraint(equalToConstant: 100),
            circleImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            plusButton.leftAnchor.constraint(equalTo: circleImageView.rightAnchor, constant: 16),
            plusButton.centerYAnchor.constraint(equalTo: circleImageView.centerYAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            plusButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        self.bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: plusButton.rightAnchor).isActive = true
    }
}
