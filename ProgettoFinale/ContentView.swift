import SwiftUI

struct ContentView: View {
    @State private var mioTodo = ""
    @State private var todos: [Item] = []
    @State private var backgroundColor = Color.white
    
    private let colori: [Color] = [.white, .blue.opacity(0.1), .green.opacity(0.1),
                                 .yellow.opacity(0.1), .pink.opacity(0.1)]
    @State private var indiceColoreAttuale = 0
    
    private func delete(at offset: IndexSet) {
        self.todos.remove(atOffsets: offset)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Nuova task..", text: $mioTodo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        guard !self.mioTodo.isEmpty else { return }
                        self.todos.append(Item(todo: self.mioTodo))
                        self.mioTodo = ""
                    }) {
                        Image(systemName: "text.badge.plus")
                    }
                    .padding(.leading, 5)
                    
                    Button(action: {
                        indiceColoreAttuale = (indiceColoreAttuale + 1) % colori.count
                        backgroundColor = colori[indiceColoreAttuale]
                    }) {
                        Image(systemName: "paintbrush.fill")
                            .foregroundColor(.blue)
                    }
                    .padding(.leading, 5)
                }.padding()
                
                List {
                    ForEach(todos.indices, id: \.self) { index in
                        HStack {
                            Text(todos[index].todo)
                            Spacer()
                            Button(action: {
                                todos.remove(at: index)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        .listRowBackground(backgroundColor)
                    }
                }
                .listStyle(PlainListStyle())
                .background(backgroundColor)
                .scrollContentBackground(.hidden)
            }
            .navigationBarTitle("La mia lista Todo")
            .background(backgroundColor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
