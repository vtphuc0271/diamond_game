//
//  DatabaseLayer.swift
//  FoodManagement2023
//
//  Created by CNTT on 5/26/23.
//  Copyright Â© 2023 fit.tdc. All rights reserved.
//

import Foundation
import UIKit
import os.log
class DatabaseLayer{
    //MARK: Database Properties
    private let DB_NAME = "users.sql"
    private let DB_PATH:String?
    private let database:FMDatabase?
    
    //MARK: Tables properties
    //1.Table meals
    // table user
    private let PLAYER_TABLE_NAME = "players"
    private let PLAYER_ID = "play_id"
    private let PLAYER_NAME = "name"
    private let PLAYER_PASSWORD = "password"
    private let CLASSIC_SCORE = "classic_score"
    private let TIME_SCORE = "time_score"
    
    //MARK: Contructors
    init() {
        //lay duong dan cua cac thu muc trong ung dung ios
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        //khoi tao cho DB_PATH
        DB_PATH = directories[0] + "/" + DB_NAME
        //khoi tao doi tuong database
        database = FMDatabase(path: DB_PATH)
        //kiem tra su thanh cong khi khoi tao database
        if database != nil{
            os_log("khoi tao co so du lieu thanh cong")
            //tao bang cho co so du lieu
            let _ = tablesCreation()
            
        }else{
            os_log("khong the khoi tao co so du lieu")
        }
    }
    
    /////////////////////////////////////////////////////////////////////////
    //MARK: Dinh nghia cac phuong thuc Premitries
    /////////////////////////////////////////////////////////////////////////
    
    //1. Kiem tra su ton tai cua database
    private func isDatabaseExist()->Bool{
        return (database != nil)
    }
    
    //2.Mo database
    private func open() ->Bool{
        var ok = false
        if isDatabaseExist(){
            if database!.open() {
                ok = true
                os_log("mo co so du lieu thanh cong")
            }else{
                os_log("khong the mo co so du lieu")
            }
        }
        
        return ok
    }
    //3. dong co so du lieu
    private func close() -> Bool{
        var ok = false
        
        if isDatabaseExist(){
            if database!.close(){
                ok = true
                os_log("dong co so du lieu thanh cong ")
            }else{
                os_log("khong the dong co so du lieu")
            }
        }
        
        return ok
    }
    //4. tao cac bang du lieu
    private func tablesCreation() ->Bool{
        var ok = false
        if open(){
            //xay dung cau lenh sql
            
            //Tao bang player
            let sqlPlayer = "CREATE TABLE \(PLAYER_TABLE_NAME)("
                + PLAYER_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, "
                + PLAYER_NAME + " TEXT, "
                + PLAYER_PASSWORD + " TEXT, "
                + CLASSIC_SCORE + " INTEGER, "
                + TIME_SCORE + " INTEGER)"
            
            
            // thuc thi
            if  database!.executeStatements(sqlPlayer){
                ok = true
                os_log("tao bang du lieu user thanh cong ")
            }else{
                os_log("khong the tao bang user")
            }
            
            
            
            let _ = close()
        }
        
        return ok
    }
    
    
    /////////////////////////////////////////////////////////////////////////
    //MARK: Dinh nghia cac ham API
    /////////////////////////////////////////////////////////////////////////
    //1. ghi bien meal vao database
    
    
    public func insertUser(player:Player!)-> Bool{
        var ok = false
        if open(){
            // xay dung cau lenh sql
            let sql = "INSERT INTO \(PLAYER_TABLE_NAME)(\(PLAYER_NAME), \(PLAYER_PASSWORD),\(CLASSIC_SCORE),\(TIME_SCORE)) VALUES (?, ?,?,?)"
            //Buoc 2 goi lenh thuc thi sql de ghi meal vao database
            if database!.executeUpdate(sql, withArgumentsIn: [player.getName(), player.getPassword(),player.getScoreClassic(),player.getScoreTime()]){
                ok = true
                os_log("bien player duoc ghi thanh cong vao database")
            }else{
                os_log("khong the ghi duoc bien player vao database")
            }
            
            let _ = close()
        }
        
        return ok
    }
    
    
    
    
    //2 doc toan bi meal tu co so du lieu ve mealList cua tableView
    public func getAllPlayerByClassicScore(listPlayers: inout [Player]){
        if open(){
            var result:FMResultSet?
            // cau lenh sql
            let sql = "SELECT * FROM \(PLAYER_TABLE_NAME) ORDER BY \(CLASSIC_SCORE) DESC"
            
            //bat exeption
            do{
                // thuc thi cau lenh sql
                result = try database!.executeQuery(sql, values: nil)
            }
            catch{
                os_log("khong the doc user tu databse")
            }
            //             Xu li du lieu doc ve
            if let result = result{
                while(result.next()){
                    let player_id = result.int(forColumn: PLAYER_ID)
                    let player_name = result.string(forColumn: PLAYER_NAME) ?? ""
                    let password = result.string(forColumn: PLAYER_PASSWORD) ?? ""
                    let scoreClassic = result.int(forColumn: CLASSIC_SCORE)
                    let scoreTime = result.int(forColumn: TIME_SCORE)
                    
                    //tao bien meal tu du lieu doc ve
                    if let player = Player(player_id: Int(player_id), player_name: player_name, player_password: password,scoreClassic: Int(scoreClassic),scoreTime: Int(scoreTime)){
                        listPlayers.append(player)
                    }
                    
                }
            }
            
        }
        let _ = close()
    }
    
    public func getAllPlayer(players: inout [Player]){
        if open(){
            var result:FMResultSet?
            // cau lenh sql
            let sql = "SELECT * FROM \(PLAYER_TABLE_NAME)"
            
            //bat exeption
            do{
                // thuc thi cau lenh sql
                result = try database!.executeQuery(sql, values: nil)
            }
            catch{
                os_log("khong the doc player tu databse")
            }
            // Xu li du lieu doc ve
            if let result = result{
                while(result.next()){
                    let player_id = result.int(forColumn: PLAYER_ID)
                    let player_name = result.string(forColumn: PLAYER_NAME) ?? ""
                    let password = result.string(forColumn: PLAYER_PASSWORD) ?? ""
                    let scoreClassic = result.int(forColumn: CLASSIC_SCORE)
                    let scoreTime = result.int(forColumn: TIME_SCORE)
                    
                    //tao bien player tu du lieu doc ve
                    if let player = Player(player_id: Int(player_id), player_name: player_name, player_password: password,scoreClassic: Int(scoreClassic),scoreTime: Int(scoreTime)){
                        players.append(player)
                    }
                    
                    
                    
                }
            }
            
        }
        let _ = close()
    }
    
    public func getAllPlayerByTimeScore(listPlayers: inout [Player]){
        if open(){
            var result:FMResultSet?
            // cau lenh sql
            let sql = "SELECT * FROM \(PLAYER_TABLE_NAME) ORDER BY \(TIME_SCORE) DESC"
            
            //bat exeption
            do{
                // thuc thi cau lenh sql
                result = try database!.executeQuery(sql, values: nil)
            }
            catch{
                os_log("khong the doc user tu databse")
            }
            //             Xu li du lieu doc ve
            if let result = result{
                while(result.next()){
                    let player_id = result.int(forColumn: PLAYER_ID)
                    let player_name = result.string(forColumn: PLAYER_NAME) ?? ""
                    let password = result.string(forColumn: PLAYER_PASSWORD) ?? ""
                    let scoreClassic = result.int(forColumn: CLASSIC_SCORE)
                    let scoreTime = result.int(forColumn: TIME_SCORE)
                    
                    //tao bien meal tu du lieu doc ve
                    if let player = Player(player_id: Int(player_id), player_name: player_name, player_password: password,scoreClassic: Int(scoreClassic),scoreTime: Int(scoreTime)){
                        listPlayers.append(player)
                    }
                    
                }
            }
            
        }
        let _ = close()
    }
    
    public func checkUser(username:String,password:String)->String{
        if open(){
            var result:FMResultSet?
            // cau lenh sql
            let sql = "SELECT * FROM \(PLAYER_TABLE_NAME) WHERE \(PLAYER_NAME) = \(username) AND \(PLAYER_PASSWORD) = \(password)"
            
            //bat exeption
            do{
                // thuc thi cau lenh sql
                result = try database!.executeQuery(sql, values: nil)
            }
            catch{
                os_log("khong the doc user tu databse")
            }
            //             Xu li du lieu doc ve
            
            if let result = result{
                while(result.next()){
                    let player_name = result.string(forColumn:PLAYER_NAME)
                    
                    return player_name!
                    
                }
                
            }
            
        }
        let _ = close()
        return ""
    }
    
    
}
