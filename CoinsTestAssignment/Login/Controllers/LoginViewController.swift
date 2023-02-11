//
//  LoginViewController.swift
//  CoinsTestAssignment
//
//  Created by Alexey on 1/25/23.
//

import UIKit

final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont(name: "Helvetica-Bold", size: 22)
        label.text = "Login"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var userNameField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.placeholder = "Enter Username"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    private lazy var userPasswordField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.placeholder = "Enter Password"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var  signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemCyan
        button.layer.cornerRadius = 10
        button.setTitle("SIGN IN", for: .normal)
        button.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(loginLabel)
        view.addSubview(userNameField)
        view.addSubview(userPasswordField)
        view.addSubview(signInButton)
        
        createLoginLabelConstraint()
        createUserNameFieldConstraint()
        createPasswordFieldConstraint()
        createSignInButtonConstraint()
        
        userNameField.delegate = self
        userPasswordField.delegate = self
    }
    
    func createLoginLabelConstraint() {
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        loginLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        loginLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        loginLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createUserNameFieldConstraint() {
        userNameField.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        userNameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        userNameField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        userNameField.widthAnchor.constraint(equalToConstant: 120).isActive = true
        userNameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createPasswordFieldConstraint() {
        userPasswordField.topAnchor.constraint(equalTo: view.topAnchor, constant: 320).isActive = true
        userPasswordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        userPasswordField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        userPasswordField.widthAnchor.constraint(equalToConstant: 120).isActive = true
        userPasswordField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func createSignInButtonConstraint() {
        signInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 640).isActive = true
        signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            textField.resignFirstResponder()
            userPasswordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @objc func signInButtonClicked() {
        viewModel.didTapSignInButton(userName: userNameField.text ?? "N/A", password: userPasswordField.text ?? "N/A")
    }
}
