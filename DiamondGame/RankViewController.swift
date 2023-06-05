//
//  RankViewController.swift
//  DiamondGame
//
//  Created by CNTT on 6/1/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class RankViewController: UIViewController {
    @IBOutlet weak var rankView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var btnClassic: UIButton!
    @IBOutlet weak var btnTimes: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        
        // xet giao dien label
        lblTitle.layer.masksToBounds = true
        lblTitle.layer.cornerRadius = 15.0
        
        // xet giao dien view
        rankView.layer.cornerRadius = 20.0
        detailView.layer.cornerRadius = 10.0
        
        // xet giao dien button
        btnClose.layer.cornerRadius = 10.0
        btnClose.layer.shadowColor = UIColor.black.cgColor
        btnClose.layer.shadowOpacity = 0.5
        btnClose.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnClassic.layer.cornerRadius = 10.0
        btnClassic.layer.shadowColor = UIColor.black.cgColor
        btnClassic.layer.shadowOpacity = 0.5
        btnClassic.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnTimes.layer.cornerRadius = 10.0
        btnTimes.layer.shadowColor = UIColor.black.cgColor
        btnTimes.layer.shadowOpacity = 0.5
        btnTimes.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        self.showAnimate()
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.removeAnimate()
    }
    
    @IBAction func btnClassic(_ sender: Any) {
  
    }
    
    @IBAction func btnTimes(_ sender: Any) {
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
