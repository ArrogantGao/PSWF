#include <hello.hpp>
#include <sctl.hpp>

namespace hello {
    void hello() {
        std::cout << "Hello, World!" << std::endl;
    }
    
    void Hello::say_hello() {
        std::cout << "Hello, World! " << a << " " << b << std::endl;
    }
} // namespace hello