//
//  Tienda.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 4/3/25.
//
//Tienda


import SwiftUI

struct TiendaView: View {
    @ObservedObject var gestDatos: GestorDatos
    @State private var productoSeleccionado: Producto? = nil
    @State private var mostrarSheet = false
    
    
    var body: some View {
        NavigationView {
            List(gestDatos.productos) { producto in
                HStack {
                    Image(producto.imagen)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
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
                .onTapGesture {
                    productoSeleccionado = producto
                    mostrarSheet = true
                }
            }
            .sheet(isPresented: $mostrarSheet) {
                if let producto = productoSeleccionado {
                    DetalleProductoView(producto: producto, gestDatos: gestDatos)
                } else {
                    Text("Cargando...")
                }
            }
            .navigationTitle("Tienda")
            .onAppear{
                gestDatos.loadProductos()
                print("Tienda correo \(gestDatos.email)")
            }
        }
    }
}

#Preview {
    TiendaView(gestDatos: GestorDatos())
}
