//
//  PagingModel.swift
//  RxFeedbackVsCLE
//
//  Created by Rezuan Bidzhiev on 06.01.2023.
//

import Foundation
import Differentiator

struct PagingSection: AnimatableSectionModelType {
  var identity: Int {
    title.hashValue
  }
  
  var items: [PagingSectionItem]
  var title: String
  
  init(title: String, items: [PagingSectionItem]) {
    self.title = title
    self.items = items
  }
  
  init(original: PagingSection, items: [PagingSectionItem]) {
    self = original
    self.items = items
  }
}

struct PagingSectionItem: IdentifiableType, Equatable {
  let text: String
  
  var identity: Int {
    text.hashValue
  }
}

