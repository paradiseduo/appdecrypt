import Foundation

// https://github.com/NyaMisty/fouldecrypt/issues/15#issuecomment-1722561492
// See the comment above for more information
class LinkTool {
    func launch(binaries: [String]) {
        for binary in binaries {
            launch(binary: binary)
        }
    }

    func launch(binary: String) {
        // this file doesn't need to be launched, but need to be catalogued in the memory
        let handle = dlopen(binary, RTLD_LAZY | RTLD_GLOBAL)
        dlclose(handle)
    }
}
