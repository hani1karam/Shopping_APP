//
//  ViewController.swift
//  Shopping_APP
//
//  Created by Hany Karam on 5/4/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class ViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 30
        
        
        Login.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        Login.layer.cornerRadius = 5
        Login.layer.cornerRadius = 30
        Login.layer.borderWidth = 6
        
    }
    fileprivate func startAnimation() {
        let loading = NVActivityIndicatorView(frame: .zero, type: .ballClipRotateMultiple, color: .black, padding: 0)
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: 40),
            loading.heightAnchor.constraint(equalToConstant: 40),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        loading.startAnimating()
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 2){
            loading.stopAnimating()
        }
    }
    @IBAction func RegisterBtn(_ sender: Any) {
        let forgetVC = RegisterVC.instance()
        forgetVC.modalPresentationStyle = .fullScreen
        self.present(forgetVC, animated: true, completion: nil)
        
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        
        let param = ["email":email.text ?? "",
                     "password":password.text ?? ""]
        startAnimation()
        NetworkManagerUser.LoginUser(userInfoDict: param) { (respone, err) in
            if err == nil {
                if respone!.status! == 1 {
                    
                    let forgetVC = HomeVC.instance()
                    forgetVC.modalPresentationStyle = .fullScreen
                    self.present(forgetVC, animated: true, completion: nil)
                    
                    
                }
                else {
                    let alert = UIAlertController(title: "Some Error", message: "Enter Data!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
            
        }
        
    }
    
    
}

