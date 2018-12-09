//
//  WebServiceRequestForData.swift
//  tableDemoAPP
//
//  Created by Sds mac mini on 07/12/18.
//  Copyright © 2018 straightdrive.co.in. All rights reserved.
//

import Foundation
import UIKit

extension WebService{
    
    func dataFromAPI(emailId : String?,block : @escaping WSCompletionBlock){
        let service = WebServiceToGetAllDataFromAPI(manager: self, emailId: emailId, block: block)
        self.startRequest(service: service)
        
    }
}
