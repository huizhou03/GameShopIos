
import SwiftUI
struct CarritoItemView: View {
    @Binding var item: ItemCarrito
    var onDelete: () -> Void
    
    var body: some View {
        HStack {
            Image(item.producto.imagen)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(item.producto.nombre)
                    .font(.headline)
                Text("$\(item.producto.precio, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.green)
                
                Stepper(value: $item.cantidad, in: 0...99) {
                    Text("Cantidad: \(item.cantidad)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .onChange(of: item.cantidad) {
                    if item.cantidad == 0 {
                        onDelete()
                    }
                }
            }
        }
        .padding()
    }
}

