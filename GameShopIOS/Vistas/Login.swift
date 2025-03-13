import SwiftUI

struct Login: View {
    @Binding var estaAutenticado: Bool
    @Binding var nombreUsuario: String
    @State private var contrasena = ""
    @State private var sesionFallida: Bool = false
    @StateObject private var gestDatos = GestorDatos()
    
    //Array
    struct UsuariosLogin: Codable {
        let usuario: String
        let password: String
    }
    
    //Array de usuarios
    @State var usuariosArray: [UsuariosLogin] = [
        UsuariosLogin(usuario: "huizhou.universidad@gmail.com", password: "123456"),
        UsuariosLogin(usuario: "antonluo15@gmail.com", password: "123456")]
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.system(size: 70, weight: .bold, design: .rounded))
            
            Form {
                Section {
                    TextField("Username", text: $nombreUsuario)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.headline)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(6)
                        .padding(.horizontal, 60)
                        .foregroundStyle(Color.black)
                    
                    SecureField("Password", text: $contrasena)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.headline)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(6)
                        .padding(.horizontal, 60)
                        .foregroundStyle(Color.black)
                }
                
                if sesionFallida {
                    Text("Usuario o contraseña incorrecto.")
                        .foregroundColor(.red)
                        .padding()
                }
                
                Section {
                    Button("Iniciar sesión") {
                        gestDatos.setCorreo(correoIntroducido: nombreUsuario)
                        autenticar()
                    }
                    .foregroundStyle(Color.green)
                }
            }
        }
        .navigationTitle("Iniciar sesión")
    }
    
    private func autenticar() {
        guard !nombreUsuario.isEmpty, !contrasena.isEmpty else {
            sesionFallida = true
            return
        }
        
        if usuariosArray.contains(where: { $0.usuario == nombreUsuario && $0.password == contrasena }) {
            estaAutenticado = true
            sesionFallida = false
        } else {
            sesionFallida = true
        }
    }
}

#Preview {
    Login(estaAutenticado: .constant(false), nombreUsuario: .constant(""))
}

