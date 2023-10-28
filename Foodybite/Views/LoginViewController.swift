//
//  LoginViewController.swift
//  Foodybite
//
//  Created by Murad Yarmamedov on 15.09.23.
//

import UIKit
import SnapKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var forgotPassword: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI(){
        
        setBackground()
        
        logoImageView.image = UIImage(named: "foodybiteLogo_image")
        emailImageView.image = UIImage(named: "email_icon")
        passwordImageView.image = UIImage(named: "password_icon")
        
        emailView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        emailView.clipsToBounds = true
        emailView.layer.cornerRadius = 10
        
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.textColor = UIColor.white
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 14.0)
        ])
        emailTextField.font = UIFont(name: "JosefinSansRoman-Regular 21.0", size: 14)
        emailTextField.borderStyle = .none
        
        passwordView.backgroundColor = .white
        passwordView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        passwordView.clipsToBounds = true
        passwordView.layer.cornerRadius = 10
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.textColor = UIColor.white
        passwordTextField.isSecureTextEntry = true
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 14.0)
        ])
        passwordTextField.font = UIFont(name: "JosefinSansRoman-Regular 21.0", size: 14)
        passwordTextField.borderStyle = .none
        
        forgotPassword.isUserInteractionEnabled = true
        let resetPasswordGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped))
        forgotPassword.addGestureRecognizer(resetPasswordGestureRecognizer)
        
        createAccount.isUserInteractionEnabled = true
        let createAccountGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(createAccountTapped))
        createAccount.addGestureRecognizer(createAccountGestureRecognizer)
    }
    
    func setBackground(){
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loginPageBackground_image")
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        view.addSubview(imageView)
        view.addSubview(logoImageView)
        view.addSubview(emailView)
        emailView.addSubview(emailTextField)
        emailView.addSubview(emailImageView)
        view.addSubview(passwordView)
        passwordView.addSubview(passwordTextField)
        passwordView.addSubview(passwordImageView)
        view.addSubview(forgotPassword)
        view.addSubview(loginButton)
        view.addSubview(createAccount)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [self] (resultData, error) in
                if let error = error{
                    makeAlert(title: "Error", message: error.localizedDescription)
                } else {
                    performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else {
            makeAlert(title: "Error", message: "Email or Password cannot be empty")
        }
    }
    
    @objc func forgotPasswordTapped() {
        performSegue(withIdentifier: "forgotPassword", sender: nil)
    }
    
    @objc func createAccountTapped() {
        performSegue(withIdentifier: "createAccount", sender: nil)
    }
    
    func makeAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
