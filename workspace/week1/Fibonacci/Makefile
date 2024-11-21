BUILD_DIR = build

all: $(BUILD_DIR)/Fibonacci

$(BUILD_DIR)/Fibonacci: Fibonacci.cpp
	mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && cmake ..
	cd $(BUILD_DIR) && make

clean:
	rm -rf $(BUILD_DIR)