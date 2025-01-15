//
//  Snackbar.swift
//  MyStoreApp
//
//  Created by Oscar Martinez on 14/01/25.
//

import UIKit

enum SnackbarActionType {
    case success
    case error
    case info
}

struct Snackbar {
    
    static func showSnackbar(title: String, type: SnackbarActionType, icon: UIImage?, duration: TimeInterval = 2.0) {
        // Crear la vista Snackbar
        let snackbar = UIView(frame: CGRect(x: 16, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width - 32, height: 60))
        snackbar.layer.cornerRadius = 8
        snackbar.clipsToBounds = true
        
        // Configurar el color de fondo según el tipo
        let textColor: UIColor
        let backgroundColor: UIColor
        switch type {
        case .success:
            backgroundColor = UIColor.systemGreen
            textColor = UIColor.white
        case .error:
            backgroundColor = UIColor.systemRed
            textColor = UIColor.white
        case .info:
            backgroundColor = UIColor.white
            textColor = UIColor.black
        }
        
        snackbar.backgroundColor = backgroundColor
        
        // Agregar el ícono
        if let icon = icon {
            let iconImageView = UIImageView(image: icon)
            iconImageView.frame = CGRect(x: 8, y: 10, width: 40, height: 40)
            iconImageView.contentMode = .scaleAspectFit

            // Aplica el color al icono antes de asignarlo a la vista
            if let maskedIcon = icon.maskWithColor(color: textColor) {
                iconImageView.image = maskedIcon
            }

            snackbar.addSubview(iconImageView)
        }

        
        // Agregar etiqueta con el título
        let label = UILabel(frame: CGRect(x: 56, y: 10, width: snackbar.frame.width - 64, height: 40))
        label.text = title
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        snackbar.addSubview(label)
        
        // Agregar el Snackbar a la ventana principal
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(snackbar)
            
            // Animar la aparición del Snackbar
            snackbar.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                snackbar.alpha = 1
            }) { _ in
                // Desaparecer después del tiempo indicado
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    UIView.animate(withDuration: 0.3, animations: {
                        snackbar.alpha = 0
                    }) { _ in
                        snackbar.removeFromSuperview()
                    }
                }
            }
        }
    }
    
}
