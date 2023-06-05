//
//  SettingViewController.swift
//  DiamondGame
//
//  Created by CNTT on 6/1/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnMusic: UIButton!
    @IBOutlet weak var btnAudio: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0)

    // xet giao dien view
        settingView.layer.cornerRadius = 20.0
        
    // xet giao dien label
        lblTitle.layer.masksToBounds = true
        lblTitle.layer.cornerRadius = 15.0
    
        // xet giao dien button
        btnAudio.layer.cornerRadius = 10.0
        btnAudio.layer.shadowColor = UIColor.black.cgColor
        btnAudio.layer.shadowOpacity = 0.5
        btnAudio.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        btnMusic.layer.shadowColor = UIColor.black.cgColor
        btnMusic.layer.shadowOpacity = 0.5
        btnMusic.layer.shadowOffset = CGSize(width: 0, height: 2)
        btnMusic.layer.cornerRadius = 10.0
        
        btnClose.layer.cornerRadius = 10.0
        btnClose.layer.shadowColor = UIColor.black.cgColor
        btnClose.layer.shadowOpacity = 0.5
        btnClose.layer.shadowOffset = CGSize(width: 0, height: 2)

        self.showAnimate()
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.removeAnimate()
    }
    
    @IBAction func btnMusic(_ sender: UIButton) {
        let umusic = UIImage(named: "umusic")
        let music = UIImage(named: "music")
        // Đảo ngược trạng thái nút
        sender.isSelected = !sender.isSelected
        
        // Kiểm tra trạng thái nút để thực hiện hành động tương ứng
        if sender.isSelected {
            // Trạng thái bật
            // Thực hiện hành động khi nút được bật
            sender.resignFirstResponder()
            sender.setBackgroundImage(music!, for: .selected)
            print("bat")
            
        } else {
            // Trạng thái tắt
            // Thực hiện hành động khi nút được tắt
            sender.resignFirstResponder()
            print("tat")
            sender.setBackgroundImage(umusic!, for: .normal)
            
        }
        // Yêu cầu vẽ lại nút
        sender.setNeedsDisplay()
    }
    
    @IBAction func btnAudio(_ sender: UIButton) {
        let uaudio = UIImage(named: "uaudio")
        let audio = UIImage(named: "audio")
        // Đảo ngược trạng thái nút
        sender.isSelected = !sender.isSelected
        
        // Kiểm tra trạng thái nút để thực hiện hành động tương ứng
        if sender.isSelected {
            // Trạng thái bật
            // Thực hiện hành động khi nút được bật
            sender.resignFirstResponder()
            sender.setBackgroundImage(audio!, for: .selected)
            print("bat")
            
        } else {
            // Trạng thái tắt
            // Thực hiện hành động khi nút được tắt
            sender.resignFirstResponder()
            print("tat")
            sender.setBackgroundImage(uaudio!, for: .normal)
            
        }
        // Yêu cầu vẽ lại nút
        sender.setNeedsDisplay()
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
