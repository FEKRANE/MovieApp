//
//  Router.swift
//  MovieApp
//
//  Created by FEKRANE on 16/1/2024.
//

import UIKit

protocol Router: AnyObject {
        
    var routerRootController: UIViewController { get }
    
    func setRoot(_ vc: UIViewController)
    
    func redirect(to viewController: UIViewController,
                  animated: Bool)
    
    func pop(animated: Bool)
}


