//
//  ClassicGameViewController.swift
//  DiamondGame
//
//  Created by CNTT on 5/31/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class ClassicGameViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var gamePlayView: UIView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var lblBackgroundProgress: UILabel!
    @IBOutlet weak var lblBackgroundTotalTime: UILabel!
    @IBOutlet weak var lblTotalTime: UILabel!
    
    // Game play
    private let rows: Int = 9
    private let cols: Int = 7

    // Score
    @IBOutlet weak var lblScore: UILabel!
    private var score: Int = 0
    private var currentScore: Int = 0
    private var scoreStep: Int = 10
    
    // Progress to next level
    @IBOutlet weak var lblProgress: UILabel!
    
    // Level
    @IBOutlet weak var lblLevel: UILabel!
    private var currentLevel: Int = 1
    private var scorePerLevel: Int = 500
    private var currentLevelScore: Int = 0
    
    // Step
    @IBOutlet weak var lblStep: UILabel!
    private var step: Int = 15
    private var currentStep: Int = 0
    private var stepPerLevel: Int = 10
    
    // Diamonds
    private let diamondWidth: CGFloat = 50
    private let diamondHeight: CGFloat = 50
    private let diamonds = ["blue", "green", "pink", "red", "white", "violet"]
    private var listDiamond = [[UIButton]]()
    private var listRemove = [UIButton]()
    
    // Check and store click button
    private var isFirstClick = true
    private var firstBtn: UIButton!
    private var secondBtn: UIButton!
    private var rowFirst = 0, rowSecond = 0, colFirst = 0, colSecond = 0
    private var dFirst = 0, dSecond = 0
    
    // Multiple
    @IBOutlet weak var lblCooldownMultiple: UILabel!
    @IBOutlet weak var btnMultiple: UIButton!
    
    // Swap
    private var isSwap = false
    private var swapFirst: UIButton!
    private var swapSecond: UIButton!
    @IBOutlet weak var btnSwap: UIButton!
    
    // Random
    private var isRandom = false
    @IBOutlet weak var btnRandom: UIButton!
    
    // Times
    @IBOutlet weak var btnTimes: UIButton!
    
    // Timer
    private var timerFirst: Timer!
    private var timerSecond: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tạo UIImageView và thiết lập contentMode
        let backgroundImage = UIImage(named: "background2")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        
        // Thêm backgroundImageView làm child view của self.view
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        
        // thiet lap cac rang buoc cho view
        self.gamePlayView.translatesAutoresizingMaskIntoConstraints = false
        self.gamePlayView.layer.masksToBounds = true
        self.gamePlayView.layer.cornerRadius = 10.0
        self.gamePlayView.backgroundColor = UIColor(red: 106/255, green: 0/255, blue: 157/255, alpha: 0.7)
        
        self.playView.isOpaque = false
        self.playView.translatesAutoresizingMaskIntoConstraints = false
        self.playView.layer.masksToBounds = true
        self.playView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
        
        self.view.bringSubviewToFront(playView)
        self.headerView.layer.masksToBounds = true
        self.headerView.layer.cornerRadius = 10.0
        self.headerView.backgroundColor = UIColor(red: 192/255, green: 116/255, blue: 204/255, alpha: 1)
        
        lblBackgroundTotalTime.layer.masksToBounds = true
        lblBackgroundTotalTime.layer.cornerRadius = 8
        lblBackgroundTotalTime.frame.size.height = 16
        
        lblTotalTime.layer.masksToBounds = true
        lblTotalTime.layer.cornerRadius = 7
        lblTotalTime.frame.size.height = 14
        lblTotalTime.frame.size.width = 298
        lblTotalTime.frame.origin.x = 16
        
        // xet giao dien label
        lblLevel.layer.masksToBounds = true
        lblLevel.layer.cornerRadius = 5.0
        
        lblScore.layer.masksToBounds = true
        lblScore.layer.cornerRadius = 5.0
        
        // xet giao dien button
        btnPause.layer.cornerRadius = 10.0
        btnPause.layer.shadowColor = UIColor.black.cgColor
        btnPause.layer.shadowOpacity = 0.5
        btnPause.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        // set progress
        lblBackgroundProgress.layer.cornerRadius = 8
        lblBackgroundProgress.layer.masksToBounds = true
        lblBackgroundProgress.frame.size.height = 16
        lblBackgroundProgress.frame.size.width = 263
        
        lblProgress.layer.cornerRadius = 7
        lblProgress.layer.masksToBounds = true
        lblProgress.frame.size.height = 14
        
        // Set boosts button
        btnMultiple.layer.cornerRadius = 10
        btnMultiple.clipsToBounds = true
        
        btnSwap.layer.cornerRadius = 10
        btnSwap.clipsToBounds = true
        
        btnRandom.layer.cornerRadius = 10
        btnRandom.clipsToBounds = true
        
        btnTimes.layer.cornerRadius = 10
        btnTimes.clipsToBounds = true
        btnTimes.isEnabled = false
        btnTimes.alpha = 0.5
        
        lblStep.layer.cornerRadius = 13
        lblStep.clipsToBounds = true
        lblStep.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.9450980392, blue: 1, alpha: 1)
        
        // Set default score
        lblScore.text = score.description
        
        // Set default level
        lblLevel.text = currentLevel.description
        currentLevelScore = currentLevel * scorePerLevel
        
        // Set default step
        currentStep = step
        
        // Set max size for listDiamond
        listDiamond.reserveCapacity(rows)
        for _ in 0..<rows {
            var row = [UIButton]()
            row.reserveCapacity(cols)
            listDiamond.append(row)
        }
        
        // Set cooldown multiple
        lblCooldownMultiple.frame.size.width = 0
        lblCooldownMultiple.layer.cornerRadius = 5
        lblCooldownMultiple.clipsToBounds = true
        lblCooldownMultiple.frame.size.height = 10
        
        // Create diamond in game area
        createDiamond()
        
        // Start timer autoPlayGame
        timerSecond = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(autoPlayGame), userInfo: nil, repeats: true)
    }
    
    @IBAction func btnPause(_ sender: Any) {
        self.ShowPause()
    }
    
    func ShowPause(){
        let PauseOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gamePausePopupID") as! PauseViewController
        self.addChild(PauseOverVC)
        PauseOverVC.view.frame = self.view.frame
        self.view.addSubview(PauseOverVC.view)
        PauseOverVC.didMove(toParent: self)
    }
    
    // Function multipleBtn: x2 score in 5s when user click on this button
    @IBAction func multipleBtn(_ sender: Any) {
        lblCooldownMultiple.frame.origin.x = 15
        lblCooldownMultiple.frame.size.width = 60
        lblCooldownMultiple.backgroundColor = #colorLiteral(red: 0.3595216039, green: 0.4142087434, blue: 1, alpha: 1)
        
        let percentPerTimes = 100 / (5 / 0.5)
        var percentRemain = 100.0
        let timerCooldown = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            percentRemain -= percentPerTimes
            self.lblCooldownMultiple.frame.size.width = CGFloat(60 * percentRemain / 100)
        }
        scoreStep *= 2
        print("timer start boost")
        Timer.scheduledTimer(withTimeInterval: 5.5, repeats: false) { timer in
            self.scoreStep /= 2
            timerCooldown.invalidate()
            print("timer finish boost")
        }
    }
    
    // Function swapBtn
    @IBAction func swapBtn(_ sender: Any) {
        isSwap = true
        isFirstClick = true
    }
    
    // Function randomBtn
    @IBAction func randomBtn(_ sender: Any) {
        if let _ = sender as? UIButton {
            isRandom = true
            
            listRemove = []
            for i in 0..<rows {
                for j in 0..<cols {
                    listRemove.append(listDiamond[i][j])
                }
            }
            
            for i in 0..<listRemove.count {
                
                // Remove background of each element
                listRemove[i].tag = -1
                listRemove[i].setImage(nil, for: .normal)
            }
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                self.isRandom = false
            }
        }
    }
    
    // Function autoPlayGame
    @objc func autoPlayGame(_ sender: AnyObject) {
        checkAndRemove()
        generateDiamond()
        slideDiamond()
        
        lblScore.text = score.description
        lblStep.text = currentStep.description
        
        lblProgress.frame.size.width = CGFloat(261 * (Float(score) / Float(currentLevelScore)))
        
        if currentStep == 0 {
            print("game over")
        }
        
        if score >= currentLevelScore {
            currentLevel += 1
            currentLevelScore = currentLevel * scorePerLevel
            lblLevel.text = currentLevel.description
            score = 0
            currentStep = step + ((currentLevel - 1) * stepPerLevel)
        }
    }
    
    // MARK: Function createDiamond
    private func createDiamond() {
        
        // Set parent frame to create list diamond
        var btnDiamond = CGRect(x: 0, y: 0, width: diamondWidth, height: diamondHeight)
        
        // Loop create list diamond
        var i = 0, j = 0
        while i < rows {
            j = 0
            while j < cols {
                
                // Random index in list diamonds
                let random = Int.random(in: 0..<diamonds.count)
                
                // Declare diamond button
                let btn = UIButton(type: .system)
                btn.frame = btnDiamond
                btn.addTarget(self, action: #selector(btnDiamondPressed), for: .touchUpInside)
                let img = UIImage(named: diamonds[random])?.withRenderingMode(.alwaysOriginal)
                btn.tag = random
                btn.setTitle("\(i)-\(j)", for: .normal)
                btn.setImage(img, for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 5.0)
                btn.layer.borderWidth = 1.0
                btn.layer.borderColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                
                // Add diamond button into listDiamond
                listDiamond[i] += [btn]
                
                // Check start game
                if checkStartGame(i: i, j: j) {
                    
                    // If true -> add diamond button into view and set next position
                    playView.addSubview(btn)
                    btnDiamond.origin.x += btnDiamond.size.width
                } else {
                    
                    // If false -> remove diamond button in listDiamond
                    listDiamond[i].remove(at: j)
                    j -= 1
                }
                j += 1
            }
            
            // Set new position to create in next row
            btnDiamond.origin.x = 0
            btnDiamond.origin.y += btnDiamond.size.height
            i += 1
        }
    }
    
    // Function checkStartGame
    private func checkStartGame(i: Int, j: Int) -> Bool {
        
        // If there exist 3 adjacent diamond button -> false
        if i >= 2 && listDiamond[i][j].tag == listDiamond[i - 1][j].tag && listDiamond[i][j].tag == listDiamond[i - 2][j].tag {
            return false
        }
        if j >= 2 && listDiamond[i][j].tag == listDiamond[i][j - 1].tag && listDiamond[i][j].tag == listDiamond[i][j - 2].tag {
            return false
        }
        
        // Default -> true
        return true
    }
    
    // Function buttonDiamondPressed: When user click on a diamond button
    @objc func btnDiamondPressed(_ sender: AnyObject) {
        
        // Check if sender is an UIButton
        if let btn = sender as? UIButton {
            if isFirstClick {
                if isSwap {
                    swapFirst = btn
                } else {
                    firstBtn = btn
                    
                    // Start timer runTimer
                    timerFirst = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
                }
            } else {
                if isSwap {
                    swapSecond = btn
                    
                    // Get current diamond of firstBtn and secondBtn
                    let dSwapFirst = swapFirst.tag
                    let dSwapSecond = swapSecond.tag
                    
                    // Swap firstBtn and secondBtn
                    swapFirst.setImage(UIImage(named: diamonds[dSwapSecond])?.withRenderingMode(.alwaysOriginal), for: .normal)
                    swapSecond.setImage(UIImage(named: diamonds[dSwapFirst])?.withRenderingMode(.alwaysOriginal), for: .normal)
                    
                    swapFirst.tag = dSwapSecond
                    swapSecond.tag = dSwapFirst
                    
                    isSwap = false
                } else {
                    secondBtn = btn
                    
                    // Stop timer runTimer
                    timerFirst!.invalidate()
                    firstBtn.isHidden = false
                    
                    let _ = changeImageButton()
                }
            }
            
            isFirstClick = !isFirstClick
        }
    }
    
    // Function runTimer
    @objc func runTimer(_ sender: AnyObject) {
        firstBtn.isHidden = !firstBtn.isHidden
    }
    
    // MARK: Function changeImageButton
    private func changeImageButton() {
        
        // Get row and column of firstBtn and secondBtn
        rowFirst = Int((firstBtn.title(for: .normal)?.split(separator: "-")[0])!)!
        rowSecond = Int((secondBtn.title(for: .normal)?.split(separator: "-")[0])!)!
        
        colFirst = Int((firstBtn.title(for: .normal)?.split(separator: "-")[1])!)!
        colSecond = Int((secondBtn.title(for: .normal)?.split(separator: "-")[1])!)!
        
        // Get current diamond of firstBtn and secondBtn
        dFirst = firstBtn.tag
        dSecond = secondBtn.tag
        
        // Check user's move
        let moveLeft = rowFirst == rowSecond && colFirst - 1 == colSecond
        let moveRight = rowFirst == rowSecond && colFirst + 1 == colSecond
        let moveUp = rowFirst - 1 == rowSecond && colFirst == colSecond
        let moveDown = rowFirst + 1 == rowSecond && colFirst == colSecond
        
        if (moveLeft || moveRight || moveUp || moveDown) && (dFirst != dSecond) {
            
            // Swap firstBtn and secondBtn
            firstBtn.setImage(UIImage(named: diamonds[dSecond])?.withRenderingMode(.alwaysOriginal), for: .normal)
            secondBtn.setImage(UIImage(named: diamonds[dFirst])?.withRenderingMode(.alwaysOriginal), for: .normal)
            
            firstBtn.tag = dSecond
            secondBtn.tag = dFirst
            
            // If user's move can't create at least 3 adjacent diamond
            if !checkThree() {
                
                // Swap firstBtn and secondBtn again
                firstBtn.setImage(UIImage(named: diamonds[dFirst])?.withRenderingMode(.alwaysOriginal), for: .normal)
                secondBtn.setImage(UIImage(named: diamonds[dSecond])?.withRenderingMode(.alwaysOriginal), for: .normal)
                
                firstBtn.tag = dFirst
                secondBtn.tag = dSecond
            } else {
                currentStep -= 1
            }
        }
    }
    
    // MARK: Fuction checkAndRemove
    private func checkAndRemove() {
        listRemove = []
        
        let _ = checkFive()
        let _ = checkFour()
        let _ = checkThree()
        
        // If has value to remove
        if listRemove.count != 0 {
            for i in 0..<listRemove.count {
                
                // Remove background of each element
                listRemove[i].tag = -1
                listRemove[i].setImage(nil, for: .normal)
                currentScore += scoreStep
                
            }
            
            if !isRandom {
                score += currentScore
                //                lblScore.text = score.description
            }
            
            // Fill the removed diamond
            currentScore = 0
            slideDiamond()
        }
    }
    
    // Function checkThree: Check if exist 3 adjacent diamond
    private func checkThree() -> Bool {
        var flag = false
        
        for i in 0..<rows {
            for j in 0..<(cols - 2) {
                if listDiamond[i][j].tag == listDiamond[i][j + 1].tag && listDiamond[i][j].tag == listDiamond[i][j + 2].tag {
                    flag = true
                    listRemove += [listDiamond[i][j], listDiamond[i][j + 1], listDiamond[i][j + 2]]
                }
            }
        }
        
        for i in 0..<(rows - 2) {
            for j in 0..<cols {
                if listDiamond[i][j].tag == listDiamond[i + 1][j].tag && listDiamond[i][j].tag == listDiamond[i + 2][j].tag {
                    flag = true
                    listRemove += [listDiamond[i][j], listDiamond[i + 1][j], listDiamond[i + 2][j]]
                }
            }
        }
        
        return flag
    }
    
    // Function checkFour: Check if exist 4 adjacent diamond
    private func checkFour() -> Bool {
        var flag = false
        
        for i in 0..<rows {
            for j in 0..<(cols - 3) {
                if listDiamond[i][j].tag == listDiamond[i][j + 1].tag && listDiamond[i][j].tag == listDiamond[i][j + 2].tag && listDiamond[i][j].tag == listDiamond[i][j + 3].tag {
                    flag = true
                    listRemove += [listDiamond[i][j], listDiamond[i][j + 1], listDiamond[i][j + 2], listDiamond[i][j + 3]]
                }
            }
        }
        
        for i in 0..<(rows - 3) {
            for j in 0..<cols {
                if listDiamond[i][j].tag == listDiamond[i + 1][j].tag && listDiamond[i][j].tag == listDiamond[i + 2][j].tag && listDiamond[i][j].tag == listDiamond[i + 3][j].tag {
                    flag = true
                    listRemove += [listDiamond[i][j], listDiamond[i + 1][j], listDiamond[i + 2][j], listDiamond[i + 3][j]]
                }
            }
        }
        
        return flag
    }
    
    // Function checkFive: Check if exist 5 adjacent diamond
    private func checkFive() -> Bool {
        var flag = false
        
        for i in 0..<rows {
            for j in 0..<(cols - 4) {
                if listDiamond[i][j].tag == listDiamond[i][j + 1].tag && listDiamond[i][j].tag == listDiamond[i][j + 2].tag && listDiamond[i][j].tag == listDiamond[i][j + 3].tag && listDiamond[i][j].tag == listDiamond[i][j + 4].tag {
                    flag = true
                    listRemove += [listDiamond[i][j], listDiamond[i][j + 1], listDiamond[i][j + 2], listDiamond[i][j + 3], listDiamond[i][j + 4]]
                }
            }
        }
        
        for i in 0..<(rows - 4) {
            for j in 0..<cols {
                if listDiamond[i][j].tag == listDiamond[i + 1][j].tag && listDiamond[i][j].tag == listDiamond[i + 2][j].tag && listDiamond[i][j].tag == listDiamond[i + 3][j].tag && listDiamond[i][j].tag == listDiamond[i + 4][j].tag {
                    flag = true
                    listRemove += [listDiamond[i][j], listDiamond[i + 1][j], listDiamond[i + 2][j], listDiamond[i + 3][j], listDiamond[i + 4][j]]
                }
            }
        }
        
        return flag
    }
    
    // Function slideDiamond: Fill the empty with upper diamond
    private func slideDiamond() {
        for i in 0..<cols {
            var ind = rows - 1
            for j in (0..<rows).reversed() {
                if !(listDiamond[j][i].tag == -1) {
                    listDiamond[ind][i].tag = listDiamond[j][i].tag
                    listDiamond[ind][i].setImage(listDiamond[j][i].image(for: .normal), for: .normal)
                    ind -= 1
                }
            }
            if 0 <= ind {
                for r in (0...ind).reversed() {
                    listDiamond[r][i].tag = -1
                    listDiamond[r][i].setImage(nil, for: .normal)
                }
            }
        }
    }
    
    // Function generateDiamond: Generate random diamond in list diamonds
    // and add to head column
    private func generateDiamond() {
        for j in 0..<cols {
            if listDiamond[0][j].tag == -1 {
                listDiamond[0][j].tag = Int.random(in: 0..<diamonds.count)
                listDiamond[0][j].setImage(UIImage(named: diamonds[listDiamond[0][j].tag])?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
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

