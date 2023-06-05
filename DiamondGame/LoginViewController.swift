//
//  LoginViewController.swift
//  DiamondGame
//
//  Created by CNTT on 5/31/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    var dao:DatabaseLayer!
    var listUser = [Player]()
    static var lblname = ""
    
    var registerButtonAction: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // xet do xuyen thau background
        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        
        // xet radius va padding cho button
        btnClose.layer.cornerRadius = 8.0
        btnClose.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        btnClose.layer.shadowColor = UIColor.black.cgColor
        btnClose.layer.shadowOpacity = 0.5
        btnClose.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnRegister.layer.cornerRadius = 8.0
        btnRegister.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        btnRegister.layer.shadowColor = UIColor.black.cgColor
        btnRegister.layer.shadowOpacity = 0.5
        btnRegister.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnLogin.layer.cornerRadius = 8.0
        btnLogin.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        btnLogin.layer.shadowColor = UIColor.black.cgColor
        btnLogin.layer.shadowOpacity = 0.5
        btnLogin.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        // title btnClose
        btnClose.titleLabel?.font = UIFont(name: "Kalam-Bold", size: 30)
        btnLogin.titleLabel?.font = UIFont(name: "Kalam-Bold", size: 30)
        btnRegister.titleLabel?.font = UIFont(name: "Kalam-Bold", size: 30)
        
        // xet giao dien view
        loginView.layer.cornerRadius = 30.0
        loginView.backgroundColor = UIColor(red: 213/255, green: 237/255, blue: 255/255, alpha: 1.0)
        
        // xet giao dien label
        lblTitle.layer.masksToBounds = true
        lblTitle.layer.cornerRadius = 20.0
        lblTitle.font = UIFont(name: "Kalam-Bold", size: 40)
        lblUsername.font = UIFont(name: "Kalam-Bold", size: 25)
        lblPassword.font = UIFont(name: "Kalam-Bold", size: 25)
        
        // xet giao dien cho textfield
        tfUsername.backgroundColor = UIColor(red: 165/255, green: 206/255, blue: 244/255, alpha: 1.0)
        tfUsername.layer.shadowColor = UIColor.black.cgColor
        tfUsername.layer.shadowOpacity = 0.5
        tfUsername.layer.shadowOffset = CGSize(width: 0, height: 2)
        tfUsername.textAlignment = .center
        
        tfPassword.backgroundColor = UIColor(red: 165/255, green: 206/255, blue: 244/255, alpha: 1.0)
        tfPassword.layer.shadowColor = UIColor.black.cgColor
        tfPassword.layer.shadowOpacity = 0.5
        tfPassword.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        tfUsername.layer.cornerRadius = 8.0
        tfPassword.layer.cornerRadius = 8.0
        tfPassword.isSecureTextEntry = true
        tfPassword.textAlignment = .center
        // add animamate popup
        self.showAnimate()
       
    }
    @IBAction func btnClose(_ sender: Any) {
        self.removeAnimate()
    }
    @IBAction func btnRegister(_ sender: Any) {
        registerButtonAction?()
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let name = tfUsername.text
        let password = tfPassword.text
        LoginViewController.lblname = name!
        let check  = dao.checkUser(username: name!,password: password!)
        if(check != ""){
            print("login sucess")
            // thong bao
            _ = UIAlertController(title: "Thông báo", message: "Tai khoan khong ton tai", preferredStyle: .alert)
        }else{
            print("login fail")
            // self.removeAnimate()
        }
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
