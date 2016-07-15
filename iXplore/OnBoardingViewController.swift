//
//  OnBoardingViewController.swift
//  iXplore
//
//  Created by David Xu on 7/13/16.
//  Copyright © 2016 David Xu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class OnBoardingViewController: UIViewController,FBSDKLoginButtonDelegate {
    var goToButton = UIBarButtonItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = FBSDKLoginButton()
        self.view.addSubview(button)
        let buttonFrameY:CGFloat = self.view.frame.height / 2
        button.frame = CGRect(x:120 , y: buttonFrameY, width: 150, height: 30)
        goToButton = UIBarButtonItem(title: "Main", style: .Plain, target: self, action: #selector(self.goToMainPage(_:)))
        self.navigationItem.setRightBarButtonItem(goToButton, animated: true)
        
        button.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if result.isCancelled == false{
            self.navigationController?.pushViewController(MapViewController(), animated: true)
            
        }
        else{
            print("log in failure")
        }
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("you have logged out")
    }
    
    func goToMainPage(sender: UIBarButtonItem){
        self.navigationController?.pushViewController(MapViewController(), animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
