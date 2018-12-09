//
//  WebServiceToGetAllDataFromAPI.swift
//  tableDemoAPP
//
//  Created by Sds mac mini on 07/12/18.
//  Copyright © 2018 straightdrive.co.in. All rights reserved.
//

import Foundation
import Alamofire

class WebServiceToGetAllDataFromAPI : WebServiceRequest{
    
    init(manager : WebService,emailId:String?, block : @escaping WSCompletionBlock) {
        
        super.init(manager : manager, block: block)
        
        url = manager.URL + "/list"
        
        if let emailId=emailId{
            self.body?["emailId"]=emailId
        }
        
        httpMethod = HTTPMethod.post
    }
    
    override func responseSuccess(data : Any?){
        super.responseSuccess(data: data)
    }    
}
