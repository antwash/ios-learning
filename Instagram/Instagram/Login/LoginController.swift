//  LoginController.swift
//  Instagram
//  Created by Anthony Washington on 11/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit
import Firebase

class LoginController: UIViewController {
    
    let logo: UIView = {
        let l = UIView()
        let logoimage = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
            logoimage.contentMode = .scaleAspectFill
        
            l.addSubview(logoimage)
            logoimage.anchors(top: nil, toppad: 0, bottom: nil, bottompad: 0,
                              left: nil, leftpad: 0, right: nil, rightpad: 0,
                              height: 50, width: 200)

            logoimage.centerXAnchor.constraint(equalTo: l.centerXAnchor).isActive = true
            logoimage.centerYAnchor.constraint(equalTo: l.centerYAnchor).isActive = true
            l.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        return l
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
    
    let login: UIButton = {
        let l = UIButton(type: .system)
            l.isEnabled = false
            l.setTitle("Login", for: .normal)
            l.setTitleColor(.white, for: .normal)
            l.backgroundColor = BUTTON_DISABLED_BLUE
            l.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            l.addTarget(self, action: #selector(letsLogin), for: .touchUpInside)
        return l
    }()
    
    let signup: UIButton = {
        let s = UIButton(type: .system)
        
        let attributed = NSMutableAttributedString(string: "Don't have an account? ", attributes:
            [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
             NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
            attributed.append(NSAttributedString(string: "Sign Up", attributes:
            [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
             NSAttributedStringKey.foregroundColor: BUTTON_ENABLED_BLUE]))
            
            s.setAttributedTitle(attributed, for: .normal)
            s.addTarget(self, action: #selector(presentRegister), for: .touchUpInside)
        return s
    }()
    
    @objc func presentRegister() {
        navigationController?.pushViewController(SignUpController(), animated: true)
    }
    
    @objc func letsLogin() {
        guard let email = email.text else { return }
        guard let psswd = psswd.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: psswd) { (user, error) in
            if let err = error {
                print("Failed to login:", err)
                return
            }
            
            guard let main = UIApplication.shared.keyWindow?.rootViewController
                as? MainTabController else { return }
            
            main.configureUserProfile()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleChange() {
        guard let email = email.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let psswd = psswd.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        if isValidEmail(e: email) && isValidPsswd(p: psswd) {
            login.isEnabled = true
            login.backgroundColor = BUTTON_ENABLED_BLUE
        } else {
            login.isEnabled = false
            login.backgroundColor = BUTTON_DISABLED_BLUE
        }
    }
    
    private func isValidEmail(e: String) -> Bool {
        let validate = NSPredicate(format: "SELF MATCHES %@", EMAIL_REGEX)
        return validate.evaluate(with: e)
    }
    
    private func isValidPsswd(p: String) -> Bool {
        return p.count > 8
    }
    
    fileprivate func configureSignUpForm() {
        let stackView = UIStackView(arrangedSubviews: [email, psswd, login])
            stackView.distribution = .fillEqually
            stackView.axis = .vertical
            stackView.spacing = 10
        
        view.addSubview(logo)
        view.addSubview(signup)
        view.addSubview(stackView)
        
        logo.anchors(top: view.topAnchor, toppad: 0, bottom: nil, bottompad: 0,
                     left: view.leftAnchor, leftpad: 0, right: view.rightAnchor,
                     rightpad: 0, height: 150, width: 0)
        signup.anchors(top: nil, toppad: 0, bottom: view.bottomAnchor,
                       bottompad: 0, left: view.leftAnchor, leftpad: 0,
                       right: view.rightAnchor, rightpad: 0, height: 50, width: 0)
        stackView.anchors(top: logo.bottomAnchor, toppad: 12, bottom: nil, bottompad: 0,
                          left: view.leftAnchor, leftpad: 40, right: view.rightAnchor,
                          rightpad: 40, height: 140, width: 0)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        configureSignUpForm()
    }   
}
