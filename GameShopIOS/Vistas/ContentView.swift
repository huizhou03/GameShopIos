//
//  ContentView.swift
//  App_GameShop_iOS
//
//  Created by 周慧 on 13/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var estaAutenticado = false
    @State private var nombreUsuario = ""
    @StateObject private var gestDatos = GestorDatos()
    
    var body: some View {
        if estaAutenticado {
            VistaPrincipal(nombreUsuario: nombreUsuario)
                .onAppear {
                    gestDatos.setCorreo(correoIntroducido: nombreUsuario)
                    print("El correo introducido es \(gestDatos.getCorreo())")
                }
        } else {
            Login(estaAutenticado: $estaAutenticado, nombreUsuario: $nombreUsuario)
        }
    }
}

// Esta es la vista principal de la aplicación que contiene el TabView
struct VistaPrincipal: View {
    let nombreUsuario: String
    
    var body: some View {
        //Barra de la parte inferior
        TabView {
            //Cuando hago click en perfil
            Perfil()
                .tabItem{
                    Label("Perfil", systemImage: "person.circle")
                }
                .tag(1)

            TiendaView()
                .tabItem{
                    Label("Tienda", systemImage: "house")
                }
                .tag(2)
            
            CarritoView()
                .tabItem{
                    Label("Carrito", systemImage: "cart")
                }
                .tag(3)
            
            PedidosView()
                .tabItem{
                    Label("Pedidios", systemImage: "cube.box")
                }
                .tag(4)
        }
    }
}


#Preview {
    ContentView()
}
