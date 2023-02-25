//
//  LoginVC.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 8.02.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        emailTextField.text = "sevval@gmail.com"
        passwordTextField.text = "121212"
        configureUI()
    }
    
    private func configureUI() {
        loginView.layer.borderColor = UIColor(named: "onboardingCornerColor")?.cgColor
        loginView.layer.borderWidth = 2
        loginView.layer.cornerRadius = 20
        
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.5).cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.clipsToBounds = true
        
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.5).cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.clipsToBounds = true
        
        loginButton.layer.cornerRadius = 15
    }
    
    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Hata", messageInput: "Email ya da şifre hatalı. Exp: \(String(describing: error?.localizedDescription))")
                }else{
                    self.performSegue(withIdentifier: "toFoodsVC", sender: nil)
                }
            }
        }else{
            self.makeAlert(titleInput: "Hata", messageInput: "Email ve şifre gerekli.")
        }
        
    }
    
    private func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
