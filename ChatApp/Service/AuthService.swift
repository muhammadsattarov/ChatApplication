//
//  AuthService.swift
//  ChatApp
//
//  Created by user on 19/05/24.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    private let auth = Auth.auth()
    
    // Login user func
    public func login(email: String?,
                      password: String?,
                      completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let email = email, let password = password else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        auth.signIn(withEmail: email, password: password) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    // Create new user func
    public func register(email: String?,
                         password: String?,
                         confirmpassword: String?,
                         completion: @escaping (Result<User, Error>) -> Void) {
        
        guard Validators.isValid(email: email,
                                 password: password,
                                 confirmPassword: confirmpassword) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        guard password?.lowercased() == confirmpassword?.lowercased() else {
            completion(.failure(AuthError.passwordNotMatched))
            return
        }
        
        guard Validators.isValidEmail(email!) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        
        auth.createUser(withEmail: email!, password: password!) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    // Create google login
    func loginWithGoogle(viewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [unowned self] result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            auth.signIn(with: credential) { result, error in
                guard let result = result else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(result.user))
            }
        }
    }
}


