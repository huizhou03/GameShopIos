//
//  Perfil.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 6/3/25.
//
import SwiftUI

//JSON
struct PerfilUsuario: Codable{
    var id: String
    var nombre: String
    var correo: String
    var  CP: String
    var newsletter: Bool
}

struct Perfil: View {
    @State private var imagenPerfil: UIImage? = UIImage(named: "perfilDefecto")
    @State private var perfilUsuario: PerfilUsuario = PerfilUsuario(id: "", nombre: "", correo: "", CP: "", newsletter: false)
    @State private var mostrarImagen: Bool = false
    @State var nombre: String = ""
    
    var body: some View {
        VStack{
            Button(action:{mostrarImagen.toggle()}){
                    if let imagen = imagenPerfil{
                        Image(uiImage: imagen)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2)
                        )}
                    }
                    .sheet(isPresented: $mostrarImagen) {
                    ElegirImagen(image: $imagenPerfil)
                    }
                
            TextField ("Nombre", text: $nombre)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.headline)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)
                .padding(.horizontal, 60)
                .foregroundStyle(Color.black)
            }
        }
    }
                                     
 struct ElegirImagen: UIViewControllerRepresentable {
     @Binding var image: UIImage?
     
     class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
         var parent: ElegirImagen
         
         init(parent: ElegirImagen) {
             self.parent = parent
         }
         
         func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
             if let uiImage = info[.originalImage] as? UIImage {
                 parent.image = uiImage
             }
             picker.dismiss(animated: true)
         }
     }
     
     func makeCoordinator() -> Coordinator {
         Coordinator(parent: self)
     }
     
     func makeUIViewController(context: Context) -> UIImagePickerController {
         let picker = UIImagePickerController()
         picker.delegate = context.coordinator
         picker.sourceType = .photoLibrary
         return picker
     }
     
     func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
 }

#Preview {
    Perfil()
}

