//
//  PagingState.swift
//  RxFeedbackVsCLE
//
//  Created by Rezuan Bidzhiev on 06.01.2023.
//

import Foundation

struct FeedbackPagingState {
  var items: [String] = []
  var shouldLoadNext: Bool = false
  var page: Int = 1
  
  var nextPage: Int? {
    shouldLoadNext ? page : nil
  }
  
  static func reduce(state: inout FeedbackPagingState, event: PagingEvent) {
    switch event {
    case .loadNext:
      state.shouldLoadNext = true
    case .response(let items):
      state.items.append(contentsOf: items)
      state.page += 1
      state.shouldLoadNext = false
    }
  }
}

struct CLEPagingState {
  var items: [String] = []
  var page: Int = 1

  static func nextPage(state: CLEPagingState, event: PagingEvent) -> Int? {
    guard case .loadNext = event else { return nil }
    return state.page
  }

  static func reduce(state: inout CLEPagingState, event: PagingEvent) {
    guard case let .response(items) = event else { return }
    state.items.append(contentsOf: items)
    state.page += 1
  }
}

enum PagingEvent: Equatable {
  case loadNext
  case response([String])
}
