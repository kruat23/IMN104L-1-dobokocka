import sys
import cv2
import numpy as np


def main(path: str):
    img = cv2.imread(path)
    grayImg = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    rows = grayImg.shape[0]
    circles = cv2.HoughCircles(grayImg, cv2.HOUGH_GRADIENT, 1, rows / 16,
                               param1=200, param2=20,
                               minRadius=5, maxRadius=30)

    if circles is not None:
        circles = np.uint16(np.around(circles))
        for i in circles[0, :]:
            center = (i[0], i[1])
            # circle center
            cv2.circle(img, center, 1, (255, 0, 0), 3)
            # circle outline
            radius = i[2]
            cv2.circle(img, center, radius, (50, 255, 100), 3)
        print("Value:", len(circles[0]))

    cv2.imshow("img", img)
    cv2.waitKey(0)

if __name__ == '__main__':
    main("images/dice.jpg")
    if len(sys.argv) == 1:
        exit(0)
    # main(sys.argv[1])
