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
    
    private lazy var popupView: UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(self.tapRecognizer)
        return view
    }()
    
    private var currentState: State = .closed
    
    private lazy var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPopView))
    
    private lazy var popViewBottomConstraint: NSLayoutConstraint = self.popupView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 440)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(popupView)
        activateConstraints()
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            popViewBottomConstraint,
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popupView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }

    @objc private func didTapPopView() {
        
        let state = currentState.opposite
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.popViewBottomConstraint.constant = 0
            case .closed:
                self.popViewBottomConstraint.constant = 440
            }
            self.view.layoutIfNeeded()
        })
        transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            @unknown default:
                assertionFailure("Unknown case")
            }
            switch self.currentState {
            case .open:
                self.popViewBottomConstraint.constant = 0
            case .closed:
                self.popViewBottomConstraint.constant = 440
            }
        }
        transitionAnimator.startAnimation()
    }

}

