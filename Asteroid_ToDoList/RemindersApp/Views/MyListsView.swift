//
//  ContentView.swift
//  RemindersApp
//
//  Created by Mohammad Azam on 1/8/23.
//

import SwiftUI
import CoreData

struct MyListsView: View {
    @State private var isPresented: Bool = false
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
    let userDataManager = UserDataManager()
    
    var body: some View {
            VStack {
                if myListResults.isEmpty {
                    Spacer()
                    Text("어떠한 목록도 없습니다")
                } else {
                    List {
                        ForEach(Array(myListResults.enumerated()), id: \.element) {index, myList in
                            NavigationLink(destination: ReminderListView(myList: myList,listId : index)) {
                                MyListCellView(myList: myList)
                                    .font(.title3)
                            }
                        }
                        .onDelete(perform: deleteList)
                    }
                    .scrollContentBackground(.hidden)
                }
                
                Spacer()
                
                Button {
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }
                .padding()
            }
            .onAppear {
                userDataManager.getLists()
            }
            .navigationTitle("MyList")
                .sheet(isPresented: $isPresented) {
                    NavigationView {
                        AddNewListView { name, color in
                            do {
                                try ReminderService.saveMyList(name, color)
                            } catch  {
                                print(error.localizedDescription)
                            }
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarHidden(true)
    }
    
    private func deleteList(at offsets: IndexSet) {
        for index in offsets {
            let myList = myListResults[index]
            viewContext.delete(myList)
            userDataManager.deleteList(listId: index)
        }
        do {
            try viewContext.save()
        } catch {
            print("Error deleting list: \(error.localizedDescription)")
        }
    }

}

    
    struct MyListsView_Previews: PreviewProvider {
        static var previews: some View {
            MyListsView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
        }
    }

