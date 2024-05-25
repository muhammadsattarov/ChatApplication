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
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.redColor, for: .normal)
        btn.titleLabel?.font = .avenir20()
        return btn
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
    }
    
    private func setupViews() {
        googleButton.customizedGoogleButton()
        view.backgroundColor = .systemBackground
    }
}

// MARK: -
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
        
        let topSpace: CGFloat = view.frame.height / 5.3
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
