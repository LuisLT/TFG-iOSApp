//
//  ViewControllerStart.swift
//  Alertas10
//
//  Created by Luis Llorente Tovar on 10/6/17.
//  Copyright © 2017 UPM. All rights reserved.
//

import UIKit

class ViewControllerStart: UIViewController {

    @IBOutlet weak var address: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               
        if segue.identifier == "addr" {
            if let vc = segue.destination as? ViewController {
               vc.address = address.text!
            }
        }
        
            
        
    }


}
