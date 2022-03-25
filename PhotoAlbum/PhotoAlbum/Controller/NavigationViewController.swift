//
//  NavigationViewController.swift
//  PhotoAlbum
//
//  Created by 안상희 on 2022/03/25.
//

import UIKit

class NavigationViewController: UINavigationController {
    private lazy var viewController = storyboard?.instantiateViewController(withIdentifier: "VC") as? ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.topItem?.title = "PhotoAlbum"
        guard let viewController = viewController else { return }
        viewControllers.append(viewController)
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "VC") as? ViewController else {
            print("Error")
            return
        }
        print("")
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}
