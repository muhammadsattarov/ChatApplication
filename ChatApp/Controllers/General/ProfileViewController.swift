//
//  ProfileViewController.swift
//  ChatApp
//
//  Created by user on 19/05/24.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    private let imageOfView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .lightGray
        image.image = #imageLiteral(resourceName: "person5")
        return image
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .mainColor
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Anna Braun"
        return label
    }()
    
    private let aboutmeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 3
        label.text = "Anna, you are so beutiful woman in the world. Are you know?"
        return label
    }()
    
    private let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        btn.tintColor = .white
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 4
        return btn
    }()
    
    private let myTextField = InsertableTextField()
    
    private let user: MUser
    
    init(user: MUser) {
        self.user = user
        imageOfView.sd_setImage(with: URL(string: user.avatarStringURL))
        titleLabel.text = user.username
        aboutmeLabel.text = user.description
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
    }
    
    private func setupViews() {
        view.addSubview(imageOfView)
        view.addSubview(containerView)
        view.addSubview(backButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(aboutmeLabel)
        containerView.addSubview(myTextField)
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        if let button = myTextField.rightView as? UIButton {
            button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func sendMessage() {
        guard let message = myTextField.text, message != "" else { return }
        self.dismiss(animated: true) {
            FirestoreService.shared.createWaitingChats(message: message,
                                                       receiver: self.user) { result in
                switch result {
                case .success:
                    UIApplication.getTopViewController()?.showAlert(with: "Success!",
                                                                    and: "Your message has been sent to \(self.user.username)")
                case .failure(let error):
                    UIApplication.getTopViewController()?.showAlert(with: "Error!",
                                                                    and: error.localizedDescription)
                }
            }
        }
    }
    
    @objc private func didTapBack() {
        dismiss(animated: true)
    }
}

// MARK: - Constrains
extension ProfileViewController {
    private func setConstrains() {
        let containerSize: CGFloat = view.frame.height/4.13
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerView.heightAnchor.constraint(equalToConstant: containerSize)
        ])
        
        NSLayoutConstraint.activate([
            imageOfView.topAnchor.constraint(equalTo: view.topAnchor),
            imageOfView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageOfView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageOfView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 25),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24),
            
            aboutmeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            aboutmeLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 24),
            aboutmeLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24),
            
            myTextField.topAnchor.constraint(equalTo: aboutmeLabel.bottomAnchor, constant: 10),
            myTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 24),
            myTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24),
            myTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
