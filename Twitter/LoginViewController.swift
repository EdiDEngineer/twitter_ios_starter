//
//  LoginViewController.swift
//  Twitter
//
//  Created by Edidiong Ekong on 21/07/2021.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.defaults.bool( forKey: "isLoggedIn") {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
         }
        
    }
    
    @IBAction func loginfunc(_ sender: Any) {
        
        let url = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url:url, success: {
            
            self.defaults.set(true, forKey: "isLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            self.dismiss(animated: true){
                
            }
        }, failure: { Error in
            print("Login")
        })
    
     }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
