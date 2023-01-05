//
//  ViewController.swift
//  RxFeedbackVsCLE
//
//  Created by Rezuan Bidzhiev on 06.01.2023.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

  let button1 = UIButton()
  let button2 = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    button1.setTitle("RxFeedback", for: .normal)
    button2.setTitle("CLE", for: .normal)
    
    button1.backgroundColor = .darkGray
    button2.backgroundColor = .gray
    
    view.addSubview(button1)
    view.addSubview(button2)
    
    button1.translatesAutoresizingMaskIntoConstraints = false
    button1.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    button1.heightAnchor.constraint(equalToConstant: 44).isActive = true
    button1.widthAnchor.constraint(equalToConstant: 200).isActive = true
    button1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    button2.translatesAutoresizingMaskIntoConstraints = false
    button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 16).isActive = true
    button2.heightAnchor.constraint(equalToConstant: 44).isActive = true
    button2.widthAnchor.constraint(equalToConstant: 200).isActive = true
    button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  
    _ = button1.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.navigationController?.pushViewController(PagingViewController(viewModel: RxFeedbackPagingViewModel()), animated: true)
      })
    
    _ = button2.rx.tap
      .subscribe(onNext: { [weak self] _ in
        self?.navigationController?.pushViewController(PagingViewController(viewModel: CLEPagingVewModel()), animated: true)
      })
  }


}

