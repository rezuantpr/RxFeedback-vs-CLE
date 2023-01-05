//
//  UIScrollView+Extensions.swift
//  RxFeedbackVsCLE
//
//  Created by Rezuan Bidzhiev on 06.01.2023.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
  func reachedBottom(offset: CGFloat = 0.0) -> ControlEvent<Void> {
    let source = contentOffset.map { contentOffset in
      let visibleHeight = self.base.frame.height - self.base.contentInset.top - self.base.contentInset.bottom
      let y = contentOffset.y + self.base.contentInset.top
      let threshold = max(offset, self.base.contentSize.height - visibleHeight)
      return y >= threshold
    }
      .distinctUntilChanged()
      .filter { $0 }
      .map { _ in () }
    return ControlEvent(events: source)
  }
}

public extension Reactive where Base: UIViewController {
  
  var viewWillAppear: ControlEvent<Bool> {
    let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
    return ControlEvent(events: source)
  }
}

