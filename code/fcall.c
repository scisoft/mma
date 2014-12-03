int fwork(int, float *); // normally defined in header file

int work() {
    int x;
    float y[100];
    x = fwork(100, y);
    return 0;
}
