//
//  ProfileView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-17.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        ZStack{
            SignUpView()
        }
        .toolbar(.hidden)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
