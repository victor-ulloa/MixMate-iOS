//
//  AddItemView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-16.
//

import SwiftUI

struct AddItemView: View {
    
    @Binding var isPresented: Bool
    @State var searchText: String = ""
    let items = ["Apple", "Banana", "Cherry", "Date", "Fig", "Grape", "Kiwi"]
    
    var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            List(filteredItems, id: \.self) { item in
                Button {
                    isPresented.toggle()
                } label: {
                    Text(item)
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    @State var showingAddItem = false
    return AddItemView(isPresented: $showingAddItem)
}
