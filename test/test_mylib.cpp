#include <gtest/gtest.h>
#include "my_lib.h"
#include "TestUtils.h"

class mylibTest : public TemplateTest
{
};

// 确保 add 函数有声明
TEST(mylibTest, AddFunction)
{
    EXPECT_EQ(add(2, 3), 5);
    EXPECT_EQ(add(-1, 1), 0);
    EXPECT_EQ(add(0, 0), 0);
}