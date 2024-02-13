//
//  PaginationInteractor.swift
//  TestPokemonApp
//
//  Created by Xenia on 13.02.2024.
//

import Foundation

class PaginationInteractor {
    func calculatePaginationRange(currentPage: Int, totalPageCount: Int, displayPageCount: Int) -> ClosedRange<Int> {
        let halfRange = displayPageCount / 2
        
        let lowerBound = max(1, currentPage - halfRange)
        let upperBound = min(totalPageCount, currentPage + halfRange)
        
        if currentPage - lowerBound < halfRange {
            return lowerBound...min(lowerBound + displayPageCount - 1, totalPageCount)
        } else if upperBound - currentPage < halfRange {
            return max(1, totalPageCount - displayPageCount + 1)...totalPageCount
        } else {
            return currentPage - halfRange...currentPage + halfRange
        }
    }
}
