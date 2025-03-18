import SwiftUI

struct Perfil: View {
    @State private var imagenPerfil: UIImage? = UIImage(named: "perfilDefecto")
    @State private var mostrarImagen: Bool = false
    @State private var nombre: String = ""
    @State private var direccionPostal: String = ""
    @State private var correo: String = ""
    @State private var suscrito: Bool = false
    @State private var usuarioAutenticado: Usuario? = nil
    @State var mostrarAlerta: Bool = false
    @State var modificarDatos: Bool = false
    @Binding var estaAutenticado: Bool
    @ObservedObject var gestDatos: GestorDatos 


    var body: some View {
        VStack {
            Button(action: { mostrarImagen.toggle() }) {
                if let imagen = imagenPerfil {
                    Image(uiImage: imagen)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                }
            }
            .sheet(isPresented: $mostrarImagen) {
                ElegirImagen(image: $imagenPerfil)
            }
            
            Form {
                Section(header: Text("Datos personales")) {
                    TextField("Nombre", text: $nombre)
                        .disabled(!modificarDatos)
                    TextField("Dirección Postal", text: $direccionPostal)
                        .disabled(!modificarDatos)
                    TextField("Correo", text: $correo)
                        .disabled(true)
                    Toggle("Suscribirse a la Newsletter", isOn: $suscrito)
                        .disabled(!modificarDatos)
                }
                
                Button(action: {
                    if modificarDatos {
                        // Usamos la función cargarJSONUsuario para guardar los datos
                        let usuarioModificado = Usuario(
                            id: usuarioAutenticado?.id ?? "",
                            nombre: nombre,
                            correo: correo,
                            dirPostal: direccionPostal,
                            newsletter: suscrito
                        )
                        // Llamamos a la función para actualizar el JSON con los nuevos datos
                        gestDatos.cargarJSONUsuario(correoUsuario: gestDatos.email, usuarioModificado: usuarioModificado)
                  }
                    modificarDatos.toggle()  // Cambia el estado de modificar
                }) {
                    Text(modificarDatos ? "Guardar cambios" : "Modificar datos")
                        .foregroundColor(.blue)
                }

                
                Button(action: { mostrarAlerta = true }) {
                   Text("Cerrar sesión").foregroundColor(.red)
               }
               .alert(isPresented: $mostrarAlerta) {
                   Alert(
                       title: Text("Cerrar sesión"),
                       message: Text("¿Estás seguro de que quieres cerrar sesión?"),
                       primaryButton: .default(Text("Sí, cerrar sesión")) {
                           estaAutenticado = false
                           print("Usuario ha cerrado sesión")
                       },
                       secondaryButton: .cancel()
                   )
               }
           }
       }
        .navigationTitle("PERFIL")
        .onAppear {
            print("Correo del usuario: \(gestDatos.correo)")
            cargarDatosUsuario()
        }
    }
    
    // Función para cargar los datos del usuario desde el archivo JSON
    private func cargarDatosUsuario() {
        if let usuario = encontrarUsuarioPorCorreo(correo: gestDatos.email) {
                usuarioAutenticado = usuario
                nombre = usuario.nombre
                direccionPostal = usuario.dirPostal
                correo = usuario.correo
                suscrito = usuario.newsletter
        }
    }
    
    
    // Función para buscar al usuario por correo
    private func encontrarUsuarioPorCorreo(correo: String) -> Usuario? {
        if let url = Bundle.main.url(forResource: "usuarios", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(UsuariosResponse.self, from: data)
                
                // Depuración: Verificar el contenido del archivo JSON
                print("Usuarios cargados: \(response.Usuarios)")
                
                // Comparar el correo en minúsculas
                return response.Usuarios.first { $0.correo.lowercased() == correo.lowercased() }
            } catch {
                print("Error al cargar o decodificar el archivo JSON: \(error)")
            }
        }
        return nil
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
    Perfil(estaAutenticado: .constant(true), gestDatos: GestorDatos())
}
