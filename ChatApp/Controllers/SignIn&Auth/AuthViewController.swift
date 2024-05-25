//
//  ViewController.swift
//  ChatApp
//
//  Created by user on 14/05/24.
//

import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - Properties
    private let logoImage = UIImageView(image: #imageLiteral(resourceName: "Logo"), contentMode: .scaleAspectFit)
    
    private let googleLabel = UILabel(text: "Get started with")
    private let emailLabel = UILabel(text: "Or sign up with")
    private let onboardingLabel = UILabel(text: "Already onboard?")
    
    private let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    private let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .darkColor)
    private let loginButton = UIButton(title: "Login", titleColor: .redColor, backgroundColor: .white, isShadow: true)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
    }

    private func setupViews() {
        googleButton.customizedGoogleButton()
        view.backgroundColor = .white
    }

}

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
