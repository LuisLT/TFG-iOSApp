//
//  ViewController2.swift
//  QRCodeReader
//
//  Created by Luis Llorente Tovar on 11/7/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
     var address : String!

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = address!

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

}
