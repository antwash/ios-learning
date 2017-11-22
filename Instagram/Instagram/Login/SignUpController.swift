//  SignUpController.swift
//  Instagram
//  Created by Anthony Washington on 10/30/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit
import Firebase

class SignUpController: UIViewController {

    let addPhotoButton: UIButton = {
        let b = UIButton(type: .system)
            b.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
            b.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        return b
    }()
    
    let email: UITextField = {
        let e = UITextField()
            e.placeholder = "Email"
            e.borderStyle = .roundedRect
            e.autocapitalizationType = .none
            e.backgroundColor = UIColor(white: 0, alpha: 0.003)
            e.addTarget(self, action: #selector(handleChange), for: .editingChanged)
        return e
    }()
    
    let username: UITextField = {
        let u = UITextField()
            u.placeholder = "Username"
            u.borderStyle = .roundedRect
            u.autocapitalizationType = .none
            u.backgroundColor = UIColor(white: 0, alpha: 0.003)
            u.addTarget(self, action: #selector(handleChange), for: .editingChanged)
        return u
    }()
    
    let psswd: UITextField = {
        let p = UITextField()
            p.placeholder = "Password"
            p.isSecureTextEntry = true
            p.borderStyle = .roundedRect
            p.autocapitalizationType = .none
            p.backgroundColor = UIColor(white: 0, alpha: 0.003)
            p.addTarget(self, action: #selector(handleChange), for: .editingChanged)
        return p
    }()
    
    let signup: UIButton = {
        let s = UIButton(type: .system)
            s.isEnabled = false
            s.setTitle("Sign Up", for: .normal)
            s.setTitleColor(.white, for: .normal)
            s.backgroundColor = BUTTON_DISABLED_BLUE
            s.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            s.addTarget(self, action: #selector(letsSignUp), for: .touchUpInside)
        return s
    }()
    
    let login: UIButton = {
        let l = UIButton(type: .system)
        
        let attributed = NSMutableAttributedString(string: "Already have a account? ", attributes:
            [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
             NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
        attributed.append(NSAttributedString(string: "Sign In", attributes:
            [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
             NSAttributedStringKey.foregroundColor: BUTTON_ENABLED_BLUE]))
        
            l.setAttributedTitle(attributed, for: .normal)
            l.addTarget(self, action: #selector(presentLogin), for: .touchUpInside)
        return l
    }()
    
    @objc func presentLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleChange() {
        guard let email = email.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let username = username.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let psswd = psswd.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        if isValidForm(e: email, u: username, p: psswd) {
            signup.isEnabled = true
            signup.backgroundColor = BUTTON_ENABLED_BLUE
        } else {
            signup.isEnabled = false
            signup.backgroundColor = BUTTON_DISABLED_BLUE
        }
    }
    
    private func isValidForm(e: String, u: String, p: String) -> Bool{
        if isValidEmail(e: e) {
            if isValidPsswd(p: p) {
                if isValidUserName(u: u) {
                    return true
                }
            }
        }
        return false
    }
    
    private func isValidEmail(e: String) -> Bool {
        let validate = NSPredicate(format: "SELF MATCHES %@", EMAIL_REGEX)
        return validate.evaluate(with: e)
    }
    
    private func isValidUserName(u: String) -> Bool {
        let validate = NSPredicate(format: "SELF MATCHES %@", USERNAME_REGEX)
        return validate.evaluate(with: u)
    }
    
    private func isValidPsswd(p: String) -> Bool {
        return p.count > 8
    }
    
    @objc func selectPhoto() {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func letsSignUp() {
        guard let email = email.text else { return }
        guard let password = psswd.text else { return }
        guard let username = username.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print("Failed to create user:", err)
                return
            }
        
            guard let uid = user?.uid else { return }
            guard let image = self.addPhotoButton.imageView?.image else { return }
            guard let upload = UIImageJPEGRepresentation(image, 0.3) else { return }
            
            Storage.storage().reference().child("profile_images").child(uid).putData(
                upload, metadata: nil, completion: { (metadata, error) in
                    if let err = error {
                        print("Failed uploading profile image:", err)
                        return
                    }
                    
                guard let profileURL = metadata?.downloadURL()?.absoluteString else { return }
                
                let values = [uid: [
                        "username": username,
                        "profile_url": profileURL
                    ]]
                    
                Database.database().reference().child("users").updateChildValues(
                    values, withCompletionBlock: { (error, ref) in
                        if let err = error {
                            print("Failed to save user info into db:", err)
                            return
                        }

                        guard let main = UIApplication.shared.keyWindow?.rootViewController
                            as? MainTabController else { return }
                        
                        main.configureUserProfile()
                        self.dismiss(animated: true, completion: nil)
                    })
                })
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stackView = UIStackView(arrangedSubviews: [email, username, psswd, signup])
            stackView.distribution = .fillEqually
            stackView.axis = .vertical
            stackView.spacing = 10
        
        view.backgroundColor = .white
        view.addSubview(addPhotoButton)
        view.addSubview(stackView)
        view.addSubview(login)
        
        addPhotoButton.anchors(top: view.topAnchor, toppad: 40, bottom: nil, bottompad: 0,
                               left: nil, leftpad: 0, right: nil, rightpad: 0,
                               height: 140, width: 140)
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackView.anchors(top: addPhotoButton.bottomAnchor, toppad: 20, bottom: nil, bottompad: 0,
                          left: view.leftAnchor, leftpad: 40, right: view.rightAnchor, rightpad: 40,
                          height: 200, width: 0)
        
        login.anchors(top: nil, toppad: 0, bottom: view.bottomAnchor,
                       bottompad: 0, left: view.leftAnchor, leftpad: 0,
                       right: view.rightAnchor, rightpad: 0, height: 50, width: 0)
    }
}

extension SignUpController : UINavigationControllerDelegate {}
extension SignUpController : UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let edit = info["UIImagePickerControllerEditedImage"] as? UIImage {
            addPhotoButton.setImage(edit.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let original = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            addPhotoButton.setImage(original.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width / 2
        dismiss(animated: true, completion: nil)
    }
}

