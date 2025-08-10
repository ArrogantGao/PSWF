// #include <gtest/gtest.h>
// #include <pswf.h>

// TEST(PSWFTest, BasicAssertions) {
//     double c = prolc180(0.0001);
//     EXPECT_DOUBLE_EQ(c, 12.024);
// }

#include <pswf.h>

int main() {
    double coeffs[15];
    energy_poly(0.0001, 15, coeffs);
    for (int i = 0; i < 15; i++) {
        std::cout << coeffs[i] << std::endl;
    }

    double c = prolc180(0.0001);
    for (double x = 0.0; x <= 1.1; x += 0.01) {
        double psi = prolate0_eval(c, x);
        std::cout << x << " " << psi << std::endl;
    }
    
    return 0;
}