//
//  ContentView.swift
//  App_GameShop_iOS
//
//  Created by 周慧 on 13/2/25.
//

import SwiftUI

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
// Esta es la vista principal de la aplicación que contiene el TabView
struct ContentView: View {
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

