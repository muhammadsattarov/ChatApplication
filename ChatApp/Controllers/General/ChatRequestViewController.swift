//
//  ChatRequestViewController.swift
//  ChatApp
//
//  Created by user on 19/05/24.
//

import UIKit

class ChatRequestViewController: UIViewController {
    
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
        label.text = "You have opportunity to start a new chat."
        return label
    }()
    
    private let acceptButton = UIButton(title: "Accept", titleColor: .white, backgroundColor: .black,font: .laoSangamMN20(), cornerRadius: 10)
    
    private let denyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Deny", for: .normal)
        btn.setTitleColor(.redColor, for: .normal)
        btn.titleLabel?.font = .laoSangamMN20()
        btn.layer.borderWidth = 1.2
        btn.layer.borderColor = UIColor.redColor.cgColor
        btn.backgroundColor = .mainColor
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    private let chat: MChat
    
    init(chat: MChat) {
        self.chat = chat
        self.imageOfView.sd_setImage(with: URL(string: chat.friendImageStringUrl))
        self.titleLabel.text = chat.friendUserName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: WaitingChatsNavigation?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addActions()
        setConstrains()
    }
    
    private func setupViews() {
        view.backgroundColor = .mainColor
        view.addSubview(imageOfView)
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(aboutmeLabel)
    }
    
    private func addActions() {
        acceptButton.addTarget(self, action: #selector(didTapacceptButton), for: .touchUpInside)
        denyButton.addTarget(self, action: #selector(didTapDenyButton), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        acceptButton.applyGradients(cornerRadius: 10)
    }

    // MARK: - Actions
    @objc private func didTapDenyButton() {
        self.dismiss(animated: true) {
            self.delegate?.removeWaitingChat(chat: self.chat)
        }
    }
    
    @objc private func didTapacceptButton() {
        self.dismiss(animated: true) {
            self.delegate?.chatToActive(chat: self.chat)
        }
    }
}


extension ChatRequestViewController {
    private func setConstrains() {
        let buttonStack = UIStackView(arrangedSubviews: [acceptButton, denyButton],
                                      axis: .horizontal, spacing: 10)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.distribution = .fillEqually
        containerView.addSubview(buttonStack)
        
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
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 25),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24),
            
            aboutmeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            aboutmeLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 24),
            aboutmeLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24),
            
            buttonStack.topAnchor.constraint(equalTo: aboutmeLabel.bottomAnchor, constant: 10),
            buttonStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 24),
            buttonStack.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -24),
            buttonStack.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
