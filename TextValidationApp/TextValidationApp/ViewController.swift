//
//  ViewController.swift
//  TextValidationApp
//
//  Created by Deseret Baker on 3/9/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var errorSuccessMessageLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        do {
            try validateCredentials()
            errorSuccessMessageLabel.text = "Success"
        } catch let error as ValidationError {
            switch error {
            case .passwordTooShort: errorSuccessMessageLabel.text = "Password is to short"
            case .passwordSpecialCharacterMissing: errorSuccessMessageLabel.text = "one special character needed"
            }
        } catch {
            errorSuccessMessageLabel.text = "Unknown error occurred"
        }
    }
    func validateCredentials() throws {
        guard let password = passwordTextField.text, password.count >= 8 else {
            throw ValidationError.passwordTooShort
        }
        if !password.containsSpecialCharacters() {
            throw ValidationError.passwordSpecialCharacterMissing
        }
    }
        enum ValidationError: Error {
            case passwordTooShort
            case passwordSpecialCharacterMissing
        }
    }
        
        
        extension String {
            func containsSpecialCharacters() -> Bool {
                let specialCharacters = CharacterSet(charactersIn: "@$!%*#?&")
                return rangeOfCharacter(from: specialCharacters) != nil
            }
            
        }
        
        
    
