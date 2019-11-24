//
//  FinalViewController.swift
//  BottomNavParWithCard
//
//  Created by Martin Kim on 11/3/19.
//  Copyright © 2019 Martin Kim. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor(red: 0x1D/255, green: 0xE5/255, blue: 0xE2/255, alpha: 1).cgColor, UIColor(red: 0xB5/255, green: 0x88/255, blue: 0xF7/255, alpha: 1).cgColor, UIColor(red: 0x1D/255, green: 0xE5/255, blue: 0xE2/255, alpha: 1).cgColor]
        layer.locations = [0, 0.5, 1]
        layer.startPoint = CGPoint(x:0.5,y: 0)
        layer.endPoint = CGPoint(x:0.5,y: 1)
        layer.zPosition = -100
        view.layer.addSublayer(layer)
        view.addSubview(loginContainerView)
        view.addSubview(submitButton)
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    private func setupLayout() {
        loginContainerView.addSubview(nameField)
        loginContainerView.addSubview(emailField)
        loginContainerView.addSubview(passwordField)
        loginContainerView.addSubview(nameSeperatorView)
        loginContainerView.addSubview(emailSeperatorView)
        loginContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        loginContainerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        loginContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 4).isActive = true
        nameField.leadingAnchor.constraint(equalTo: loginContainerView.leadingAnchor, constant: 15).isActive = true
        nameField.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        nameField.heightAnchor.constraint(equalTo: loginContainerView.heightAnchor, multiplier: 1/3).isActive = true
        nameField.topAnchor.constraint(equalTo: loginContainerView.topAnchor).isActive = true
        nameField.centerXAnchor.constraint(equalTo: loginContainerView.centerXAnchor).isActive = true
        nameSeperatorView.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        nameSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        nameSeperatorView.centerXAnchor.constraint(equalTo: loginContainerView.centerXAnchor).isActive = true
        nameSeperatorView.topAnchor.constraint(equalTo: nameField.bottomAnchor).isActive = true
        emailField.leadingAnchor.constraint(equalTo: loginContainerView.leadingAnchor, constant: 15).isActive = true
        emailField.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        emailField.heightAnchor.constraint(equalTo: loginContainerView.heightAnchor, multiplier: 1/3).isActive = true
        emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor).isActive = true
        emailField.centerXAnchor.constraint(equalTo: loginContainerView.centerXAnchor).isActive = true
        emailSeperatorView.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        emailSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeperatorView.centerXAnchor.constraint(equalTo: loginContainerView.centerXAnchor).isActive = true
        emailSeperatorView.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: loginContainerView.leadingAnchor, constant: 15).isActive = true
        passwordField.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        passwordField.heightAnchor.constraint(equalTo: loginContainerView.heightAnchor, multiplier: 1/3).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: loginContainerView.centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalTo: loginContainerView.widthAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalTo: loginContainerView.heightAnchor, multiplier: 1/3).isActive = true
        submitButton.topAnchor.constraint(equalTo: loginContainerView.bottomAnchor, constant: 20).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: loginContainerView.centerXAnchor).isActive = true
        
    }
    
    @objc private func submitButtonPressed() {
        print("Submit button pressed!")
    }
    
    let loginContainerView : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        return containerView
    }()
    
    let nameSeperatorView : UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailSeperatorView : UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let nameField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Name"
        textField.textColor = .black
        return textField
    }()
    
    let emailField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.textColor = .black
        return textField
    }()
    
    let passwordField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        return textField
    }()
    
    let submitButton : UIButton = {
        let submitButton = UIButton()
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        submitButton.layer.cornerRadius = 5
        submitButton.backgroundColor = .green
        return submitButton
    }()
    
}
