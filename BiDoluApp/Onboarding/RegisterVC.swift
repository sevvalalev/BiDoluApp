//
//  RegisterVC.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 8.02.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class RegisterVC: UIViewController {

    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var registerButton: UIButton!
    @IBOutlet private var registerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    private func configureUI() {
        emailTextField.layer.cornerRadius = 15
        passwordTextField.layer.cornerRadius = 15
        emailTextField.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.5).cgColor
        passwordTextField.layer.borderColor = UIColor.systemRed.withAlphaComponent(0.5).cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.clipsToBounds = true
        passwordTextField.layer.borderWidth = 1
        passwordTextField.clipsToBounds = true
        registerView.layer.cornerRadius = 20
        
        registerButton.layer.cornerRadius = 15
    }
    
    @IBAction private func registerButtonTapped(_ sender: UIButton) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Bir hata mevcut tekrar giriş yapmayı deneyin.")
                }else{
                    self.performSegue(withIdentifier: "toFoodsVC", sender: nil)
                }
            }
        }else{
            makeAlert(titleInput: "Hata", messageInput: "Kullanıcı adı ya da şifre hatalı.")
        }
    }
    
    private func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
