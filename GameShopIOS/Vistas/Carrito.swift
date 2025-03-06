//
//  Carrito.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 6/3/25.
//

//Carrito
import SwiftUI

struct CarritoView: View {
    @StateObject private var gestDatos = GestorDatos()
    
    var body: some View {
        NavigationView {
            List(gestDatos.carrito) { producto in
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
            }
            .navigationTitle("Carrito")
        }
    }
}
#Preview {
    CarritoView()
}


