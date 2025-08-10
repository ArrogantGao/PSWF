#include <gtest/gtest.h>
#include <pswf.h>

TEST(PSWFTest, BasicAssertions) {
    double c = prolc180(0.0001);
    EXPECT_DOUBLE_EQ(c, 12.024);
}