import SwiftUI

struct Login: View {
    @Binding var estaAutenticado: Bool
    @Binding var nombreUsuario: String
    @State private var contrasena = ""
    @State private var sesionFallida: Bool = false
    @StateObject var gestDatos: GestorDatos
    
    //Array
    struct UsuariosLogin: Codable {
        let usuario: String
        let password: String
    }
    
    //Array de usuarios
    @State var usuariosArray: [UsuariosLogin] = [
        UsuariosLogin(usuario: "huizhou@gmail.com", password: "123456"),
        UsuariosLogin(usuario: "antonluo15@gmail.com", password: "123456")]
    
    var body: some View {
        VStack {
            Image("logotipo_Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .padding(.top, 10)
            
            Text("Bienvenido a SwitchHub")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
            
            Form {
                Section {
                    TextField("Correo electrónico", text: $nombreUsuario)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.headline)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal, 2)
                    
                    SecureField("Contraseña", text: $contrasena)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.headline)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal, 2)
                }
                
                if sesionFallida {
                    Text("Usuario o contraseña incorrecto.")
                        .foregroundColor(.red)
                        .padding()
                }
                
                Section {
                    Button("Iniciar sesión") {
                        gestDatos.email = nombreUsuario
                        print("El correo introducido del login es \(nombreUsuario)")
                        autenticar()
                        resetearUsuario()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                }
            }
        }
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
    private func resetearUsuario() {
        nombreUsuario = ""
        contrasena = ""
    }
}

#Preview {
    Login(estaAutenticado: .constant(false), nombreUsuario: .constant(""), gestDatos: GestorDatos())
}

