//
//  SignUpViewController.swift
//  IG-Remake
//
//  Created by Anthony Washington on 4/26/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit
import Firebase


class SignUpViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    // Profile image button.
    let photoButton: UIButton = {
        let button = UIButton()
            button.setImage(UIImage(named: "plus_photo"), for: .normal)
            button.addTarget(self, action: #selector(pickProfilePic), for: .touchUpInside)
        return button
    }()
    
    // Signup button
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
            button.setTitle("Sign Up", for: .normal)
            button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.setTitleColor(UIColor.white, for: .normal)
            button.layer.cornerRadius = 5
            button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
            button.isEnabled = false
        return button
    }()
    
    // Email textfield
    let emailField: UITextField = {
        let email = UITextField()
            email.placeholder = "Email"
            email.backgroundColor = UIColor(white: 0, alpha: 0.03)
            email.borderStyle = .roundedRect
            email.font = UIFont.systemFont(ofSize: 14)
            email.addTarget(self, action: #selector(validateForm), for: .editingChanged)
        return email
    }()
    
    // Username textfield
    let usernameField: UITextField = {
        let username = UITextField()
            username.placeholder = "Username"
            username.backgroundColor = UIColor(white: 0, alpha: 0.03)
            username.borderStyle = .roundedRect
            username.font = UIFont.systemFont(ofSize: 14)
            username.addTarget(self, action: #selector(validateForm), for: .editingChanged)
        return username
    }()
    
    // Password textfield
    let passwrdField: UITextField = {
        let psswd = UITextField()
            psswd.placeholder = "Password"
            psswd.isSecureTextEntry = true
            psswd.backgroundColor = UIColor(white: 0, alpha: 0.03)
            psswd.borderStyle = .roundedRect
            psswd.font = UIFont.systemFont(ofSize: 14)
            psswd.addTarget(self, action: #selector(validateForm), for: .editingChanged)
        return psswd
    }()
    
    let signInButton : UIButton = {
        let b = UIButton(type: .system)
        let title = NSMutableAttributedString(string: "Already have an account?  ",
                                              attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14),
                                                           NSForegroundColorAttributeName: UIColor.lightGray])
        title.append(NSAttributedString(string: "Sign In", attributes: [NSFontAttributeName:
            UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName:
                UIColor.rgb(red: 14, green: 154, blue: 237)]))
        
        b.setAttributedTitle(title, for: .normal)
        b.addTarget(self, action: #selector(showLoginController), for: .touchUpInside)
        return b
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(photoButton)
        view.addSubview(signInButton)
        view.backgroundColor = .white
        
        photoButton.anchors(top: view.topAnchor, topPad: 40, bottom: nil, bottomPad: 0,
                            left: nil, leftPad: nil, right: nil, rightPad: nil, height: 140,
                            width: 140)
        photoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        signInButton.anchors(top: nil, topPad: 0, bottom: view.bottomAnchor,
                             bottomPad: 0, left: view.leftAnchor, leftPad: 0,
                             right: view.rightAnchor, rightPad: 0, height: 50, width: 0)

        setupSignUpFields()
    }
    
    // sign up users
    func signUp() {
        
        guard let email = emailField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
                        !email.isEmpty else { return }
        guard let name = usernameField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
                        !name.isEmpty else { return }
        guard let psswd = passwrdField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines),
                        !psswd.isEmpty else { return }
        
        
        FIRAuth.auth()?.createUser(withEmail: email, password: psswd, completion: { (user, error) in
        
            if let err = error {
                print("Error creating user: ", err)
                return
            }
            
            print("Successfully created user: ", user?.uid ?? "")
            
            
            // upload user profile picture
            guard let profile_pic = self.photoButton.imageView?.image else { return }
            guard let data = UIImageJPEGRepresentation(profile_pic, 0.5) else { return }
            
            let uid = UUID().uuidString
            
            FIRStorage.storage().reference().child("profile_images").child(uid).put(data, 
                                                                                    metadata: nil, 
                                                                                    completion: { (metadata, error) in
                
                if let err = error {
                    print("Error uploading user profile image: ", err)
                    return
                }
                
                // profile image URL
                guard let imageURL = metadata?.downloadURL()?.absoluteString else { return }
                
                guard let uid = user?.uid  else { return }
                let user_dic = ["user_name": name, "profile_image": imageURL]
                let values = [uid : user_dic]
                
                FIRDatabase.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, ref) in
                    if let err = error {
                            print("Error: \(err)")
                            print("Error saving username to DB for user \(uid)")
                        }
                                
                            print("Successfully save user \(uid) username to DB.")
                    })
                print("Successfully uploaded image: ", imageURL)
            })
        })
    }
    
    // checks form fields are filled with values
    func validateForm() {
        
        let valid = !(emailField.text?.isEmpty)! && 
                    (!(usernameField.text?.isEmpty)!) && 
                    ((passwrdField.text?.characters.count)! > 6)
        
        if valid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        }
        else {
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
    
    
    // image picker for profile
    func pickProfilePic() {
        let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    // method called after picture selection
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let edited = info["UIImagePickerControllerEditedImage"] as? UIImage {
            photoButton.setImage(edited, for: .normal)
        }
        else if let original = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            photoButton.setImage(original, for: .normal)
        }
        
        photoButton.layer.cornerRadius = photoButton.frame.width / 2
        photoButton.layer.masksToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupSignUpFields() {
        let stackView = UIStackView(arrangedSubviews: [emailField, usernameField, passwrdField, signupButton])
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        stackView.anchors(top: photoButton.bottomAnchor, topPad: 20, bottom: nil, bottomPad: 0,
                          left: view.leftAnchor, leftPad: 40, right: view.rightAnchor, rightPad: 40,
                          height: 200, width: 0)
    }
    
    func showLoginController() {
        navigationController?.popViewController(animated: true)
    }
}
