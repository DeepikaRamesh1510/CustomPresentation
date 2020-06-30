//
//  ViewController.swift
//  CustomPresentation
//
//  Created by Deepika on 30/06/20.
//  Copyright © 2020 Deepika. All rights reserved.
//

import UIKit

private enum State {
    case closed
    case open
}

extension State {
    var opposite: State {
        switch self {
        case .closed:
            return .open
        case .open:
            return .closed
        }
    }
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

