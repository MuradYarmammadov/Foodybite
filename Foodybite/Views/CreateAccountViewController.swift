//
//  CreateAccountViewController.swift
//  Foodybite
//
//  Created by Murad Yarmamedov on 26.09.23

import UIKit
import SnapKit
import Firebase
import FirebaseStorage

class CreateAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var accountImageView: UIView!
    @IBOutlet weak var accountLogoImageView: UIImageView!
    @IBOutlet weak var uploadImageView: UIView!
    @IBOutlet weak var uploadLogoImageView: UIImageView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var confirmPasswordImageView: UIImageView!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI(){
        setBackground()
        
        accountLogoImageView.image = UIImage(named: "accountPhoto_icon")
        uploadLogoImageView.image = UIImage(named: "upload_icon")
        nameImageView.image = UIImage(named: "accountPhoto_icon")
        emailImageView.image = UIImage(named: "email_icon")
        passwordImageView.image = UIImage(named: "password_icon")
        confirmPasswordImageView.image = UIImage(named: "password_icon")
        
        accountLogoImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        accountLogoImageView.addGestureRecognizer(gestureRecognizer)
        
        uploadLogoImageView.isUserInteractionEnabled = true
        let gestureRecognizer2 = UIGestureRecognizer(target: self, action: #selector(chooseImage))
        uploadLogoImageView.addGestureRecognizer(gestureRecognizer2)
        
        accountImageView.clipsToBounds = true
        accountImageView.layer.masksToBounds = true
        accountImageView.layer.cornerRadius = accountImageView.frame.width / 2
        
        uploadImageView.clipsToBounds = true
        uploadImageView.layer.masksToBounds = true
        uploadImageView.layer.cornerRadius = uploadImageView.frame.width / 2
        
        nameView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        nameView.clipsToBounds = true
        nameView.layer.cornerRadius = 10
        
        nameTextField.backgroundColor = UIColor.clear
        nameTextField.textColor = UIColor.white
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 14.0)
        ])
        nameTextField.font = UIFont(name: "JosefinSansRoman-Regular 21.0", size: 14)
        nameTextField.borderStyle = .none
        
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
        
        confirmPasswordView.backgroundColor = .white
        confirmPasswordView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        confirmPasswordView.clipsToBounds = true
        confirmPasswordView.layer.cornerRadius = 10
        
        confirmPasswordTextField.backgroundColor = UIColor.clear
        confirmPasswordTextField.textColor = UIColor.white
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 14.0)
        ])
        confirmPasswordTextField.font = UIFont(name: "JosefinSansRoman-Regular 21.0", size: 14)
        confirmPasswordTextField.borderStyle = .none
        
        loginLabel.isUserInteractionEnabled = true
        let loginGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        loginLabel.addGestureRecognizer(loginGestureRecognizer)
        
    }
    
    func setBackground() {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "createAccountBackground_image")
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        uiView.backgroundColor = UIColor.clear
        
        view.addSubview(imageView)
        view.addSubview(uiView)
        uiView.addSubview(accountImageView)
        uiView.addSubview(uploadImageView)
        uploadImageView.addSubview(uploadLogoImageView)
        view.addSubview(nameView)
        nameView.addSubview(nameImageView)
        nameView.addSubview(nameTextField)
        view.addSubview(emailView)
        emailView.addSubview(emailImageView)
        emailView.addSubview(emailTextField)
        view.addSubview(passwordView)
        passwordView.addSubview(passwordImageView)
        passwordView.addSubview(passwordTextField)
        view.addSubview(confirmPasswordView)
        confirmPasswordView.addSubview(confirmPasswordImageView)
        confirmPasswordView.addSubview(confirmPasswordTextField)
        view.addSubview(registerButton)
        view.addSubview(loginLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
            make.right.equalTo(self.view.snp.right)
            make.left.equalTo(self.view.snp.left)
        }
    }
    
    @IBAction func registerButtonAction(_ sender: UIButton) {
        if nameTextField.text == "" ||
            emailTextField.text == "" ||
            passwordTextField.text == "" ||
            confirmPasswordTextField.text == "" {
            makeAlert(title: "Error", message: "You should enter all information")
        } else {
            if passwordTextField.text == confirmPasswordTextField.text {
                if let name = nameTextField.text,
                   let image = accountLogoImageView.image?.jpegData(compressionQuality: 0.8),
                   let email = emailTextField.text,
                   let password = passwordTextField.text {
                    createUser(email: email, password: password) { userUid, error in
                        if let error = error {
                            self.makeAlert(title: "Error", message: error.localizedDescription)
                        } else if let userUid = userUid {
                            self.uploadProfilePicture(image: image, userUid: userUid) { imageUrl, error in
                                if let error = error {
                                    self.makeAlert(title: "Error", message: error.localizedDescription)
                                } else if let imageUrl = imageUrl {
                                    self.uploadUserData(name: name, email: email, imageUrl: imageUrl, userUid: userUid)
                                }
                            }
                        }
                    }
                } else {
                    makeAlert(title: "Error", message: "Passwords don't match")
                }
            }
        }
    }
    
    @objc func loginTapped(){
        performSegue(withIdentifier: "toLoginPage", sender: nil)
    }
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        accountLogoImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func createUser(email: String, password: String, completion: @escaping (String?, Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { resultdata, error in
                if let error = error {
                    completion(nil, error)
                } else if let resultdata = resultdata {
                    let userUid = resultdata.user.uid
                    completion(userUid, nil)
                }
            }
    }
    
    func uploadProfilePicture(image: Data, userUid: String, completion: @escaping (String?, Error?) -> Void) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let profilePicturesFolderRef = storageReference.child("profilePicturesFolder")
        let profilPictureRef = profilePicturesFolderRef.child(userUid)
        profilPictureRef.putData(image) { metadata, error in
            if let error = error {
                completion(nil, error)
            } else {
                profilPictureRef.downloadURL { url, error in
                    if let error = error {
                        completion(nil, error)
                    } else if let url = url {
                        let imageUrl = url.absoluteString
                        completion(imageUrl,nil)
                    }
                }
            }
        }
    }
    
    func uploadUserData(name: String, email: String, imageUrl: String, userUid: String) {
        let firestoreDatabase = Firestore.firestore()
        let usersDictionary = ["Name": name, "Email": email, "Image Url": imageUrl, "Date": FieldValue.serverTimestamp()] as [String: Any]
        let usersCollection = firestoreDatabase.collection("Users")
        let userDocument = usersCollection.document(userUid)
        userDocument.setData(usersDictionary) { error in
            if let error = error{
                self.makeAlert(title: "Error", message: error.localizedDescription)
            } else {
                self.makeAlert(title: "Success", message: "Acount created") { _ in
                    self.performSegue(withIdentifier: "toLoginPage", sender: nil)
                }
            }
        }
        
    }
}
