//
//  CheckLinkHelper.swift
//  MemoryTestGame
//
//  Created by Andrii Pyvovarov on 11/24/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import Foundation

enum checkLinkHelper {
    case sub1(myParam: String)
    case sub3(myParam: String)
    case sub4(myParam: String)
    case sub5(myParam: String)
    case sub6(myParam: String)
    case sub7(myParam: String)
    case sub9(myParam: String)
}
extension checkLinkHelper {
    
    //MARK: - check url parametrs
    var checkParam : Bool {
        switch self {
            
        case .sub1(let myParam):
            let necessaryParams : [String] = ["FreeBSD", "Firefox", "Linux"]
            return checkParam(myParam: myParam, necessaryParams: necessaryParams)
        case .sub3(let myParam):
            let necessaryParams : [String] = ["Nexus", "Pixel", "Moto", "Google"]
            return checkParam(myParam: myParam, necessaryParams: necessaryParams)
        case .sub4(let myParam):
            let necessaryParams : [String] = ["1"]
            return checkParam(myParam: myParam, necessaryParams: necessaryParams)
        case .sub5(let myParam):
            let necessaryParams : [String] = ["1"]
            return checkParam(myParam: myParam, necessaryParams: necessaryParams)
        case .sub6(let myParam):
            let necessaryParams : [String] = ["AR"]
            return checkParam(myParam: myParam, necessaryParams: necessaryParams)
        case .sub7(let myParam):
            let necessaryParams : [String] = ["US", "PH", "NL", "GB", "IN", "IE"]
            return checkParam(myParam: myParam, necessaryParams: necessaryParams)
        case .sub9(let myParam):
            let necessaryParams : [String] = ["google", "bot", "adwords", "rawler", "spy", "o-http-client", "Dalvik/2.1.0 (Linux; U; Android 6.0.1; Nexus 5X Build/MTC20F)", "Dalvik/2.1.0 (Linux; U; Android 7.0; SM-G935F Build/NRD90M)", "Dalvik/2.1.0 (Linux; U; Android 7.0; WAS-LX1A Build/HUAWEIWAS-LX1A)"]
            return checkParam(myParam: myParam, necessaryParams: necessaryParams)
        }
    }
    private func checkParam(myParam: String, necessaryParams: [String]) -> Bool {
        for i in necessaryParams {
            if myParam.lowercased().contains(i.lowercased()){
                return true
            }
        }
        return false
    }
}
