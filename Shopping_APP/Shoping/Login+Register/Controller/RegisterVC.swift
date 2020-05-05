//
//  RegisterVC.swift
//  Shopping_APP
//
//  Created by Hany Karam on 5/4/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RegisterVC: UIViewController {
    static func instance () -> RegisterVC {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
    }
    @IBOutlet weak var Register: UIButton!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var Location: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.layer.cornerRadius = 30
        
        
        Register.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        Register.layer.cornerRadius = 5
        Register.layer.cornerRadius = 30
        Register.layer.borderWidth = 6
        
        
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
    
    @IBAction func Register(_ sender: Any) {
        let param = ["name":name.text ?? "" ,
                     "email":Email.text ?? "",
                     "password":password.text ?? "",
                     "phone":phone.text ?? "",
                     "addreess":Location.text ?? ""]
        startAnimation()
        
        NetworkManagerUser.registerNewUser(userInfoDict: param) { (response, err) in
            if response != nil {
                if response!.status! == 1 {
                    if response!.status! == 1 {
                        
                        let forgetVC = HomeVC.instance()
                                          forgetVC.modalPresentationStyle = .fullScreen
                                          self.present(forgetVC, animated: true, completion: nil)
                    }
                    
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
