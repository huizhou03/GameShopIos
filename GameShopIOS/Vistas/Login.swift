//
//  Login.swift
//  App_GameShop_iOS
//
//  Created by 周慧 on 24/2/25.
//
import SwiftUI

struct Login: View {
    //Usuarios
    struct Usuarios: Codable {
        let usuario: String
        let password: String
    }
    
    //@Binding var usr: String
    @State var usr: String = ""
    @State var pwd: String = ""
    @State var sesionFallida: Bool = false
    @State var autenticado: Bool = false
    @State private var path = [String]()
    @State var usuariosArray: [Usuarios] = [
        Usuarios(usuario: "huizhou.universidad@gmail.com", password: "123456"),
        Usuarios(usuario: "antonluo15@gmail.com", password: "123456")]

    var body: some View {
        NavigationStack(path: $path){
            VStack {
                Text("Login")
                    .font(.system(size: 70, weight: .bold, design: .rounded))
                    
                TextField ("Username", text: $usr)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .font(.headline)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(6)
                    .padding(.horizontal, 60)
                    .foregroundStyle(Color.black)
                
                /*.onChange(of: usr) { oldValue, newValue in
                 print("Username nuevo valor: \(newValue)")
                 } Esto es para perfil*/
                
                SecureField ("Password", text: $pwd)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .font(.headline)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(6)
                    .padding(.horizontal, 60)
                    .foregroundStyle(Color.black)
                /*.onChange(of: pwd) { oldValue, newValue in
                 print("Contraseña nuevo valor: \(newValue)")
                 } Esto es para perfil*/
                
                if sesionFallida {
                    Text("Usuario o contraseña incorrecto.")
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: autenticar){
                    Text("Iniciar Sesión")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                        .padding(.horizontal, 60)
                }
                
                // Navegación a la pantalla principal si autenticado es true
                NavigationLink(destination: ContentView(), isActive: $autenticado) {
                    EmptyView()
                }

                // Botón de registro habilitado
                NavigationLink(destination: Registro(usuariosArray: $usuariosArray)) {
                    Text("Registrarse")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                }
                Spacer()
            }
            .padding()
        }
        }
        
    
    // Método de autenticación
        private func autenticar() {
            // Verificar si los campos no están vacíos
            guard !usr.isEmpty, !pwd.isEmpty else {
                print("Error: Completa los campos de usuario y contraseña")
                sesionFallida = true
                return
            }

            // Comprobar si el usuario existe y la contraseña es correcta
            if let usuario = usuariosArray.first(where: { $0.usuario == usr && $0.password == pwd }) {
                print("Inicio de sesión exitoso para \(usuario.usuario)")
                autenticado = true
                sesionFallida = false
            } else {
                print("Error: Usuario o contraseña incorrectos.")
                sesionFallida = true
            }

            // Mostrar los valores para depuración
            print("**********")
            print("Inicio de sesión")
            print(" 👤 Usuario: \(usr)")
            print(" 🔑 Contraseña: \(pwd)")
        }
}

#Preview {
    // Para que la variable @Binding funcione hay que inicializarla en el ContentView:
    //ContentView(usr: .constant(""))
    Login()
}


