//
//  Tienda.swift
//  GameShopIOS
//
//  Created by Usuario invitado on 4/3/25.
//
//Tienda
import SwiftUI
struct TiendaView: View {
    @State private var productos = [Producto]()
    @State private var productoSeleccionado: Producto? = nil
    @State private var mostrarSheet = false
    var body: some View{
        NavigationView {
                        List(productos) { producto in
                            HStack {
                                Image(producto.imagen) // Asegúrate de tener las imágenes en tu proyecto
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
                                DetalleProductoView(producto: producto, agregarAlCarrito: agregarAlCarrito)
                            } else {
                                Text("Cargando...")
                            }
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
                let decodedProductos = try decoder.decode(    .self, from: data)
                
                DispatchQueue.main.async {
                    self.productos = decodedProductos.Productos
                }
                
            } catch {
                print("Error al decodificar el JSON: \(error)")
            }
        }
    func agregarAlCarrito(producto: Producto) {
        guard let url = Bundle.main.url(forResource: "carrito", withExtension: "json") else {
            print("No se pudo encontrar el archivo carrito.json.")
            return
        }
        
        var carrito = [Producto]()

        do {
            let data = try Data(contentsOf: url)
            var carrito = try JSONDecoder().decode([Producto].self, from: data)
            carrito.append(producto)

            let updatedData = try JSONEncoder().encode(carrito)
            try updatedData.write(to: url)
            print("✅ Producto añadido al carrito.")
        } catch {
            print("❌ Error al añadir producto al carrito: \(error.localizedDescription)")
        }
    }
}
#Preview {
    TiendaView()
}
