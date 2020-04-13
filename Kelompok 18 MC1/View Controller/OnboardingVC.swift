//
//  ViewController.swift
//  Page Control
//
//  Created by Mellysa Verenna on 13/04/20.
//  Copyright © 2020 Mellysa Verenna. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var continueOutlet: UIButton!
    
    var images: [String] = ["7","8","9","10"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = images.count
        
        for index in 0..<images.count{
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: images[index])
            self.scrollView.addSubview(imgView)
            
            print("ini image count: \(images.count)")
            print("ini image index: \(index)")
            print("ini isi index: \(images[index])")
        }
        
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width*CGFloat(images.count), height: scrollView.frame.size.height)
        
        scrollView.delegate = self
        
    }
    
    @IBAction func continueBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: true, completion: nil)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
}











