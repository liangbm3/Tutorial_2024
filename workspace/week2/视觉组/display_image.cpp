#include <iostream>
// OpenCV library headers
#include <opencv2/opencv.hpp>
#include <iostream>

int main() {
    cv::Mat image = cv::imread("picture.png", cv::IMREAD_COLOR);
    if (image.empty()) {
        std::cout << "Could not open or find the image" << std::endl;
        return -1;
    }
    cv::namedWindow("Display window", cv::WINDOW_AUTOSIZE);
    cv::imshow("Display window", image);
    cv::waitKey(0); // Wait for a keystroke in the window
    return 0;
}
