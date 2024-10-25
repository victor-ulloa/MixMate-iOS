//
//  UserProfileView.swift
//  MixMate
//
//  Created by Chaoyi Wu on 2024-09-27.
//

import SwiftUI
import PhotosUI

struct UserProfileView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @ObservedObject var viewModel = UserProfileViewModel()
    
    @State var nameEditMode: Bool = false
    @State var emailEditMode: Bool = false
    
    @State var profileImage = Image(systemName:"person.circle")
    @State var showPhotoActionSheet: Bool = false
    @State var showPhotoLibrary: Bool = false
    @State var selectedPhoto: PhotosPickerItem?
    
    @State var didError: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            // MARK: - Profile picture
            VStack(spacing: 10) {
                profileImage
                    .resizable()
                    .frame(width: 150, height: 150)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
                    .scaledToFill()
                    .onTapGesture {
                        print("tapped")
                        showPhotoActionSheet.toggle()
                    }
                    .confirmationDialog("Select A Profile Picture", isPresented: $showPhotoActionSheet) {
                        Button {
                            showPhotoLibrary.toggle()
                        } label: {
                            Text("Photo Library")
                        }
                    }
                    .photosPicker(isPresented: $showPhotoLibrary, selection: $selectedPhoto, photoLibrary: .shared())
                    .onChange(of: selectedPhoto, perform: { newValue in
                        guard let photoItem = selectedPhoto else {
                            return
                        }
                        Task {
                            if let photoData = try await photoItem.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: photoData){
                                await MainActor.run {
                                    profileImage = Image(uiImage: uiImage)
                                }
                            }
                            
                        }
                    }
                    )
                
                
            }
            
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 5) {
                    Text("Name: ")
                        .bold()
                    
                    if (nameEditMode) {
                        TextField("name", text: $viewModel.name)
                        Button {
                            nameEditMode = false
                        } label: {
                            Text("Cancel")
                        }
                        Button{
                            Task {
                                let result = await Supabase.shared.updateUserName(newName: viewModel.name)
                                didError = !result
                                nameEditMode = didError
                            }
                        } label: {
                            Text("Update")
                        }
                        .alert("update failed",
                               isPresented: $didError) {
                            Button("OK", role: .cancel) { }
                        }
                    }
                    else {
                        Text(viewModel.name)
                        Spacer()
                        Button {
                            Task {
                                nameEditMode = true
                            }
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                    }
                }
                
                HStack(spacing: 5) {
                    Text("Email: ")
                        .bold()
                    
                    if (emailEditMode) {
                        TextField("new email", text: $viewModel.email)
                        
                        Button {
                            emailEditMode = false
                        } label: {
                            Text("Cancel")
                        }
                        Button {
                            Task {
                                let result = await Supabase.shared.updateUserEmail(newEmail: viewModel.email)
                                didError = !result
                                emailEditMode = didError
                            }
                        } label: {
                            Text("Update")
                        }
                        .alert("update failed",
                            isPresented: $didError) {
                            Button("OK", role: .cancel) { }
                        }
                    }
                    else {
                        Text(viewModel.email)
                        Spacer()
                        Button {
                            Task {
                                emailEditMode = true
                            }
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                    }
 
                }
                HStack(spacing: 5){
                    Text("Member since: ").bold()
                    Text(viewModel.sinceDate)
                }
            }
        }
        .padding()
    }
    
}

#Preview {
    UserProfileView()
    .environmentObject(AuthenticationManager())
}
