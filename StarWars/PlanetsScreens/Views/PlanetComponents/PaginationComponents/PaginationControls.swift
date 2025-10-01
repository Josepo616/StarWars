//
//  PaginationControls.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/29/25.
//

import SwiftUI

//import ViewInspector

struct PaginationControls: View {

    @Binding var currentPage: Int
    let totalPages: Int
    let pageNumbersToShow: [Int]

    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {

                    PageButton(
                        number: 1,
                        isSelected: currentPage == 0
                    ) {
                        currentPage = 0
                    }

                    ForEach(pageNumbersToShow, id: \.self) { page in
                        if page == -1 {
                            Text("...")
                                .padding(10)
                                .foregroundColor(.gray)
                        } else {
                            PageButton(
                                number: page + 1,
                                isSelected: currentPage == page
                            ) {
                                currentPage = page
                            }
                        }
                    }

                    if totalPages > 1 {
                        PageButton(
                            number: totalPages,
                            isSelected: currentPage == totalPages - 1
                        ) {
                            currentPage = totalPages - 1
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal)
    }
}
