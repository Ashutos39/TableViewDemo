//
//  ViewController.swift
//  tableDemoAPP
//
//  Created by Sds mac mini on 06/12/18.
//  Copyright © 2018 straightdrive.co.in. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD
import Kingfisher


class ViewController: UIViewController {
    @IBOutlet var TableView: UITableView!
    @IBOutlet var EmailIdTxtFld: UITextField!
    @IBOutlet var SubmitBtn: UIButton!{
        didSet {
            SubmitBtn.layer.cornerRadius = 2.0
            SubmitBtn.layer.borderColor = UIColor.lightGray.cgColor
            SubmitBtn.layer.borderWidth = 1.0
        }
    }
    
    @IBOutlet var popUpView: UIView!
    
    var dataArray:ALLProfile? = nil
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.rowHeight = 80.0
        getAllDetails()
        setUpUI()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpUI(){
        if dataArray?.indiProfileList?.array.count == 0 || dataArray?.indiProfileList?.array == nil{
            popUpView.isHidden = false
        }else{
            popUpView.isHidden = true
            scheduledTimerWithTimeInterval()
        }
        
    }
    
    @IBAction func SubmitBtnPressed(_ sender: Any) {
        view.endEditing(true)
        if EmailIdTxtFld.text == ""{
            showAlert(withTitleMessageAndAction: "Warning!!!", message: "Please enter your mail Id", action: false)
            return
        }
        if EmailIdTxtFld.text != "" && !isValidEmail(testStr: EmailIdTxtFld.text!){
            showAlert(withTitleMessageAndAction: "Warning!!!!", message: "Please add a valid mail Id", action: false)
            return
        }
        getData()
        
    }
    
    func getData(){
        SVProgressHUD.show(withStatus: "Please wait...")
        self.view.isUserInteractionEnabled = false
        WebService.sharedService.dataFromAPI(emailId: EmailIdTxtFld.text) { (data, error) in
            SVProgressHUD.dismiss()
            self.view.isUserInteractionEnabled = true
            if error != nil{
                self.showAlert(withTitleMessageAndAction: "Warning!!!!", message: "Kindly Check Your internet connection and try Again.", action: false)
                return
            }
            
            if let retrievedData = data as? [String: AnyObject]{
                let DataArray = retrievedData["items"] as! [[String : AnyObject]]
                ALLProfile.insertToDbWithProfileDatails(indiProfile: DataArray)
                UserDefaults.standard.set(self.EmailIdTxtFld.text, forKey: "EmailID")
                self.getAllDetails()
                self.TableView.reloadData()
                self.popUpView.isHidden = true
            }
        }
    }
    
    func getAllDetails() {
        dataArray = ALLProfile.fetchProfileList()
    }
    
    // Alert
    func showAlert(withTitleMessageAndAction title:String, message:String , action: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        if action {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action : UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
        } else{
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    //autoSync
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ViewController.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting() {
        if Connectivity.isConnectedToInternet() == false{
            return
        }
      
        WebService.sharedService.dataFromAPI(emailId: UserDefaults.standard.string(forKey: "EmailID")) { (data, error) in
            self.view.isUserInteractionEnabled = true
            if error != nil{
                self.showAlert(withTitleMessageAndAction: "Warning!!!!", message: "Kindly Check Your internet connection and try Again.", action: false)
                return
            }
            ALLProfile.resetAllRecords()
            if let retrievedData = data as? [String: AnyObject]{
                let DataArray = retrievedData["items"] as! [[String : AnyObject]]
                ALLProfile.insertToDbWithProfileDatails(indiProfile: DataArray)
                self.getAllDetails()
                self.TableView.reloadData()
                self.popUpView.isHidden = true
            }
        }
    }
    
    
    
}

//TableView Datasource and delegate
extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray?.indiProfileList?.array != nil{
            return (dataArray?.indiProfileList?.array.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DataTableViewCell
        cell.selectionStyle = .none
       let indiProfile = dataArray?.indiProfileList?[indexPath.row] as! Profiles
        
        cell.emailIDShowingLbl.text = indiProfile.email
        cell.fullNameLbl.text = indiProfile.name
        let url = URL(string: indiProfile.imageUrl!)
        cell.ProfileImageView.kf.setImage(with: url)
        return cell
    }
}


