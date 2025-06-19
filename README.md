# swift-h3

Swift bindings for [Uber's H3](https://github.com/uber/h3) library – a fast, hexagonal hierarchical geospatial indexing system.

This package provides native Swift access to core H3 functionality by wrapping the C library via Swift Package Manager.

---

## Features
- [x] Indexing API
- [x] Inspection API
- [x] Traversal API
- [x] Hierarchy API
- [x] Regions API
- [ ] Directed edges API
- [ ] Vertexes API
- [ ] Miscellaneous
---

## Installation

### Swift Package Manager

Add this to your `Package.swift`:

```swift
.package(url: "https://github.com/JeremyEspresso/swift-h3.git", from: "1.0.0")
```

## 🔨 Development

This package wraps the H3 C library via submodule.

Clone with submodules:

```bash
git clone --recurse-submodules https://github.com/JeremyEspresso/swift-h3.git
```

Then build:
```bash
swift build
swift test
```