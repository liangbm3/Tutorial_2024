# 定义编译器
CXX = g++

# 定义编译器选项
CXXFLAGS = -Wall -g `pkg-config --cflags opencv4`
LDFLAGS = `pkg-config --libs opencv4`

# 定义目标文件名
TARGET = foundation

# 定义源文件
SRC = foundation.cpp

# 默认规则
all: $(TARGET)

# 编译规则
$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

# 清理规则
clean:
	rm -f $(TARGET)
