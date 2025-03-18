import SwiftUI

struct CarritoView: View {
    @ObservedObject var gestDatos: GestorDatos
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(gestDatos.carrito.indices, id: \.self) { index in
                        CarritoItemView(item: $gestDatos.carrito[index]) {
                            gestDatos.borrarProduto(index: index)
                        }
                    }
                }
                
                Button(action: {
                    gestDatos.migrarCarritoAPedidos(correoUsuario: gestDatos.email)
                }) {
                    Text("Finalizar compra")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Carrito")
            .onAppear {
                gestDatos.cargarJSONCarrito(correoUsuario: gestDatos.email)
            }
            .onDisappear {
                gestDatos.guardarDatosJSONCarrito()
            }
        }
    }
}


#Preview {
    CarritoView(gestDatos: GestorDatos())
}


