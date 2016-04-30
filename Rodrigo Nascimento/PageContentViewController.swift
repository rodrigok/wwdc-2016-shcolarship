//
//  PageContentViewController.swift
//  Rodrigo Nascimento
//
//  Created by Rodrigo Nascimento on 25/04/16.
//  Copyright (c) 2016 Rodrigo Nascimento. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    var pageIndex: Int?
    var pageViewController: UIPageViewController!

    @IBAction func closeAction(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "TutorialCompleted")
        pageViewController.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
