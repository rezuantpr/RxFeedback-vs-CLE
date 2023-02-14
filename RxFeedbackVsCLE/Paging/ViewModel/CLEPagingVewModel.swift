//
//  CLEPagingVewModel.swift
//  RxFeedbackVsCLE
//
//  Created by Rezuan Bidzhiev on 06.01.2023.
//

import Foundation
import RxSwift
import Cause_Logic_Effect

final class CLEPagingVewModel: PagingViewModel {
  var loadNext: AnyObserver<Void> {
    loadNextSubject.asObserver()
  }
  
  var sections: Observable<[PagingSection]> {
    sectionsSubject.asObservable()
  }
  
  
  private let loadNextSubject = PublishSubject<Void>()
  private let sectionsSubject = BehaviorSubject<[PagingSection]>(value: [])

  private let disposeBag = DisposeBag()
  
  init() {
    let limit = 20
    let input = loadNextSubject.asObservable()
      .map { PagingEvent.loadNext }
    
    cycle(input: input,
          initialState: CLEPagingState(),
          reduce: CLEPagingState.reduce,
          reaction: reaction(
            request: CLEPagingState.nextPage,
            effect: { page in
              loadSomeData(page: page, limit: limit)
                .observe(on: MainScheduler.instance)
                .map(PagingEvent.response)
            }))
    .map(\.items)
    .map { $0.map(PagingSectionItem.init) }
    .map { [PagingSection(title: "section", items: $0)] }
    .observe(on: MainScheduler.asyncInstance)
    .bind(to: sectionsSubject)
    .disposed(by: disposeBag)
  }
}
