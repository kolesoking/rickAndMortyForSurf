import UIKit

extension UIImageView {
    func loadImage(with url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else {
            return completion(UIImage.backArrow)
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error  in
            if let error {
                print("error: \(error)")
                return completion(UIImage.backArrow)
            }
            
            guard let data else {
                return completion(UIImage.backArrow)
            }
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }.resume()
    }
}
