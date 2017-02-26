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
    
    var followingUser: [String : Int] = [:]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = "shoheiyokoyama"
        getUserInfo(userName)
        
        getUserInfo("Kyohei-Sakai")
        
    }
    
    // ユーザ情報を取得する
    func  getUserInfo(_ userName: String) {
//        Alamofire.request(HTTP_GitHub_API + USERS + userName, method: .get)
        Alamofire.request(HTTP_GitHub_API + USERS + userName + FOLLOWING, method: .get)
            .responseJSON { response in
                
                // responseのresultプロパティのvalueプロパティをコンソールに出力
//                print(response.result.value ?? "nil")
                
                guard let object = response.result.value else { return }
                
                let json = JSON(object)
//                print(json)
                json.forEach { (_, json) in
                    let name = json["login"].stringValue
                    self.followingUser[name] = json["id"].intValue
//                    print("Name: \(name), Id: \(self.followingUser[name])")
                    
                }
                
                print("あなたのフォロー：\(self.followingUser.count)")
                self.followingUser.forEach { key, value in
                    print("Name: \(key), Id: \(value)")
                }
        }
        
    }

}


