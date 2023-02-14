//
//  RxFeedbackPagingViewModel.swift
//  RxFeedbackVsCLE
//
//  Created by Rezuan Bidzhiev on 06.01.2023.
//

import Foundation
import RxSwift
import RxFeedback

final class RxFeedbackPagingViewModel: PagingViewModel {
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
    let event = loadNextSubject.asObservable()
      .map { PagingEvent.loadNext }
 
    Observable.system(
      initialState: FeedbackPagingState(),
      reduce: { (state: FeedbackPagingState, event: PagingEvent) in
        var state = state
        FeedbackPagingState.reduce(state: &state, event: event)
        return state
      },
      scheduler: MainScheduler.asyncInstance,
      feedback: [
        bind { _ in
          return Bindings(subscriptions: [], events: [event])
        },
        react(request: { $0.nextPage }, effects: { page in
          loadSomeData(page: page, limit: limit)
            .observe(on: MainScheduler.instance)
            .map(PagingEvent.response)
        })
      ])
    .map(\.items)
    .map { $0.map(PagingSectionItem.init) }
    .map { [PagingSection(title: "section", items: $0)] }
    .observe(on: MainScheduler.asyncInstance)
    .bind(to: sectionsSubject)
    .disposed(by: disposeBag)
  }
}
