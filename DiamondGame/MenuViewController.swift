//
//  ViewController.swift
//  PROJECT_GAME
//
//  Created by CNTT on 5/31/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var btnClassic: UIButton!
    @IBOutlet weak var btnArcade: UIButton!
    
    @IBOutlet weak var btnTime: UIButton!
    
    @IBOutlet weak var btnEndless: UIButton!
    
    @IBOutlet weak var ivUser: UIImageView!
    
    @IBOutlet weak var btnRank: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSetting: UIButton!
    
    @IBOutlet weak var btnGuide: UIButton!
    @IBOutlet weak var btnAboutUs: UIButton!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    var dao: DatabaseLayer!
    var listPlayer = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.isHidden = true
        btnLogin.layer.cornerRadius = 5.0
        btnLogin.layer.shadowColor = UIColor.black.cgColor
        btnLogin.layer.shadowOpacity = 0.5
        btnLogin.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnRegister.isHidden = true
        btnRegister.layer.cornerRadius = 5.0
        btnRegister.layer.shadowColor = UIColor.black.cgColor
        btnRegister.layer.shadowOpacity = 0.5
        btnRegister.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnClassic.layer.cornerRadius = 10.0
        btnClassic.layer.shadowColor = UIColor.black.cgColor
        btnClassic.layer.shadowOpacity = 0.5
        btnClassic.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnArcade.layer.cornerRadius = 10.0
        btnArcade.layer.shadowColor = UIColor.black.cgColor
        btnArcade.layer.shadowOpacity = 0.5
        btnArcade.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnTime.layer.cornerRadius = 10.0
        btnTime.layer.shadowColor = UIColor.black.cgColor
        btnTime.layer.shadowOpacity = 0.5
        btnTime.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnEndless.layer.cornerRadius = 10.0
        btnEndless.layer.shadowColor = UIColor.black.cgColor
        btnEndless.layer.shadowOpacity = 0.5
        btnEndless.layer.shadowOffset = CGSize(width: 0, height: 2)

        let imgBackground = UIImage(named:"home")
        
        
        // btnRank.backgroundColor = UIColor(patternImage: imgRank!)
        view.backgroundColor = UIColor(patternImage: imgBackground!)
        // Do any additional setup after loading the view.
        
        ivUser.layer.cornerRadius = 12.0
        ivUser.isUserInteractionEnabled = true
        let tapped = UITapGestureRecognizer(target: self, action: #selector(imageUserTapped))
        ivUser.addGestureRecognizer(tapped)
        
        btnRank.layer.masksToBounds = true
        btnRank.layer.cornerRadius = 5.0
        
        btnSetting.layer.masksToBounds = true
        btnSetting.layer.cornerRadius = 5.0
        
        btnGuide.layer.masksToBounds = true
        btnGuide.layer.cornerRadius = 5.0
        
        btnAboutUs.layer.masksToBounds = true
        btnAboutUs.layer.cornerRadius = 5.0
        
        
        let imgRank  = UIImage(named: "rank")
        let imgSetting = UIImage(named: "setting")
        let imgGuide = UIImage(named: "guide")
        let imgAboutUs = UIImage(named: "noty")
        btnRank.setImage(imgRank?.withRenderingMode(.alwaysOriginal), for: .normal)
        btnSetting.setImage(imgSetting?.withRenderingMode(.alwaysOriginal), for: .normal)
        btnGuide.setImage(imgGuide?.withRenderingMode(.alwaysOriginal), for: .normal)
        btnAboutUs.setImage(imgAboutUs?.withRenderingMode(.alwaysOriginal), for: .normal)
        

        
    }
    
    //MARK Su kien khi tap vao imageView User
    @objc func imageUserTapped()
    {
        btnLogin.isHidden = false
        btnRegister.isHidden = false
        view.addSubview(btnLogin)
        view.addSubview(btnRegister)
        
    }
    //MARK Su kien khi tap vao
    
    @IBAction func loginViewEvent(_ sender: Any) {
        self.ShowLogin()
    }
    
    @IBAction func registerViewEvent(_ sender: Any) {
        self.ShowRegister()
    }
    
    @IBAction func btnAboutUs(_ sender: Any) {
        self.ShowAboutUs()
    }
    func ShowLogin(){
        let loginOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbLoginPopupID") as! LoginViewController
        self.addChild(loginOverVC)
        loginOverVC.view.frame = self.view.frame
        self.view.addSubview(loginOverVC.view)
        loginOverVC.didMove(toParent: self)
        loginOverVC.registerButtonAction = {
            // Hiển thị màn hình Register
            self.ShowRegister()
        }
    }
    @IBAction func btnRank(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let rankOverVC = storyBoard.instantiateViewController(withIdentifier: "sbRankPopupID") as! RankViewController
        self.addChild(rankOverVC)
        rankOverVC.view.frame = self.view.frame
        self.view.addSubview(rankOverVC.view)
        rankOverVC.didMove(toParent: self)
    }
    
    func registerButtonTapped() {
        self.ShowRegister()
    }
    
    @IBAction func btnSetting(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let setttingOverVC = storyBoard.instantiateViewController(withIdentifier: "sbSettingPopupID") as! SettingViewController
        self.addChild(setttingOverVC)
        setttingOverVC.view.frame = self.view.frame
        self.view.addSubview(setttingOverVC.view)
        setttingOverVC.didMove(toParent: self)
    }
    
    
    func ShowRegister(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let registerOverVC = storyBoard.instantiateViewController(withIdentifier: "sbRegisterPopupID") as! RegisterViewController
        self.addChild(registerOverVC)
        registerOverVC.view.frame = self.view.frame
        self.view.addSubview(registerOverVC.view)
        registerOverVC.didMove(toParent: self)
    }
    
    func ShowAboutUs(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let aboutUsOverVC = storyBoard.instantiateViewController(withIdentifier: "sbAboutUsPopupID") as! AbouUsViewController
        self.addChild(aboutUsOverVC)
        aboutUsOverVC.view.frame = self.view.frame
        self.view.addSubview(aboutUsOverVC.view)
        aboutUsOverVC.didMove(toParent: self)
    }
    
}
