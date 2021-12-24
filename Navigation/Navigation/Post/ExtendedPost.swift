//
//  ExtendedPost.swift
//  Navigation
//
//  Created by Антон Соколов on 23.12.2021.
//

import Foundation

// Из условий задачи непонятно что надо делать с классами которые работают с Post.title
// Поэтому ввел дополнительную модель, чтобы не сломать собираемость
struct ExtendedPost {
    let author: String
    let description: String
    let image: String
    var likes: Int
    var views: Int
    
    static let posts: [ExtendedPost] = [
        ExtendedPost(
            author: "MotoPage",
            description: "Обзор автомобиля Mercedes. Цены и технические характеристики",
            image: "mersedes",
            likes: 500,
            views: 1005
        ),
        
        ExtendedPost(
            author: "MotoPage",
            description: "Обзор автомобиля BMV. Цены и технические характеристики",
            image: "bmv",
            likes: 200,
            views: 1997
        ),
        
        ExtendedPost(
            author: "MotoPage",
            description: "Обзор автомобиля Audi. Цены и технические характеристики",
            image: "audi",
            likes: 600,
            views: 2348
        ),
        
        ExtendedPost(
            author: "MotoPage",
            description: "Обзор автомобиля Volkswagen. Цены и технические характеристики",
            image: "volkswagen",
            likes: 500,
            views: 2148
        ),
    ]
}
