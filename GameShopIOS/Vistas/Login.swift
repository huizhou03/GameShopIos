//
//  Login.swift
//  App_GameShop_iOS
//
//  Created by 周慧 on 24/2/25.
//
import SwiftUI

struct Login: View {
    
    //@Binding var usr: String
    @State var usr: String = ""
    @State var pwd: String = ""

    var body: some View {
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
                .onChange(of: usr) { oldValue, newValue in
                    print("Username nuevo valor: \(newValue)")
                }
            
            SecureField ("Password", text: $pwd)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.headline)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)
                .padding(.horizontal, 60)
                .foregroundStyle(Color.black)
                .onChange(of: pwd) { oldValue, newValue in
                    print("Contraseña nuevo valor: \(newValue)")
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
            /*Button ("Autenticar ✅") {
                print("**********")
                print(" 👤 \(usr)")
                print("🔑 \(pwd)")
            }*/
            
            Button ("Limpiar campos 🧹") {
                usr = ""
                pwd = ""
                print("Borraste todo")
            }
            
            Spacer()
        }
        .padding()
    }
    
    // Método de autenticación (se puede conectar con Firebase en el futuro)
    private func autenticar() {
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
//Array()
