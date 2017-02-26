//
//  ViewController.swift
//  GitHubCommitFeed
//
//  Created by 酒井恭平 on 2017/02/26.
//  Copyright © 2017年 酒井恭平. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    let HTTP_GitHub_API = "https://api.github.com"
    let USERS = "/users/"
    
    let FOLLOWING = "/following"
    let EVENTS = "/events"
    
    
    var followingUser: [String : Int] = [:]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = "shoheiyokoyama"
        getUserInfo(userName)
        
//        getUserInfo("Kyohei-Sakai")
        
    }
    
    // ユーザ情報を取得する
    private func  getUserInfo(_ userName: String) {
        
        Alamofire.request(HTTP_GitHub_API + USERS + userName + FOLLOWING, method: .get)
        .responseJSON { response in
            
            guard let jsonObject = response.result.value else { return }
            
            let json = JSON(jsonObject)
            json.forEach { (_, json) in
                let name = json["login"].stringValue
                self.followingUser[name] = json["id"].intValue
            }
            
            print("あなたのフォロー：\(self.followingUser.count)")
            self.followingUser.forEach { key, value in
                print("Name: \(key), Id: \(value)")
            }
            
            self.getEvents(userName)
        }
        
    }
    
    // ユーザのアクティビティ情報を取得する
    private func getEvents(_ userName: String) {
        
        Alamofire.request(HTTP_GitHub_API + USERS + userName + EVENTS, method:.get)
        .responseJSON { response in
            
            guard let jsonObject = response.result.value else { return }
            let json = JSON(jsonObject)
            var events = 0
            json.forEach { (_, json) in
                let eventType = json["type"].stringValue
                let createDate = json["created_at"].stringValue
                
                print("Type: \(eventType), Date: \(createDate)")
                events += 1
            }
            print("イベント数： \(events)")
        }
        
    }
    

}


















