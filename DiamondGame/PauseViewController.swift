//
//  PauseViewController.swift
//  DiamondGame
//
//  Created by CNTT on 6/1/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController {
    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnResume: UIButton!
    @IBOutlet weak var btnExit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        
        // xet giao dien view
        pauseView.layer.cornerRadius = 20.0

        
        // xet giao dien label
        lblTitle.layer.masksToBounds = true
        lblTitle.layer.cornerRadius = 20.0
        
        // xet giao dien button
        btnResume.layer.masksToBounds = true
        btnResume.layer.cornerRadius = 10.0
        btnResume.layer.shadowColor = UIColor.black.cgColor
        btnResume.layer.shadowOpacity = 0.5
        btnResume.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnExit.layer.masksToBounds = true
        btnExit.layer.cornerRadius = 10.0
        btnExit.layer.shadowColor = UIColor.black.cgColor
        btnExit.layer.shadowOpacity = 0.5
        btnExit.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    @IBAction func btnResume(_ sender: Any) {
        removeAnimate()
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
    
    @IBAction func btnExit(_ sender: Any) {
        let ComfirmOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameComfirmPopupID") as! ComfirmViewController
        
        self.addChild(ComfirmOverVC)
        ComfirmOverVC.view.frame = self.view.frame
        self.view.addSubview(ComfirmOverVC.view)
        ComfirmOverVC.didMove(toParent: self)
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
