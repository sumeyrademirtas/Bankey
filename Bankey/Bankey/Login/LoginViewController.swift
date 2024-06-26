//
//  ViewController.swift
//  Bankey
//
//  Created by Sümeyra Demirtaş on 26.06.2024.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
    }
    
}

extension LoginViewController {
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(loginView)
        
        //This sets isActive to true for all constraints contained within
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
    }
}

