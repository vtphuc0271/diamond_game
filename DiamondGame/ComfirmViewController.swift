//
//  ComfirmViewController.swift
//  DiamondGame
//
//  Created by CNTT on 6/1/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class ComfirmViewController: UIViewController {
    @IBOutlet weak var comfirmView: UIView!
    @IBOutlet weak var lblComfirm: UILabel!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        
        //xet giao dien view
        comfirmView.layer.cornerRadius = 10.0
        
        //xet giao dien label
        lblComfirm.layer.masksToBounds = true
        lblComfirm.layer.cornerRadius = 5.0
        
        // xet giao dien button
        btnOk.layer.masksToBounds = true
        btnOk.layer.cornerRadius = 10.0
        btnOk.layer.shadowColor = UIColor.black.cgColor
        btnOk.layer.shadowOpacity = 0.5
        btnOk.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnCancel.layer.masksToBounds = true
        btnCancel.layer.cornerRadius = 10.0
        btnCancel.layer.shadowColor = UIColor.black.cgColor
        btnCancel.layer.shadowOpacity = 0.5
        btnCancel.layer.shadowOffset = CGSize(width: 0, height: 2)

       
        self.showAnimate()
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
    
    @IBAction func btnCancel(_ sender: Any) {
        self.removeAnimate()
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
