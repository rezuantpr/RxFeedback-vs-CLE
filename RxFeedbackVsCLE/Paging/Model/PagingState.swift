//
//  PagingState.swift
//  RxFeedbackVsCLE
//
//  Created by Rezuan Bidzhiev on 06.01.2023.
//

import Foundation

struct PagingState {
  var items: [String] = []
  var shouldLoadNext: Bool = false
  var page: Int = 1
  
  var nextPage: Int? {
    shouldLoadNext ? page : nil
  }
  
  static func reduce(state: inout PagingState, event: PagingEvent) {
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

enum PagingEvent {
  case loadNext
  case response([String])
}
