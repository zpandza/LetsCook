//
//  ForthCreateRecipeView.swift
//  LetsCook
//
//  Created by Zvonimir Pandza on 12.12.2020..
//

import SwiftUI
import FirebaseStorage

struct ImagePicker: UIViewControllerRepresentable {
    
    @StateObject var viewModel: CreateRecipeViewModel
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(parent: self, viewModel: viewModel)
    }
    
    @Binding var shown: Bool
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePic = UIImagePickerController()
        imagePic.sourceType = .photoLibrary
        imagePic.delegate = context.coordinator
        return imagePic
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        print("update")
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        
        var parent: ImagePicker!
        var viewModel: CreateRecipeViewModel
        
        init(parent: ImagePicker, viewModel: CreateRecipeViewModel) {
            self.parent = parent
            self.viewModel = viewModel
        }
        
        func getImageName() {
            var tempName = String(viewModel.recipeName.split(separator: " ")[0])
            tempName.append("_\(Int.random(in: 1..<100))_\(Int.random(in: 1..<100))")
            viewModel.imageName = tempName
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.shown.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            
            let image = info[.originalImage] as! UIImage
            getImageName()
            let storage = Storage.storage()
            storage.reference().child(viewModel.imageName).putData(image.jpegData(compressionQuality: 0.40)!, metadata: nil) { (_, err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                print("success")
                self.parent.shown.toggle()
            }
            
            
        }
    }
}
struct ForthCreateRecipeView: View {
    
    var viewModel: CreateRecipeViewModel
    @State var shown: Bool = false
    var body: some View {
        
        Button(action: {
            shown.toggle()
        }){
             Text("Select image")
        }.sheet(isPresented: $shown){
            ImagePicker(viewModel: viewModel, shown: $shown )
        }
        
        Button(action: {
            
            viewModel.createRecipe()
            
            viewModel.currentPage += 1
            viewModel.currentProgress += 25
        }){
            Text("Finish")
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.green).opacity(0.7))
        .foregroundColor(.white)
    }
}

struct ForthCreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        ForthCreateRecipeView(viewModel: CreateRecipeViewModel())
    }
}
