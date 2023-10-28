//
//  ForgotPasswordViewController.swift
//  Foodybite
//
//  Created by Murad Yarmamedov on 19.09.23.
//

import UIKit
import SnapKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI(){
        setBackground()
        
        noteLabel.text = "Enter your email and will send you instructions on how to reset it"
        noteLabel.font = UIFont(name: "JosefinSansRoman-Regular 21.0", size: 21)
        noteLabel.textColor = .white
        
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
        
        emailImageView.image = UIImage(named: "email_icon")
        
        sendButton.setTitle("Send", for: .normal)
        sendButton.clipsToBounds = true
        sendButton.layer.cornerRadius = 10
        sendButton.snp.makeConstraints { make in
            make.width.equalTo(304)
            make.height.equalTo(50)
        }
    }
    
    func setBackground() {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loginPageBackground_image")
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        view.addSubview(imageView)
        view.addSubview(noteLabel)
        view.addSubview(emailView)
        emailView.addSubview(emailImageView)
        emailView.addSubview(emailTextField)
        view.addSubview(sendButton)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        if let email = emailTextField.text {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    self.makeAlert(title: "Error", message: error.localizedDescription)
                } else {
                    self.makeAlert(title: "Success", message: "Check your Email to reset password") { result in
                        self.performSegue(withIdentifier: "toLoginPage", sender: nil)
                    }
                }
            }
        } else {
            self.makeAlert(title: "Error", message: "An Email address must be provided")
        }
    }
    
    func makeAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
