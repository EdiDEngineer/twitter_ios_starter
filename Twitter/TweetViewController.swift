//
//  TweetViewController.swift
//  Twitter
//
//  Created by Edidiong Ekong on 30/07/2021.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    

    @IBOutlet weak var tweetText: UITextView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
      tweetText.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tweetAction(_ sender: Any) {
        if !tweetText.text.isEmpty {
            TwitterAPICaller.client?.postTweet(tweetString: tweetText.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: {_ in
                            })
            
        }else{
         self.dismiss(animated: true, completion: nil)
        }
        
    
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
