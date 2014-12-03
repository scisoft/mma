#ifdef __cplusplus
class Workhorse {
public:
    Workhorse() {}
    virtual ~Workhorse() {}
    int work(int n, float *vec) { return n; }
}
#else
typedef struct Workhorse Workhorse;
#endif

#ifdef __cplusplus
extern "C" {
#endif
int workhorse__work(AClass *a, int n, float *vec) {
    return a->work(n, vec);
}
#ifdef __cplusplus
}
#endif
