//
//  WebService.swift
//  tableDemoAPP
//
//  Created by Sds mac mini on 07/12/18.
//  Copyright © 2018 straightdrive.co.in. All rights reserved.
//

import Foundation
import Alamofire

enum ApiEndPoints {
    
}

class WebService: NSObject {
    
    var serviceArray = [WebServiceRequest]()
    
    static let sharedService : WebService = {
        let instance = WebService()
        return instance
    }()
    
    var URL = "http://surya-interview.appspot.com"
    private override init() {
    }
    
    func startRequest(service : WebServiceRequest){
        service.start()
        serviceArray.append(service)
        print("services started = \(self.serviceArray.count)")
    }
    
    func stopRequest(service : WebServiceRequest){
        service.stop()
    }
    
    func closeService(service : WebServiceRequest?){
        guard service != nil else{
            return
        }
        if self.serviceArray.contains(service!) == true{
            self.serviceArray.remove(at: serviceArray.index(of: service!)!)
        }
        print("service pending = \(self.serviceArray.count)")
    }
    
    func cancelAllRequests(){
        
        for service in self.serviceArray {
            self.stopRequest(service: service)
        }
        print("service pending = \(self.serviceArray.count)")
        self.serviceArray.removeAll()
    }
    
}
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

