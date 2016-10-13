//
//  CoadeShareInit.swift
//  CoadeShare
//
//  Created by 千锋 on 16/10/12.
//  Copyright © 2016年 千锋. All rights reserved.
//

import Foundation
//网络请求基地址
// 一般项目均会又一个测试地址，与正式环境的不一样，所以一般我们会根据是否时DEBUG 模式改变baseUrl
#if DEBUG
let QFAppBaseURL = "http://10.12.155.20/PhalApi/Public/CodeShare/"
#else
 let QFAppBaseURL = "http://www.1000phone.tk/"
#endif
//图片资源基地址
let QFResourceBaseUrl = "http://www.1000phone.ml/upload/QFApi"
//短信发送的SDK的 appKey 和appSecret
let MobApp = "142d07ce785cb"
let MobSecret = "adecbf154b1728cb450ab56c0344e988";