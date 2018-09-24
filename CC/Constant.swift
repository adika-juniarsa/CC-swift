//
//  Constant.swift
//  CC
//
//  Created by febi on 9/5/18.
//  Copyright © 2018 febi. All rights reserved.
//

import Foundation

struct Constant{
    struct URL {
        static let BASE_URL = "https://trelevant.herokuapp.com"
        static let APPKEY = "vBUpPXE8ddpWp9QJ"
        static let CHAIN_ID = "146"
        static let API_V1 = (BASE_URL + "/api/v1")
        static let API_VNCR = (BASE_URL + "/api/vncr")
        static let TERMS_OF_USE = (BASE_URL + "/terms_of_use?appkey=" + APPKEY)
        static let PRIVACY_POLICY = (BASE_URL + "/privacy_policy?appkey=" + APPKEY)
        static let FB_PAGE_URL = (BASE_URL + "/url/", CHAIN_ID, "/facebook")
        static let TWITTER_PAGE_URL = (BASE_URL + "/url/", CHAIN_ID, "/twitter")
        static let INSTAGRAM_URL = (BASE_URL + "/url/", CHAIN_ID + "/instagram")
        static let MENU_URL = (BASE_URL + "/url/" + CHAIN_ID + "/menu")
        static let FAQ_URL = (BASE_URL + "/url/" + CHAIN_ID, "/faq")
        static let KEYCHAINCC = "keychain_CC"
    }
    
    struct APICALL {
        static let KEYCHAIN_GENERATE = (URL.API_V1 + "/keychain/generate/")
        static let LOGIN = (URL.API_V1 + "/user/login/")
        static let LOOUT = (URL.API_V1 + "/user/logout/")
    }
}

struct ValidationError: Error {
    public let message: String
    public init(message m: String) {
        message = m
    }
}




