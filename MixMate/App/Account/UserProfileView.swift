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
    @ObservedObject var viewModel = AccountViewModel()
    @State var imageSelection: PhotosPickerItem? = nil
    @State var uiImage: UIImage? = nil
    @State var nameEditMode: Bool = false
    @State var emailEditMode: Bool = false
    
    @State var didError: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            // MARK: - Profile picture
            VStack(spacing: 10) {
                Image(uiImage: UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
                photoPickerButton
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
        .onChange(of: imageSelection) {
            Task {
                if let data = try? await imageSelection?.loadTransferable(type: Data.self) {
                    uiImage = UIImage(data:data)
                    return
                }
            }
        }
    }
    
    
    var photoPickerButton: some View {
          PhotosPicker(selection: $imageSelection, matching: .images, photoLibrary: .shared()) {
              Text("Select Profile Picture")
          }
    }
}

#Preview {
    UserProfileView()
    .environmentObject(AuthenticationManager())
}
