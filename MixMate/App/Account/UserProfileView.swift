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
    
    @State var profileImage: Image = Image(systemName: "person.circle")
    
    @State var showPhotoActionSheet: Bool = false
    @State var showPhotoLibrary: Bool = false
    
    @State var selectedPhoto: PhotosPickerItem?
    
    @State var errorAlert: Bool = false
    @State var successAlert: Bool = false
    
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
                    .onChange(of: viewModel.pfpData) {
                        Task {
                            await MainActor.run {
                                profileImage = Image(uiImage: UIImage(data: viewModel.pfpData!)!)
                            }
                        }
                    }
                    .onTapGesture {
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
                    .onChange(of: selectedPhoto) { newValue in
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
            }
            
            // MARK:  profile detail
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 5) {
                    Text("Name: ")
                        .bold()
                        TextField("name", text: $viewModel.name)
                        .textContentType(.name)
                }
                
                HStack(spacing: 5) {
                    Text("Email: ")
                        .bold()
                    TextField("new email", text: $viewModel.email)
                        .textContentType(.emailAddress)

 
                }
                HStack(spacing: 5){
                    Text("Member since: ").bold()
                    Text(viewModel.sinceDate)
                }
            }
        }
        .padding()
        
        Button("update") {
            Task {
                successAlert = await updateUserProfile()
                errorAlert = !successAlert
            }
        }
        .alert("update failed", isPresented: $errorAlert) {
            Button("OK", role: .cancel) {}
        }
        .alert("update successful", isPresented: $successAlert) {
            Button("OK", role: .cancel) {}
                }
    }
    
    func updateUserProfile() async -> Bool{
        do {
            var success = await Supabase.shared.updateUserEmail(newEmail: viewModel.email)
            success = await Supabase.shared.updateUserName(newName: viewModel.name)
            if let data = try await selectedPhoto?.loadTransferable(type: Data.self) {
                await Supabase.shared.uploadProfilePicture(pictureData: data)
            }
            else {
                success = false
            }
            return success
        }catch {
            print("Error: \(error)")
            return false
        }
    }
}

#Preview {
    UserProfileView()
    .environmentObject(AuthenticationManager())
}
