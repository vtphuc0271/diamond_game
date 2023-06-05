//
//  RegisterViewController.swift
//  DiamondGame
//
//  Created by CNTT on 5/31/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: properties
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var lblRegister: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblComfirm: UILabel!
    @IBOutlet weak var tfComfirm: UITextField!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnCreate: UIButton!
    
    var dao:DatabaseLayer!
    var listUser = [Player]()
    static var lblname = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        
        // xet giao dien text field
        tfUsername.backgroundColor = UIColor(red: 165/255, green: 206/255, blue: 244/255, alpha: 1.0)
        tfPassword.backgroundColor = UIColor(red: 165/255, green: 206/255, blue: 244/255, alpha: 1.0)
        tfComfirm.backgroundColor = UIColor(red: 165/255, green: 206/255, blue: 244/255, alpha: 1.0)
        tfUsername.layer.cornerRadius = 8.0
        tfUsername.layer.shadowColor = UIColor.black.cgColor
        tfUsername.layer.shadowOpacity = 0.5
        tfUsername.layer.shadowOffset = CGSize(width: 0, height: 2)
        tfUsername.textAlignment = .center
        
        tfPassword.layer.cornerRadius = 8.0
        tfPassword.layer.shadowColor = UIColor.black.cgColor
        tfPassword.layer.shadowOpacity = 0.5
        tfPassword.layer.shadowOffset = CGSize(width: 0, height: 2)
        tfPassword.isSecureTextEntry = true
        tfPassword.textAlignment = .center
        
        tfComfirm.layer.cornerRadius = 8.0
        tfComfirm.layer.shadowColor = UIColor.black.cgColor
        tfComfirm.layer.shadowOpacity = 0.5
        tfComfirm.layer.shadowOffset = CGSize(width: 0, height: 2)
        tfComfirm.isSecureTextEntry = true
        tfComfirm.textAlignment = .center
        
        // xet giao dien button
        btnCancel.layer.cornerRadius = 8.0
        btnCancel.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        btnCancel.layer.shadowColor = UIColor.black.cgColor
        btnCancel.layer.shadowOpacity = 0.5
        btnCancel.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnCreate.layer.cornerRadius = 8.0
        btnCreate.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        btnCreate.layer.shadowColor = UIColor.black.cgColor
        btnCreate.layer.shadowOpacity = 0.5
        btnCreate.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        // title btnClose
        btnCancel.titleLabel?.font = UIFont(name: "Kalam-Bold", size: 30)
        btnCreate.titleLabel?.font = UIFont(name: "Kalam-Bold", size: 30)
        
        // xet giao dien label
        lblRegister.layer.masksToBounds = true
        lblRegister.layer.cornerRadius = 20.0
        lblRegister.font = UIFont(name: "Kalam-Bold", size: 40)
        lblUsername.font = UIFont(name: "Kalam-Bold", size: 25)
        lblPassword.font = UIFont(name: "Kalam-Bold", size: 25)
        lblComfirm.font = UIFont(name: "Kalam-Bold", size: 25)

        // xet giao dien view
        registerView.layer.cornerRadius = 20.0
        registerView.backgroundColor = UIColor(red: 213/255, green: 237/255, blue: 255/255, alpha: 1)
        
        // hien thi man hinh popup bang animation
        self.showAnimate()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.removeAnimate()
    }
    
    @IBAction func createPlayer(_ sender: Any) {
        let name = tfUsername.text!
        RegisterViewController.lblname = name
        let password = tfPassword.text!
        if  let player = Player(player_id: 0, player_name: name, player_password: password, scoreClassic: 0, scoreTime: 0){_ = dao?.insertUser(player: player)
            
            print(RegisterViewController.lblname)
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
