//
//  ClassicGameViewController.swift
//  DiamondGame
//
//  Created by CNTT on 5/31/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//
import UIKit

class Player {
    //MARK:Properties
    
    private var player_id:Int
    private var player_name:String
    private var player_password:String
    private var scoreClassic:Int
    private var scoreTime:Int
    
    
    //MARK: Contructors
    init?(player_id:Int, player_name:String,player_password:String, scoreClassic:Int,scoreTime:Int){// (init? co the khong tao duoc doi tuong)
        //khoi gan gia tri cho cac bien thanh phan
        
        //kiem tra dieu kien tao doi tuong tuong Meal
        self.player_id = player_id
        self.player_name = player_name
        self.player_password = player_password
        self.scoreClassic = scoreClassic
        self.scoreTime = scoreTime
        
        
    }
    //getter setter
    public func getPlayerId()->Int{
        return player_id
    }
    public func getName()->String{
        return player_name
    }
    public func getPassword()->String{
        return player_password
    }
    public func getScoreClassic()->Int{
        return scoreClassic
    }
    public func getScoreTime()->Int{
        return scoreTime
    }
    
    
}
