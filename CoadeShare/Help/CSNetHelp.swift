//
//  CSNetHelp.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/13.
//  Copyright © 2016年 千锋. All rights reserved.
//

import UIKit
import Alamofire
public class CSNetHelp: NSObject {
    //在Alamofire的基础上封装一个网络帮助类，把不需要的参数隐藏掉，调用的时候更加方便，还可以在不同的请求之间方便的进行更改
    public class func request(method:Alamofire.Method = .POST,URLString:String = QFAppBaseURL,parameters:[String:AnyObject],headers:[String:String]? = nil)-> Alamofire.Request{
        return Alamofire.request(method, URLString, parameters: parameters, encoding: ParameterEncoding.URLEncodedInURL, headers: headers)
    }
}

extension Request{
    //封装网络回调方法，可以更方便的统一处理错误，在具体数据处理时更简单
      func responseJSON(comletionHandler:(data:AnyObject,success:Bool)-> Void)-> Request {
        
        return responseJSON(completionHandler: { (response) in
            let result = response.result
            //声明需要返回的两个参数
            var success = false
            var data:AnyObject = "网络有问题，请重试"
            //判断Http请求有无成功
            if result.isSuccess{
                let serverData = result.value as! NSDictionary
                //取出服务器的返回码
                let serverRet = serverData["ret"] as! Int
                if serverRet != 200 {
                    //请求出现问题
                    data = serverData["msg"]!
                }else{
                    let retValue = serverData["data"] as! NSDictionary
                    //取出操作返回码
                    let retCode = retValue["code"] as! Int
                    if retCode == 0{
                        success = true
                        data = retValue["data"]!
                    }else{
                        data = retValue["msg"]!
                    }
                }
                
            }else{
                data = (result.error?.localizedDescription)!
            }
            //回调传入的闭包，如果成功返回请求到的数据，如果失败就返回失败的原因
            comletionHandler(data: data, success: success
            )
        })
    }
}