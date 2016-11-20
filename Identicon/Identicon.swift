//
//  Identicon.swift
//  Example
//
//  Created by Evgeniy Yurtaev on 19/11/2016.
//  Copyright © 2016 Evgeniy Yurtaev. All rights reserved.
//

import CoreGraphics

private struct CellDrawParameters {
    let vertices: [CGPoint]
    let inverted: Bool
    let startTurn: Int
}

public class Identicon: IconGenerator {
    private let numberOfRows = 4
    private let numberOfColumns = 4

    private let cellTypes: [[Int]] = [
        [0, 4, 24, 20],
        [0, 4, 20],
        [2, 24, 20],
        [0, 2, 20, 22],
        [2, 14, 22, 10],
        [0, 14, 24, 22],
        [2, 24, 22, 13, 11, 22, 2],
        [0, 14, 22],
        [6, 8, 18, 16],
        [4, 20, 10, 12],
        [0, 2, 12, 10],
        [10, 14, 22],
        [20, 12, 24],
        [10, 2, 12],
        [0, 2, 10]
    ]
    private let centerCellTypes = [0, 4, 8, 15]

    public init() {}

    public func icon(from number: UInt32, size: CGSize) -> CGImage {
        let cellSize = CGSize(width: ceil(size.width / CGFloat(numberOfColumns)), height: ceil(size.height / CGFloat(numberOfRows)))
        let normalizedSize = CGSize(width: cellSize.width * CGFloat(numberOfColumns), height: cellSize.height * CGFloat(numberOfColumns))

        let context = CGContext(
            data: nil,
            width: Int(normalizedSize.width),
            height: Int(normalizedSize.height),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )!

        let (centerParameters, cornerParameters, sideParameters) = cellParameters(fromNumber: number)
        let color = CGColor.color(from: UInt16(number >> 16))

        drawCell(column: 1, row: 1, size: cellSize, color: color, parameters: centerParameters, turn: 0, context: context)
        drawCell(column: 2, row: 1, size: cellSize, color: color, parameters: centerParameters, turn: 0, context: context)
        drawCell(column: 2, row: 2, size: cellSize, color: color, parameters: centerParameters, turn: 0, context: context)
        drawCell(column: 1, row: 2, size: cellSize, color: color, parameters: centerParameters, turn: 0, context: context)

        drawCell(column: 0, row: 0, size: cellSize, color: color, parameters: cornerParameters, turn: 0, context: context)
        drawCell(column: 3, row: 0, size: cellSize, color: color, parameters: cornerParameters, turn: 1, context: context)
        drawCell(column: 3, row: 3, size: cellSize, color: color, parameters: cornerParameters, turn: 2, context: context)
        drawCell(column: 0, row: 3, size: cellSize, color: color, parameters: cornerParameters, turn: 3, context: context)

        drawCell(column: 1, row: 0, size: cellSize, color: color, parameters: sideParameters, turn: 0, context: context)
        drawCell(column: 3, row: 1, size: cellSize, color: color, parameters: sideParameters, turn: 1, context: context)
        drawCell(column: 2, row: 3, size: cellSize, color: color, parameters: sideParameters, turn: 2, context: context)
        drawCell(column: 0, row: 2, size: cellSize, color: color, parameters: sideParameters, turn: 3, context: context)
        drawCell(column: 0, row: 1, size: cellSize, color: color, parameters: sideParameters, turn: 4, context: context)
        drawCell(column: 2, row: 0, size: cellSize, color: color, parameters: sideParameters, turn: 5, context: context)
        drawCell(column: 3, row: 2, size: cellSize, color: color, parameters: sideParameters, turn: 6, context: context)
        drawCell(column: 1, row: 3, size: cellSize, color: color, parameters: sideParameters, turn: 7, context: context)

        let image = context.makeImage()!
        let scaledImage = image.scale(toWidth: Int(ceil(size.width)), height: Int(ceil(size.height)))!

        return scaledImage
    }

    private func cellParameters(fromNumber number: UInt32) -> (center: CellDrawParameters, corner: CellDrawParameters, side: CellDrawParameters) {

        let centerCellType = centerCellTypes[Int(number & 0b11)];
        let centerCellInvert = ((number >> 2) & 0b1) != 0;
        let center = cellParameters(cellType: centerCellType, inverted: centerCellInvert, turn: 0)

        let cornerCellType = (number >> 3) & 0b1111;
        let cornerCellInvert = ((number >> 7) & 0b1) != 0;
        let cornerCellTurn = (number >> 8) & 0b11;
        let corner = cellParameters(cellType: Int(cornerCellType), inverted: cornerCellInvert, turn: Int(cornerCellTurn))

        let sideCellType = (number >> 10) & 0b1111;
        let sideCellInvert = ((number >> 14) & 0b1) != 0;
        let sideCellTurn = (number >> 15) & 0b11;
        let side = cellParameters(cellType: Int(sideCellType), inverted: sideCellInvert, turn: Int(sideCellTurn))

        return (center, corner, side)
    }

    private func cellParameters(cellType type: Int, inverted: Bool, turn: Int) -> CellDrawParameters {
        let internalType: Int
        let internalInverted: Bool
        if (type < cellTypes.count) {
            internalType = type
            internalInverted = inverted
        } else {
            internalType = type % cellTypes.count
            internalInverted = !inverted
        }
        let vertices = cellTypes[internalType].map { value in
            return CGPoint(x: CGFloat(value % 5) / 4, y: floor(CGFloat(value) / 5) / 4)
        }

        return CellDrawParameters(vertices: vertices, inverted: internalInverted, startTurn: turn)
    }

    private func drawCell(column: Int, row: Int, size: CGSize, color: CGColor, parameters: CellDrawParameters, turn: Int, context: CGContext) {
        if (parameters.vertices.count == 0) {
            return
        }

        let points = parameters.vertices.map { vertice in
            CGPoint(x: vertice.x * size.width, y: vertice.y * size.height)
        }
        let path = CGMutablePath()
        path.move(to: points[0])
        for point in points.dropFirst() {
            path.addLine(to: point)
        }
        path.closeSubpath()

        let position = CGPoint(x: size.width * CGFloat(column), y: size.height * CGFloat(row))

        context.saveGState()
        context.setFillColor(color)
        if parameters.inverted {
            context.fill(CGRect(origin: position, size: size))
            context.setBlendMode(CGBlendMode.clear)
        }

        context.translateBy(x: position.x + size.width * 0.5, y: position.y + size.height * 0.5)
        context.rotate(by: (CGFloat((parameters.startTurn + turn) % 4)) * CGFloat.pi / 2)
        context.translateBy(x: -size.width * 0.5, y: -size.height * 0.5)
        context.addPath(path)
        context.drawPath(using: CGPathDrawingMode.fill)

        context.restoreGState()
    }
}
