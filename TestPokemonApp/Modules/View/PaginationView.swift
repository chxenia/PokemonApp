//
//  PaginationView.swift
//  TestPokemonApp
//
//  Created by Xenia on 13.02.2024.
//

import SwiftUI

struct PaginationView: View {
    @Binding var currentPage: Int
    let totalPageCount: Int
    let action: (Int) -> Void
    let displayPageCount: Int
    let presenter: PaginationPresenter
    
    var body: some View {
        HStack(spacing: 2) {
            Button(action: {
                if currentPage > 1 {
                    currentPage = 1
                    action(1)
                }
            }) {
                Text("<<")
                    .padding()
            }
            .disabled(currentPage == 1)
            
            ForEach(presenter.calculatePaginationRange(currentPage: currentPage, totalPageCount: totalPageCount, displayPageCount: displayPageCount), id: \.self) { page in
                Button("\(page)") {
                    currentPage = page
                    action(page)
                }
                .padding()
                .background(currentPage == page ? Color.blue : Color.clear)
                .foregroundColor(currentPage == page ? Color.white : Color.blue)
                .clipShape(Circle())
            }
            
            Button(action: {
                if currentPage < totalPageCount {
                    currentPage = totalPageCount
                    action(totalPageCount)
                }
            }) {
                Text(">>")
            }
            .disabled(currentPage == totalPageCount)
        }
    }
    
 
}

