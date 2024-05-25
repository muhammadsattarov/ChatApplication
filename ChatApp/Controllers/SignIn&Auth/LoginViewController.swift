//
//  LoginViewController.swift
//  ChatApp
//
//  Created by user on 15/05/24.
//

import UIKit


class LoginViewController: UIViewController {
    
    // MARK: - Properties
    // Labels
    private let headerLabel = UILabel(text: "Welcome Back!", font: .avenir26())
    private let loginWithLabel = UILabel(text: "Login with")
    private let orLabel = UILabel(text: "or")
    private let emailLabel = UILabel(text: "Email", color: .gray)
    private let passwordLabel = UILabel(text: "Password", color: .gray)
    private let bottomLabel = UILabel(text: "Need an account")
    
    // Text fields
    private let emailField = OneLineTextField(font: .avenir20())
    private let passwordField = OneLineTextField(font: .avenir20())
    
    // Buttons
    private let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    private let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .black)
    
    private let signUpButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.redColor, for: .normal)
        btn.titleLabel?.font = .avenir20()
        return btn
    }()
    
    weak var delegate: AuthNavigationDelegate?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
        setupAddActions()
    }
    
    private func setupViews() {
        googleButton.customizedGoogleButton()
        view.backgroundColor = .systemBackground
    }
    
    private func setupAddActions() {
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
    
    // MARK: - Actions
    @objc private func didTapLoginButton() {
        AuthService.shared.login(email: emailField.text,
                                 password: passwordField.text) { result in
            switch result {
            case .success(let user):
                FirestoreService.shared.getUserData(user: user) { result in
                    switch result {
                    case .success(let muser):
                        let tabBar = MainTabBarController(currentUser: muser)
                        tabBar.modalPresentationStyle = .fullScreen
                        let vc = tabBar
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    case .failure(_):
                        self.present(SetupProfileViewController(currentUser: user), animated: true)
                    }
                }
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        }
        
    }
    
    @objc private func didTapSignUpButton() {
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }
    
    @objc private func didTapGoogleButton() {
        AuthService.shared.loginWithGoogle(viewController: self) { result in
            switch result {
            case .success(let user):
                FirestoreService.shared.getUserData(user: user) { result in
                    switch result {
                    case .success(let muser):
                        let tabbar = MainTabBarController(currentUser: muser)
                        tabbar.modalPresentationStyle = .fullScreen
                        self.present(tabbar, animated: true)
                    case .failure(let error):
                        let vc = SetupProfileViewController(currentUser: user)
                        self.present(vc, animated: true)
                    }
                }
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        }
    }
    
    @objc private func didTapView() {
        view.endEditing(true)
    }
}

// MARK: - Constrains
extension LoginViewController {
    private func setConstrains() {
        let googleButtonForm = ButtonFormVeiw(label: loginWithLabel, button: googleButton)
        let emailStack = UIStackView(arrangedSubviews: [emailLabel, emailField],
                                     axis: .vertical, spacing: 4)
        let passwordStack = UIStackView(arrangedSubviews: [passwordLabel, passwordField],
                                        axis: .vertical, spacing: 4)
        let bottomStack = UIStackView(arrangedSubviews: [bottomLabel, signUpButton],
                                      axis: .horizontal, spacing: 10)
        let stack = UIStackView(arrangedSubviews: [googleButtonForm, orLabel, emailStack, passwordStack, loginButton],
                                axis: .vertical, spacing: 30)
        
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerLabel)
        view.addSubview(stack)
        view.addSubview(bottomStack)
        
        let topSpace: CGFloat = view.frame.height / 8
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topSpace),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: topSpace/3),
            stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            bottomStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: topSpace/3),
            bottomStack.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
        ])
    }
}





// MARK: - SwiftUI
import SwiftUI

struct LoginVCControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerVeiw().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerVeiw: UIViewControllerRepresentable {
        let viewController = LoginViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
