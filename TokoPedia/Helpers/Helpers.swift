//
//  Helpers.swift
//  TokoPedia
//
//  Created by Mukesh mac on 04/06/18.
//  Copyright © 2018 Lakshman. All rights reserved.
//

import UIKit
import SDWebImage


//extension UIImageView {
//   
//}

extension UIStoryboard {
    enum Instance: String{
        case searchVC
        case filterVC
        case shopTypeVC
    }
   static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func instantiate(_ identifire: Instance)-> UIViewController{
        return instantiateViewController(withIdentifier: identifire.rawValue )
    }
}

