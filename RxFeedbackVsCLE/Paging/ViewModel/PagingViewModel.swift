//
//  PagingViewModel.swift
//  RxFeedbackVsCLE
//
//  Created by Rezuan Bidzhiev on 06.01.2023.
//

import Foundation
import RxSwift

protocol PagingViewModel {
  var loadNext: AnyObserver<Void> { get }
  var sections: Observable<[PagingSection]> { get }
}
