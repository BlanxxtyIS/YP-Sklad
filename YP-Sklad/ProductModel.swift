//
//  ProductModel.swift
//  YP-Sklad
//
//  Created by Марат Хасанов on 11.06.2024.
//

import UIKit

struct ProductModel {
    let name: String
    let sizeX: Double, sizeY: Double, sizeZ: Double
    let weigth: Double
    let count: Int, price: Double
    let stack: Bool
    let counterparty: String
    let qrCode: String
    let image: UIImage?
    let type: String
}
