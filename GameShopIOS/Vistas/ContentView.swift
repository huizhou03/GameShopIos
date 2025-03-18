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
    @StateObject var gestDatos = GestorDatos()
    @State private var tabSeleccionado = 2
    
    var body: some View {
        if estaAutenticado {
            VistaPrincipal(nombreUsuario: nombreUsuario, tabSeleccionado: $tabSeleccionado, estaAutenticado: $estaAutenticado, gestDatos: gestDatos)
                .onAppear{
                    print("el correo introducido es \(gestDatos.email)")
                }
        } else {
            Login(estaAutenticado: $estaAutenticado, nombreUsuario: $nombreUsuario, gestDatos: gestDatos)
                .onDisappear {
                tabSeleccionado = 2
            }
        }
    }
}

// Esta es la vista principal de la aplicación que contiene el TabView
struct VistaPrincipal: View {
    let nombreUsuario: String
    @Binding var tabSeleccionado: Int
    @Binding var estaAutenticado: Bool
    @ObservedObject var gestDatos: GestorDatos
    
    var body: some View {
        //Barra de la parte inferior
        TabView(selection: $tabSeleccionado){
            //Cuando hago click en perfil
            Perfil(estaAutenticado: $estaAutenticado, gestDatos: gestDatos)
                .tabItem{
                    Label("Perfil", systemImage: "person.circle")
                }
                .tag(1)

            TiendaView(gestDatos: gestDatos)
                .tabItem{
                    Label("Tienda", systemImage: "house")
                }
                .tag(2)
            
            CarritoView(gestDatos: gestDatos)
                .tabItem{
                    Label("Carrito", systemImage: "cart")
                }
                .tag(3)
            
            PedidosView(gestDatos: gestDatos)
                .tabItem{
                    Label("Pedidos", systemImage: "cube.box")
                }
                .tag(4)
        }
    }
}


#Preview {
    ContentView()
}
