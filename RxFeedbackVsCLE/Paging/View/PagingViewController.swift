//
//  PagingViewController.swift
//  RxFeedbackVsCLE
//
//  Created by Rezuan Bidzhiev on 06.01.2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class PagingViewController: UIViewController {
  private let tableView = UITableView()
  
  private let viewModel: PagingViewModel
  
  private let disposeBag = DisposeBag()
  
  private let loadNextButton = UIBarButtonItem(title: "Load Next (tap twice if CLE)", style: .done, target: nil, action: nil)
  
  init(viewModel: PagingViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    makeUI()
    bindViewModel()
  }
  
  private func makeUI() {
    view.backgroundColor = .white
    
    navigationItem.setRightBarButton(loadNextButton, animated: true)
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
  
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  private func bindViewModel() {
    let dataSource = RxTableViewSectionedAnimatedDataSource<PagingSection> { _, tableView, indexPath, item in
      let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
      cell.textLabel?.text = item.text
      cell.textLabel?.numberOfLines = 0
      return cell
    }
    
    Observable.merge(
      loadNextButton.rx.tap.asObservable()
//      tableView.rx.reachedBottom(offset: 100).asObservable()
    )
    .bind(to: viewModel.loadNext)
    .disposed(by: disposeBag)
    
    viewModel.sections.bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
  }
}
