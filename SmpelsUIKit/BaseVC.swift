//
//  BaseVC.swift
//  SmpelsUIKit
//
//  Created by Tal Spektor on 24/01/2021.
//  Copyright © 2021 Tal Spektor. All rights reserved.
//

import UIKit

protocol BaseVC where Self: UIViewController {
    var topTitle: String { get }
}
