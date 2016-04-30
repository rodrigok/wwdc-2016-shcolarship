//
//  ViewController.swift
//  Rodrigo Nascimento
//
//  Created by Rodrigo Nascimento on 20/04/16.
//  Copyright (c) 2016 Rodrigo Nascimento. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var aboutMeScrollView: UIScrollView!
    @IBOutlet weak var projectsScrollView: UIScrollView!
    @IBOutlet weak var educationScrollView: UIScrollView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var brasiliaMapImageView: UIImageView!
    @IBOutlet weak var trescoroasMapImageView: UIImageView!
    @IBOutlet weak var poaMapImageView: UIImageView!
    @IBOutlet weak var taquaraMapImageView: UIImageView!
    @IBOutlet weak var sanfranciscoMapImageView: UIImageView!

    @IBAction func contactMeAction(sender: AnyObject) {
        let emailTitle = "Scholarship App Contact"
        let toRecipents = ["rodrigoknascimento@gmail.com"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setToRecipients(toRecipents)
        
        self.presentViewController(mc, animated: true, completion: nil)
    }
    
    func startTutorial() {
        if (NSUserDefaults.standardUserDefaults().integerForKey("TutorialCompleted") != 1) {
            self.performSegueWithIdentifier("segueTutorial", sender: self)
        }
    }
    
    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError?) {
        switch result.rawValue {
            case MFMailComposeResultSent.rawValue:
                let alert = UIAlertController(title: "Mail sent", message:"Thanks for your contact", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                self.presentViewController(alert, animated: true){}
            case MFMailComposeResultFailed.rawValue:
                let alert = UIAlertController(title: "Ooops, mail sent failure", message:error!.localizedDescription, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                self.presentViewController(alert, animated: true){}
            default:
                break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func setCardStyle (view: AnyObject) {
        view.subviews.first?.layer.masksToBounds = true
        view.subviews.first?.layer.backgroundColor = UIColor(rgba: "#292b36").CGColor
        view.subviews.first?.layer.borderColor = UIColor(rgba: "#3A3E4F").CGColor
        view.subviews.first?.layer.borderWidth = 1
        
        if let title:UILabel = view.subviews.first?.subviews[1] as? UILabel {
            let mutableAttributedString = NSMutableAttributedString(string: title.text!)
            if mutableAttributedString.mutableString.containsString("print(") {
                mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(rgba: "#00aba7"), range: NSRange(location:0, length:5))
                mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(rgba: "#FFFFFF"), range: NSRange(location:5, length:1))
                mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(rgba: "#FFFFFF"), range: NSRange(location:mutableAttributedString.length-1, length:1))
            }
            title.attributedText = mutableAttributedString
            title.font = UIFont(name: "Menlo-Regular", size: 18)
        }
    }
    
    func mapImageTaped(sender: UITapGestureRecognizer) {
        self.performSegueWithIdentifier("segueMapView", sender: sender.view)
    }
    
    func handleMapImageTap(view: UIImageView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.mapImageTaped(_:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        view.addGestureRecognizer(tap)
        view.userInteractionEnabled = true
    }
    
    func setContentViewShadow() {
        self.content.layer.shadowColor = UIColor.blackColor().CGColor
        self.content.layer.shadowOffset = CGSize(width: 0, height: -50)
        self.content.layer.shadowOpacity = 0.8
        self.content.layer.shadowRadius = 30
    }
    
    func setAvatarShadowAndBorder() {
        self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2
        self.avatar.clipsToBounds = true
        self.avatar.superview!.layer.cornerRadius = self.avatar.superview!.frame.size.width / 2
        self.avatar.superview!.layer.shadowColor = UIColor.blackColor().CGColor
        self.avatar.superview!.layer.shadowOffset = CGSize(width: 0.4, height: 1)
        self.avatar.superview!.layer.shadowOpacity = 0.2
        self.avatar.superview!.layer.shadowRadius = 0.5
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Remove comments to start tutorial always
//        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "TutorialCompleted")
        
        self.setAvatarShadowAndBorder()

        self.setContentViewShadow()
        
        for view in aboutMeScrollView.subviews {
            setCardStyle(view)
        }
        
        for view in educationScrollView.subviews {
            setCardStyle(view)
        }
        
        for view in projectsScrollView.subviews {
            setCardStyle(view)
        }
        
        handleMapImageTap(brasiliaMapImageView)
        handleMapImageTap(trescoroasMapImageView)
        handleMapImageTap(poaMapImageView)
        handleMapImageTap(taquaraMapImageView)
        handleMapImageTap(sanfranciscoMapImageView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.startTutorial();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueTutorial") {
            return;
        }
        
        let vc = segue.destinationViewController as! MapViewController

        switch sender!.tag {
        case 0:
            vc.setCoord(-15.8363347, lng: -47.8095463)
            vc.title = "Brasília, DF, Brazil"
        case 1:
            vc.setCoord(-29.4716888, lng: -50.7839087, delta: 2)
            vc.title = "Três Coroas, RS, Brazil"
        case 2:
            vc.setCoord(-30.060472, lng: -51.175532, delta: 2)
            vc.title = "Porto Alegre, RS, Brazil"
        case 3:
            vc.setCoord(-29.6556283, lng: -50.7740479, delta: 2)
            vc.title = "Taquara, RS, Brazil"
        case 4:
            vc.setCoord(37.783879, lng: -122.401254, delta: 2)
            vc.title = "San Francisco, CA, USA"
        default:
            NSLog("invalid map")
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}

