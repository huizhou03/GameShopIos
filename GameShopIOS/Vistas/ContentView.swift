//
//  ContentView.swift
//  App_GameShop_iOS
//
//  Created by 周慧 on 13/2/25.
//

import SwiftUI

//Perfil
struct PerfilView: View {
    var body: some View{
        NavigationStack{
            Image(systemName: "person.circle")
            //...Añadimos código para editar aquí
            Text("Página de Perfil")
                .navigationTitle("Perfil")
        }
    }
}

//Tienda
struct TiendaView: View {
    @State private var productos = [Producto]()
    var body: some View{
        NavigationView {
                        List(productos) { producto in
                            HStack {
                                Image(producto.imagen) // Asegúrate de tener las imágenes en tu proyecto
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                                
                                VStack(alignment: .leading) {
                                    Text(producto.nombre)
                                        .font(.headline)
                                    Text("$\(producto.precio, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.green)
                                }
                            }
                            .padding()
                        }
                        .navigationTitle("Tienda")
                }
        .onAppear {
            loadProductos()
        }
    }
    func loadProductos() {

            guard let url = Bundle.main.url(forResource: "productos", withExtension: "json") else {
                print("No se pudo encontrar el archivo JSON.")
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedProductos = try decoder.decode([Producto].self, from: data)
                self.productos = decodedProductos
            } catch {
                print("Error al decodificar el JSON: \(error)")
            }
        }
}

//Carrito
struct CarritoView: View {
    var body: some View{
        NavigationStack{
            Image(systemName: "person.circle")
            //...Añadimos código para editar aquí
            Text("Página de Carrito")
                .navigationTitle("Carrito")
        }
    }
}

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
            PerfilView()
                .tabItem{
                    Label("Perfil", systemImage: "person.circle")
                }
            // tag se utiliza para identificar cada tab de forma única
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
