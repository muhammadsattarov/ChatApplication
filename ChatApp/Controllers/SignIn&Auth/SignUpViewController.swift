//
//  SignUpViewController.swift
//  ChatApp
//
//  Created by user on 14/05/24.
//

import UIKit

class SignUpViewController: UIViewController {
  
    // MARK: - Properties
    private let headerLabel = UILabel(text: "Good to see you!", font: .avenir26())
    
    
    private let emailLabel = UILabel(text: "Email", color: .gray)
    private let passwordLabel = UILabel(text: "Password", color: .gray)
    private let confirmPasswordLabel = UILabel(text: "Confirm password", color: .gray)
    private let alreadyOnbordLabel = UILabel(text: "Already onboard?")

    private let emailField = OneLineTextField(font: .avenir20())
    private let passwordField = OneLineTextField(font: .avenir20())
    private let confirmPasswordField = OneLineTextField(font: .avenir20())
    private let signUpButton = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .darkColor)
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
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
        view.backgroundColor = .white
    }
}

// MARK: - Constrains
extension SignUpViewController {
    private func setConstrains() {
        let emailStack = UIStackView(arrangedSubviews: [emailLabel, emailField],
                                     axis: .vertical, spacing: 4)
        let passwordStack = UIStackView(arrangedSubviews: [passwordLabel, passwordField],
                                        axis: .vertical, spacing: 4)
        let confirmPasswordStack = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordField],
                                               axis: .vertical, spacing: 4)
        let stackView = UIStackView(arrangedSubviews: [emailStack, passwordStack, confirmPasswordStack, signUpButton],
                                    axis: .vertical, spacing: 40)
        
      let bottomStack = UIStackView(arrangedSubviews: [alreadyOnbordLabel, loginButton],
                                    axis: .horizontal, spacing: 10)
        
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStack)
        
        let topSpace: CGFloat = view.frame.height / 5.3
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topSpace),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: topSpace/2),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            bottomStack.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: topSpace / 2),
            bottomStack.centerXAnchor.constraint(equalTo: stackView.centerXAnchor, constant: -10),
        ])
    }
}






// MARK: - SwiftUI
import SwiftUI

struct SignUpVCControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerVeiw().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerVeiw: UIViewControllerRepresentable {
        let viewController = SignUpViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
