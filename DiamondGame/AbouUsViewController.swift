//
//  AbouUsViewController.swift
//  DiamondGame
//
//  Created by CNTT on 5/31/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class AbouUsViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var aboutUsView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var smallInfoView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var smallContactView: UIView!
    @IBOutlet weak var versionView: UIView!
    @IBOutlet weak var smallVersionView: UIView!
    @IBOutlet weak var btnClose: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        
        // xet giao dien label
        lblTitle.layer.masksToBounds = true
        lblTitle.layer.cornerRadius = 10.0
        lblInfo.layer.masksToBounds = true
        lblInfo.layer.cornerRadius = 8.0
        lblContact.layer.masksToBounds = true
        lblContact.layer.cornerRadius = 8.0
        lblVersion.layer.masksToBounds = true
        lblVersion.layer.cornerRadius = 8.0
        
        // xet giao dien view
        aboutUsView.layer.cornerRadius = 15.0
        aboutUsView.backgroundColor = UIColor(red: 213/255, green: 237/255, blue: 255/255, alpha: 1)
        infoView.layer.cornerRadius = 10.0
        smallInfoView.layer.cornerRadius = 10.0
        contactView.layer.cornerRadius = 10.0
        smallContactView.layer.cornerRadius = 10.0
        versionView.layer.cornerRadius = 10.0
        smallVersionView.layer.cornerRadius = 10.0
        
        infoView.backgroundColor = UIColor(red: 165/255, green: 206/255, blue: 244/255, alpha: 1.0)
        smallInfoView.backgroundColor = UIColor(red: 222/255, green: 236/255, blue: 250/255, alpha: 1.0)
        contactView.backgroundColor = UIColor(red: 165/255, green: 206/255, blue: 244/255, alpha: 1.0)
        smallContactView.backgroundColor = UIColor(red: 222/255, green: 236/255, blue: 250/255, alpha: 1.0)
        versionView.backgroundColor = UIColor(red: 165/255, green: 206/255, blue: 244/255, alpha: 1.0)
        smallVersionView.backgroundColor = UIColor(red: 222/255, green: 236/255, blue: 250/255, alpha: 1.0)
        
        // xet giao dien button
        btnClose.layer.cornerRadius = 8.0
        
        // goi ham hien thi
        self.showAnimate()
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.removeAnimate()
    }
    // hien thi man hinh
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    // go bo man hinh
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
