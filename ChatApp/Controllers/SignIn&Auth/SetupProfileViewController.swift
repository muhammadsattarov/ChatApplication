//
//  SetupProfileViewController.swift
//  ChatApp
//
//  Created by user on 15/05/24.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    // MARK: - Properties
    private let headerLabel = UILabel(text: "Set up profile!", font: .avenir26())
    private let fillImageView = AddPhotoView()
    
    private let fullnameLabel = UILabel(text: "Full name", color: .gray)
    private let aboutMeLabel = UILabel(text: "About me", color: .gray)
    private let genderLabel = UILabel(text: "Gender", color: .gray)
    
    private let fullnameField = OneLineTextField(font: .avenir20())
    private let aboutMeField = OneLineTextField(font: .avenir20())
    
    private let segmentedControl = UISegmentedControl(first: "Male", second: "Female")
    
    private let goToChatButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .darkColor)
    
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

// MARK: - Constants
extension SetupProfileViewController {
    private func setConstrains() {
        let fullnameStack = UIStackView(arrangedSubviews: [fullnameLabel, fullnameField],
                                        axis: .vertical, spacing: 4)
        let aboutMeStack = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeField],
                                       axis: .vertical, spacing: 4)
        let genderStack = UIStackView(arrangedSubviews: [genderLabel, segmentedControl],
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







// MARK: - SwiftUI
import SwiftUI

struct SetupVCControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerVeiw().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerVeiw: UIViewControllerRepresentable {
        let viewController = SetupProfileViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
