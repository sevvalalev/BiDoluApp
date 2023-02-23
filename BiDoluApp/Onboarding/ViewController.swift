//
//  ViewController.swift
//  BiDoluApp
//
//  Created by Sevval Alev on 8.02.2023.
//

import UIKit
import Lottie
import FirebaseAuth

class ViewController: UIViewController {    
    
    @IBOutlet private var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.backgroundColor = .systemRed
        loginButton.layer.cornerRadius = 15
        
         /*
        appNameView.contentMode = .scaleAspectFit
        appNameView.loopMode = .loop
        appNameView.animationSpeed = 0.5
        appNameView.play() */
    }


    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toLoginVC", sender: nil)
    }
    
    
    @IBAction private func registerButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toRegisterVC", sender: nil)
    }
}

