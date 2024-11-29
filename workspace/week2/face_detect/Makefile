CXX=g++
CXXFLAGS=`pkg-config --cflags opencv4`
LDFLAGS=`pkg-config --libs opencv4`

TARGET = face_detect
SOURCES = face_detect.cpp

all: $(TARGET)

$(TARGET): $(SOURCES)
	$(CXX) $(CXXFLAGS) $(SOURCES) -o $(TARGET) $(LDFLAGS)

clean:
	rm -f $(TARGET)