//
//  Login.swift
//  App_GameShop_iOS
//
//  Created by 周慧 on 24/2/25.
//
import SwiftUI

struct Login: View {
    /*//JSON
    struct Usuarios:Codable{
        let id: String
        let nombre: String
        let correo: String
        let dirPostal: String
        let newsletter: Bool
    }*/
    
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
                    TextField ("Username", text:  $nombreUsuario)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .font(.headline)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(6)
                        .padding(.horizontal, 60)
                        .foregroundStyle(Color.black)
                    
                    SecureField ("Password", text: $contrasena)
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
                        autenticar()
                    }
                    .foregroundStyle(Color.green)
                    
                    /*Button(action: autenticar){
                     Text("Iniciar Sesión")
                     .font(.headline)
                     .foregroundColor(.white)
                     .padding()
                     .frame(maxWidth: .infinity)
                     .background(Color.red)
                     .cornerRadius(8)
                     .padding(.horizontal, 60)*/
                }
            }
        }
        .navigationTitle("Iniciar sesión")
        .onDisappear{
            
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
}

/*#Preview {
    Login(estaAutenticado: .constant(false), nombreUsuario: .constant(""))
}*/
            

 /*           /*// Botón de registro habilitado
            NavigationLink(destination: Registro(usuariosArray: $usuariosArray)) {
                Text("Registrarse")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
            }*/
            Spacer()
        }
        .padding()
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
            // Si no se encontró en el array de login, buscar en el array de usuarios con detalles adicionales
            } else {
                print("Error: Usuario o contraseña incorrectos.")
                sesionFallida = true
            }
        }
}*/
