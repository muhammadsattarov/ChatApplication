//
//  SetupProfileViewController.swift
//  ChatApp
//
//  Created by user on 15/05/24.
//

import UIKit
import FirebaseAuth
import SDWebImage

class SetupProfileViewController: UIViewController {
    
    // MARK: - Properties
    private let headerLabel = UILabel(text: "Set up profile!", font: .avenir26())
    private let fillImageView = AddPhotoView()
    
    private let fullnameLabel = UILabel(text: "Full name", color: .gray)
    private let aboutMeLabel = UILabel(text: "About me", color: .gray)
    private let genderLabel = UILabel(text: "Gender", color: .gray)
    
    private let fullnameField = OneLineTextField(font: .avenir20())
    private let aboutMeField = OneLineTextField(font: .avenir20())
    
    private let genderSegmentedControl = UISegmentedControl(first: "Male", second: "Female")
    
    private let goToChatButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .darkColor)
    
    private let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        if let username = currentUser.displayName {
            fullnameField.text = username
        }
        
        if let userImage = currentUser.photoURL {
            fillImageView.circleImageView.sd_setImage(with: userImage)
        }
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
        view.backgroundColor = .white
        goToChatButton.addTarget(self, action: #selector(didTapGoToChatButton), for: .touchUpInside)
        fillImageView.plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
    
    // MARK: - Actions
    @objc private func didTapPlusButton() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc private func didTapGoToChatButton() {
        FirestoreService.shared.saveProfileWith(id: currentUser.uid,
                                                email: currentUser.email!,
                                                username: fullnameField.text,
                                                avatarImage: fillImageView.circleImageView.image,
                                                description: aboutMeField.text,
                                                gender: genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex)) { result in
            switch result {
            case .success(let muser):
                let tabBar = MainTabBarController(currentUser: muser)
                tabBar.modalPresentationStyle = .fullScreen
                self.present(tabBar, animated: true)
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        }
    }
    
    @objc private func didTapView() {
        view.endEditing(true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        fillImageView.circleImageView.image = image
    }
}

// MARK: - Constants
extension SetupProfileViewController {
    private func setConstrains() {
        let fullnameStack = UIStackView(arrangedSubviews: [fullnameLabel, fullnameField],
                                        axis: .vertical, spacing: 4)
        let aboutMeStack = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeField],
                                       axis: .vertical, spacing: 4)
        let genderStack = UIStackView(arrangedSubviews: [genderLabel, genderSegmentedControl],
                                      axis: .vertical, spacing: 14)
        
        goToChatButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stack = UIStackView(arrangedSubviews: [fullnameStack, aboutMeStack, genderStack, goToChatButton],
                                axis: .vertical, spacing: 30)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        fillImageView.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)
        view.addSubview(fillImageView)
        view.addSubview(stack)
        
        let topSpace: CGFloat = view.frame.height / 5.3
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topSpace),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fillImageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 40),
            fillImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: fillImageView.bottomAnchor, constant: 30),
            stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
        ])
    }
}






