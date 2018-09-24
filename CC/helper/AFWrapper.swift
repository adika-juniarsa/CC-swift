//
//  request.swift
//  CC
//
//  Created by febi on 9/7/18.
//  Copyright © 2018 febi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AFWrapper: NSObject {
    
    static let sharedInstance = AFWrapper()
    
    func requestGETURL(_ strURL: String, params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        Alamofire.request(strURL, method: .get, parameters: params).responseJSON { (responseObject) -> Void in
                        
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
}
