//
//  authVC.swift
//  uberClone
//
//  Created by A on 3/26/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit

class authVC: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var emailLbl: roundedTextField!
    
    @IBOutlet weak var pwdLbl: roundedTextField!
    
    
    @IBOutlet weak var accountType: UISegmentedControl!
    
    var types = ["passenger", "driver"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addBindObserver()
        
        
        

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        recognizer.delegate = self
        
        recognizer.numberOfTapsRequired = 1
        
        self.view.addGestureRecognizer(recognizer)
    
    }

    @objc func dismissKeyboard() {
        
        self.view.endEditing(true)
        
    }

    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    private func getCredentials() -> [String: String] {
        
        var data: [String: String] = [String: String]()
        
        data["email"] = emailLbl.text!
        
        data["pwd"] = pwdLbl.text!
        
        data["type"] = types[accountType.selectedSegmentIndex]
        
        return data
        
    }
    
    
    @IBAction func loginPressed(_ sender: roundedBtn) {
        
        
        print("done")
        
        let email = emailLbl.text!
        
        let pwd = pwdLbl.text!
        
        let isDriver: Bool!
        
        if self.accountType.selectedSegmentIndex == 1 {
            
            isDriver = true
            
        } else { isDriver = false}
        
        AuthService.instance.signIn(email: email, pwd: pwd, isDriver: isDriver) { (status, error) in
            
            if status {
                
                if self.accountType.selectedSegmentIndex == 1 {
                    
                    AuthService.instance.checkAccount(accountType: "driver", completion: { (success) in
                        
                        if success {
                            
                            let homeVC =  self.storyboard?.instantiateViewController(withIdentifier: "homeVC")
                            
                            self.present(homeVC!, animated: true, completion: nil)
                            
                        } else {
                          
                            AuthService.instance.signOut(completion: { (status, error) in
                                
                                let alertController =  Helpers.instance.displayError(error: "No Such Account In Drivers Accounts")
                                
                                self.present(alertController, animated: true, completion: nil)
                            })
                          
                        }
                    })
                    
                } else {
                  
                    AuthService.instance.checkAccount(accountType: "user", completion: { (success) in
                        
                        if success {
                            
                            let homeVC =  self.storyboard?.instantiateViewController(withIdentifier: "homeVC")
                            
                            self.present(homeVC!, animated: true, completion: nil)
                            
                            
                        } else {
                            
                            AuthService.instance.signOut(completion: { (status, error) -> () in
                                
                                
                                let alertController =  Helpers.instance.displayError(error: "No Such Account In Users Accounts")
                                
                                self.present(alertController, animated: true, completion: nil)
                                
                            })
                            
                        }
                        

                            
                        })
                    
                    }
                    
                }
            
                
         else {
                
              let alertController = Helpers.instance.displayError(error: (error?.localizedDescription)!)
                
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    
    
    @IBAction func signUpPressed(_ sender: roundedBtn) {
        
        let credentials = getCredentials()
        
        let email = credentials["email"]
        
        let pwd = credentials["pwd"]
        
        var isDriver: Bool!
        
        if credentials["type"] == "driver" {
            
            isDriver = true
            
        } else {
            
            isDriver = false
        }
        
        AuthService.instance.signUp(email: email!, pwd: pwd!) { (status, error) in
            
            if status {
                
                DataService.instance.registerUser(Data: ["email": email!],isDriver: isDriver, completion: { (success, failureError) in
                    
                    if success {
                        
                        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeVC")
                        
                        self.present(homeVC!, animated: true, completion: nil)
                        
                    } else {
                        
                        Helpers.instance.displayError(error: failureError!.localizedDescription)
                    }
                    
                })
                
                
            } else {
                
                Helpers.instance.displayError(error: error!.localizedDescription)
            }
        }
        
    }
   
    
    
   


}
