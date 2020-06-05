//
//  Grid.swift
//  Test
//
//  Created by Nikhil on 03/06/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import SwiftUI

struct Grid<Item:Identifiable,ItemView:View>: View {
    var items:[Item]
    var viewForItem:(Item) -> ItemView
    init( _ items:[Item],viewForIem:@escaping (Item)->ItemView) {
        self.items = items
        self.viewForItem = viewForIem
    }
    var body: some View {
        GeometryReader{ geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
            
        }
    }
    func body(for layout:GridLayout) -> some View
    {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    func body(for item:Item, in layout :GridLayout)-> some View
    {

        let index = self.index(of: item)
        return viewForItem(item).frame(width: layout.itemSize.width, height: layout.itemSize.height).position(layout.location(ofItemAt: index!))
        
       
    }
    func index(of item:Item) -> Int?
    {
        return items.firstIndex{  $0.id == item.id}
        
    }

}

