//
//  PageViewController.swift
//  Rodrigo Nascimento
//
//  Created by Rodrigo Nascimento on 25/04/16.
//  Copyright (c) 2016 Rodrigo Nascimento. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let pages = 4
    var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl = UIPageControl(frame: CGRectMake(0.0, 0.0, self.view.frame.width, 30.0))
        pageControl.pageIndicatorTintColor = UIColor(white: 0.9, alpha: 1)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.6745, green: 0.5765, blue: 0.3333, alpha: 0.5)
        pageControl.numberOfPages = pages
        
        self.view.addSubview(pageControl)
        self.view.bringSubviewToFront(pageControl)
        self.delegate = self

        self.dataSource = self
        self.view.backgroundColor = UIColor.whiteColor()

        let pageContentViewController = self.viewControllerAtIndex(0)
        self.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }

    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.pageControl.currentPage = (pageViewController.viewControllers![0] as! PageContentViewController).pageIndex!
    }

    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageContentViewController).pageIndex!
        index += 1
        if(index >= pages){
            return nil
        }
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageContentViewController).pageIndex!
        if(index <= 0){
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index : Int) -> UIViewController? {
        if((pages == 0) || (index >= pages)) {
            return nil
        }
        let identifier = NSString(format: "PageContentViewController%d", index) as String
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier(identifier) as! PageContentViewController
        
        pageContentViewController.pageIndex = index
        pageContentViewController.pageViewController = self
        return pageContentViewController
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
