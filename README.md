# SmartCache

`SmartCache` is a lightweight library that caches any data to memory and saves it in the cache folder.

At the first access, `SmartCache` searches data in the memory cache. If not found, it tries to find on the disk, in the cache folder.

It clears the cache on low memory warning (by using `NSCache` under the hood).


#### Usage:
``` swift
class MyClass {

    private let cache: SmartCache<URL, Data> = .init()

    func downloadImage(from url: URL) {
        if let data = self.cache[url], let image = NSImage(data: data) {
            // Here your `image`
        } else {
            // Download your image and save it to our cache
            cache[url] = image.tiffRepresentation
        }
    }
}
```

### Installation
#### Swift Package Manager
``` swift
// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "YourProject",
  dependencies: [
    .package(url: "https://github.com/nightwill/smart-cache.git", from: "1.0.0")
  ],
  targets: [
    .target(name: "YourProject", dependencies: ["SmartCache"])
  ]
)
```
And then import wherever needed: ```import SmartCache ```

Instead of `SmartCache`, you can use only `MemoryCache` or `PersistentCache`.

In `MemoryCache` you can store whatever you want, but `PersistentCache` has some limitations. For now, you can save any `Codable` and `Data`. For storing specific objects, adopt `PersistentCacheValue` protocol to your type. 

As key, you can use `URL` and `UUID`. For supporting various objects, adopt `FilenameConvertible` protocol for key types.
