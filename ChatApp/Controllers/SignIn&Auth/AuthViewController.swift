//
//  ViewController.swift
//  ChatApp
//
//  Created by user on 14/05/24.
//

import UIKit
import GoogleSignIn

class AuthViewController: UIViewController {
    
    // MARK: - Properties
    private let logoImage = UIImageView(image: #imageLiteral(resourceName: "Logo"), contentMode: .scaleAspectFit)
    
    private let googleLabel = UILabel(text: "Get started with")
    private let emailLabel = UILabel(text: "Or sign up with")
    private let onboardingLabel = UILabel(text: "Already onboard?")
    
    private let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    private let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .darkColor)
    private let loginButton = UIButton(title: "Login", titleColor: .redColor, backgroundColor: .white, isShadow: true)
    
    let signupVC = SignUpViewController()
    let loginVC = LoginViewController()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
    }

    private func setupViews() {
        googleButton.customizedGoogleButton()
        view.backgroundColor = .white
        loginVC.delegate = self
        signupVC.delegate = self
        emailButton.addTarget(self, action: #selector(didTapEmailButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTaploginButton), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(didTapgoogleButton), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func didTapEmailButton() {
        present(signupVC, animated: true)
    }
    
    @objc private func didTaploginButton() {
        present(loginVC, animated: true)
    }
    
    @objc private func didTapgoogleButton() {
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
}

// MARK: - Constrains
extension AuthViewController {
    private func setConstrains() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        let googleView = ButtonFormVeiw(label: googleLabel, button: googleButton)
        let emailView = ButtonFormVeiw(label: emailLabel, button: emailButton)
        let loginView = ButtonFormVeiw(label: onboardingLabel, button: loginButton)
        
     let stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView],
                                 axis: .vertical, spacing: 40)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImage)
        view.addSubview(stackView)
        let topSpace: CGFloat = view.frame.height / 5.3
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: topSpace),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: topSpace/2),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)
        ])
    }
}

// MARK: - AuthNavigatingDelegate
extension AuthViewController: AuthNavigationDelegate {
    func toSignUpVC() {
        present(signupVC, animated: true)
    }
    
    func toLoginVC() {
        present(loginVC, animated: true)
    }
}


// MARK: -
extension AuthViewController {
    
}






// MARK: - SwiftUI
import SwiftUI

struct AuthViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerVeiw().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerVeiw: UIViewControllerRepresentable {
        let viewController = AuthViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
