//
//  CSUserModel.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/13.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
import YYModel
class CSUserModel: NSObject {
    //用户作为一个单例
    static var SharedUser = CSUserModel()
    private override init() {
        super.init()
        // 取出沙盒数据 配置默认用户
        if let userInfo = NSUserDefaults.standardUserDefaults().objectForKey(String(CSUserModel)){
            self.yy_modelSetWithJSON(userInfo)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var address = ""
    var avatar = ""
    var birthday = ""
    var email = ""
    var gender = ""
    var id:String?
    var name = ""
    var nickname = ""
    var phone = ""
    
    class func isLogin() -> Bool{
        return SharedUser.id != nil
        
    }
   
    //根据获取到的用户信息，配置用户数据 
    class func loggin(with UserInfo:[String:AnyObject]){
        //用YYMode 做字典转模型
        //SharedUser.setValuesForKeysWithDictionary(UserInfo)
        SharedUser.yy_modelSetWithDictionary(UserInfo)
        
        // 将用户数据储存到沙河里
        NSUserDefaults.standardUserDefaults().setObject(SharedUser.yy_modelToJSONObject(), forKey: String(CSUserModel))
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
}
