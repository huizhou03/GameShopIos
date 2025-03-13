//
//  Carrito.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 6/3/25.
//

import SwiftUI

struct CarritoView: View {
    @StateObject private var gestDatos = GestorDatos()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gestDatos.carrito.indices, id: \.self) { index in
                    HStack {
                        Image(gestDatos.carrito[index].producto.imagen)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading) {
                            Text(gestDatos.carrito[index].producto.nombre)
                                .font(.headline)
                            Text("$\(gestDatos.carrito[index].producto.precio, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.green)
                            
                            // Stepper para modificar la cantidad
                            Stepper(value: $gestDatos.carrito[index].cantidad, in: 1...99) {
                                Text("Cantidad: \(gestDatos.carrito[index].cantidad)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Carrito")
            .onAppear {
                gestDatos.cargarJSONCarrito(correoUsuario: "antonLuo15@gmail.com")
            }
            .onDisappear {
                gestDatos.guardarDatosJSONCarrito()
            }
        }
    }
}

#Preview {
    CarritoView()
}

