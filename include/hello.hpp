#ifndef HELLO_HPP
#define HELLO_HPP

#include <iostream>
#include <sctl.hpp>

namespace hello {
    void hello();

    struct Hello {
        int a;
        int b;

        Hello(int a, int b) : a(a), b(b) {}

        void say_hello();
    };
    
    template <typename T> 
    T hello_sctl(T t) {
        T t2 = sctl::pow(t, 2);
        return t2;
    }
} // namespace hello

#endif