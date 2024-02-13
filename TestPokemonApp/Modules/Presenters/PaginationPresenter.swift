//
//  PaginationPresenter.swift
//  TestPokemonApp
//
//  Created by Xenia on 13.02.2024.
//

import Foundation

class PaginationPresenter {
    private let interactor: PaginationInteractor
    
    init(interactor: PaginationInteractor) {
        self.interactor = interactor
    }
    
    func calculatePaginationRange(currentPage: Int, totalPageCount: Int, displayPageCount: Int) -> ClosedRange<Int> {
        return interactor.calculatePaginationRange(currentPage: currentPage, totalPageCount: totalPageCount, displayPageCount: displayPageCount)
    }
}
