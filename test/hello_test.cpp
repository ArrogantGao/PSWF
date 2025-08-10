#include <gtest/gtest.h>
#include <hello.hpp>

TEST(HelloTest, BasicAssertions) {
    EXPECT_EQ(hello::hello_sctl(2), 4);
    EXPECT_DOUBLE_EQ(hello::hello_sctl(2.0), 4.0);
    hello::Hello h = hello::Hello(1, 2);
    EXPECT_NO_THROW(h.say_hello());
    EXPECT_EQ(h.a, 1);
    EXPECT_EQ(h.b, 2);
    EXPECT_NO_THROW(hello::hello());
}