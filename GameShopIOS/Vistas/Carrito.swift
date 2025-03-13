import SwiftUI

struct CarritoView: View {
    @StateObject private var gestDatos = GestorDatos()
    
    var body: some View {
        NavigationView {
            VStack {
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
                
                // Botón para migrar carrito a pedidos
                Button(action: {
                    gestDatos.migrarCarritoAPedidos()
                }) {
                    Text("Finalizar compra")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
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


