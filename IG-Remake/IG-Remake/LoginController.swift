//
//  LoginController.swift
//  IG-Remake
//
//  Created by Anthony Washington on 7/10/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    let logoContainer : UIView = {
        let l = UIView()
            l.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        let logo = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
            logo.contentMode = .scaleAspectFill
            l.addSubview(logo)
            logo.anchors(top: nil, topPad: 0, bottom: nil, bottomPad: 0,
                         left: nil, leftPad: 0, right: nil, rightPad: 0, height: 50, width: 200)
            logo.centerXAnchor.constraint(equalTo: l.centerXAnchor).isActive = true
            logo.centerYAnchor.constraint(equalTo: l.centerYAnchor).isActive = true
        return l
    }()
    
    
    // Email textfield
    let emailField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.backgroundColor = UIColor(white: 0, alpha: 0.03)
        email.borderStyle = .roundedRect
        email.font = UIFont.systemFont(ofSize: 14)
        return email
    }()
    
    // Password textfield
    let passwrdField: UITextField = {
        let psswd = UITextField()
        psswd.placeholder = "Password"
        psswd.isSecureTextEntry = true
        psswd.backgroundColor = UIColor(white: 0, alpha: 0.03)
        psswd.borderStyle = .roundedRect
        psswd.font = UIFont.systemFont(ofSize: 14)
        return psswd
    }()
    
    // Signup button
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()

    let signUpButton : UIButton = {
        let b = UIButton(type: .system)
        let title = NSMutableAttributedString(string: "Don't have an account?  ",
                    attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14),
                    NSForegroundColorAttributeName: UIColor.lightGray])
            title.append(NSAttributedString(string: "Sign Up", attributes: [NSFontAttributeName:
                    UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName:
                    UIColor.rgb(red: 14, green: 154, blue: 237)]))
        
            b.setAttributedTitle(title, for: .normal)
            b.addTarget(self, action: #selector(showSignUpController), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        
        view.addSubview(signUpButton)
        view.addSubview(logoContainer)
        setupSignUpFields()
        
        signUpButton.anchors(top: nil, topPad: 0, bottom: view.bottomAnchor,
                             bottomPad: 0, left: view.leftAnchor, leftPad: 0,
                             right: view.rightAnchor, rightPad: 0, height: 50, width: 0)
        logoContainer.anchors(top: view.topAnchor, topPad: 0, bottom: nil, bottomPad: 0,
                              left: view.leftAnchor, leftPad: 0, right: view.rightAnchor,
                              rightPad: 0, height: 150, width: 0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func showSignUpController() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    fileprivate func setupSignUpFields() {
        let stackView = UIStackView(arrangedSubviews: [emailField, passwrdField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchors(top: logoContainer.bottomAnchor, topPad: 40,
                          bottom: nil, bottomPad: 0, left: view.leftAnchor, leftPad: 40,
                          right: view.rightAnchor, rightPad: 40, height: 140, width: 0)

    }
   
}
