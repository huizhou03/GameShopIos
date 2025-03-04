import SwiftUI

struct Registro: View {
    @Binding var usuariosArray: [Usuario]
    @State private var nuevoUsuario: String = ""
    @State private var nuevaPassword: String = ""
    @State private var nombreUsuario: String = ""
    @State private var CPUsuario: String = ""
    @State private var newsletter: Bool = false
    @State private var registroExitoso: Bool = false

    var body: some View {
        VStack {
            Text("Registro")
                .font(.system(size: 50, weight: .bold, design: .rounded))
                
            TextField("Correo electrónico", text: $nuevoUsuario)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.headline)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)
                .padding(.horizontal, 60)
                .foregroundStyle(Color.black)
            
            SecureField("Contraseña", text: $nuevaPassword)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.headline)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)
                .padding(.horizontal, 60)
                .foregroundStyle(Color.black)
            
            TextField("Nombre Completo", text: $nombreUsuario)
                    .font(.headline)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(6)
                    .padding(.horizontal, 60)
                    .foregroundStyle(Color.black)
            
            TextField("Código Postal", text: $CPUsuario)
                    .keyboardType(.numberPad)
                    .font(.headline)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(6)
                    .padding(.horizontal, 60)
                    .foregroundStyle(Color.black)
            
            Toggle(isOn: $newsletter) {
                    Text("Suscribirse al boletín")
                        .font(.headline)
                        .padding(.horizontal, 60)
                }
            
            if registroExitoso {
                Text("¡Registro exitoso!")
                    .foregroundColor(.green)
                    .padding()
            }
            
            Button(action: registrarUsuario) {
                Text("Registrar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal, 60)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func registrarUsuario() {
        guard !nuevoUsuario.isEmpty, !nuevaPassword.isEmpty, !nombreUsuario.isEmpty, !CPUsuario.isEmpty else {
            print("Error: Completa todos los campos")
            return
        }
        
        // Crear un nuevo objeto Usuario con los datos del formulario
        let nuevoUsuarioData = Usuario(
            id: UUID().uuidString, // Genera un ID único
            nombre: nombreUsuario,
            correo: nuevoUsuario,
            CP: CPUsuario,
            newsletter: newsletter,
            carrito: [] // Inicializamos el carrito vacío
        )
        
        // Cargar los datos existentes del archivo JSON
        var usuariosData: UsuariosData
        
        if let data = cargarDatosJSON() {
            usuariosData = data
        } else {
            // Si no existe el archivo, crear una estructura vacía
            usuariosData = UsuariosData(Usuarios: [])
        }
        
        // Agregar el nuevo usuario al array de usuarios
        usuariosData.Usuarios.append(nuevoUsuarioData)
        
        // Guardar los datos actualizados en el archivo JSON
        guardarDatosJSON(usuariosData)
        
        registroExitoso = true
        print("Usuario registrado: \(nuevoUsuario)")
    }

    // Función para cargar los datos del archivo JSON
    private func cargarDatosJSON() -> UsuariosData? {
        let fileManager = FileManager.default
        let url = obtenerURLDelArchivo()
        
        if fileManager.fileExists(atPath: url.path) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let usuariosData = try decoder.decode(UsuariosData.self, from: data)
                return usuariosData
            } catch {
                print("Error al cargar el archivo JSON: \(error.localizedDescription)")
            }
        }
        
        return nil
    }

    // Función para guardar los datos en el archivo JSON
    private func guardarDatosJSON(_ usuariosData: UsuariosData) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Esto hace que el JSON sea más legible
        
        do {
            let data = try encoder.encode(usuariosData)
            let url = obtenerURLDelArchivo()
            try data.write(to: url)
        } catch {
            print("Error al guardar el archivo JSON: \(error.localizedDescription)")
        }
    }

    // Función para obtener la URL del archivo JSON
    private func obtenerURLDelArchivo() -> URL {
        let fileManager = FileManager.default
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return path.appendingPathComponent("Usuarios.json")
    }
}

// Estructura de datos que maneja los usuarios
struct Usuario: Identifiable, Codable {
    var id: String
    var nombre: String
    var correo: String
    var CP: String
    var newsletter: Bool
    var carrito: [CarritoItem] // Añadimos el carrito (que es un array vacío inicialmente)
}

// Estructura para el carrito (vacío por ahora)
struct CarritoItem: Codable {
    // Puedes añadir las propiedades que necesites para los artículos en el carrito
}

// Estructura para manejar la lista de usuarios
struct UsuariosData: Codable {
    var Usuarios: [Usuario]
}

#Preview {
    Registro(usuariosArray: .constant([]))
}
