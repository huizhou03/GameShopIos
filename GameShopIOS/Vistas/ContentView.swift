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
    
    var body: some View {
        if estaAutenticado {
            VistaPrincipal(nombreUsuario: nombreUsuario)
        } else {
            Login(estaAutenticado: $estaAutenticado, nombreUsuario: $nombreUsuario)
        }
    }
}

// Esta es la vista principal de la aplicación que contiene el TabView
struct VistaPrincipal: View {
    @Binding var nombreUsuario: String
    @State private var usuarioAutenticado: Usuario?
    
    var body: some View {
        //Barra de la parte inferior
        TabView {
            //Cuando hago click en perfil
            Perfil(nombreUsuario: nombreUsuario)
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
        
/*// Cargar los datos del usuario desde el archivo usuarios.json
    private func cargarDatosUsuario() {
        if let usuario = GestorUsuarios.encontrarUsuario(por: nombreUsuario) {
            usuarioAutenticado = usuario
        }
    }*/
}

/*//Perfil
struct PerfilView: View {
    var body: some View{
        NavigationStack{
            Image(systemName: "person.circle")
            //...Añadimos código para editar aquí
            Text("Página de Perfil")
                .navigationTitle("Perfil")
        }
    }
}*/

//Pedidos
struct PedidosView: View {
    var body: some View{
        NavigationStack{
            Image(systemName: "person.circle")
            //...Añadimos código para editar aquí
            Text("Página de Pedidos")
                .navigationTitle("Pedidos")
        }
    }
}

#Preview {
    ContentView()
}
