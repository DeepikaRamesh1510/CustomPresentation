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
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(self.tapRecognizer)
        return view
    }()
    
    private var currentState: State = .closed
    
    private lazy var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPopView))
    
    private lazy var popViewHeightConstraint: NSLayoutConstraint = self.popupView.heightAnchor.constraint(equalToConstant: 60)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(popupView)
        activateConstraints()
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            popupView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popViewHeightConstraint
        ])
    }

    @objc private func didTapPopView() {
        
        let state = currentState.opposite
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.popViewHeightConstraint.constant = 500
            case .closed:
                self.popViewHeightConstraint.constant = 60
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
                self.popViewHeightConstraint.constant = 500
            case .closed:
                self.popViewHeightConstraint.constant = 60
            }
        }
        transitionAnimator.startAnimation()
    }

}

