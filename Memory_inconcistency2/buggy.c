#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <stdatomic.h>
#include <stdalign.h>
#include <time.h>


// x i f on different cache lines
alignas(64) atomic_int x = 0;
alignas(64) atomic_int f = 0;

atomic_int bug = 0;

// 0 = wait, 1 = run, 2 = finish
atomic_int run_state = 0;
atomic_int done_count = 0;

int foo(void) {
    return 42;
}

void *thread1(void *arg) {
    (void)arg;
    while (1) {
        int state = 0;
        while ((state = atomic_load(&run_state)) == 0);
        if (state == 2) break;

        // x = foo() -> relaxed
        atomic_store_explicit(&x, foo(), memory_order_relaxed);

        // f = true —> relaxed
        atomic_store_explicit(&f, 1, memory_order_relaxed);

        atomic_fetch_add(&done_count, 1);
        while ((state = atomic_load(&run_state)) == 1);
        if (state == 2) break;
        atomic_fetch_add(&done_count, 1);
    }
    return NULL;
}

void *thread2(void *arg) {
    (void)arg;
    while (1) {
        int state = 0;
        while ((state = atomic_load(&run_state)) == 0);
        if (state == 2) break;

        // while (!f) -> relaxed
        while (!atomic_load_explicit(&f, memory_order_relaxed));

        // 1/x
        if (atomic_load_explicit(&x, memory_order_relaxed) == 0) {
            atomic_fetch_add(&bug, 1);
        }

        atomic_fetch_add(&done_count, 1);
        while ((state = atomic_load(&run_state)) == 1);
        if (state == 2) break;
        atomic_fetch_add(&done_count, 1);
    }
    return NULL;
}

int main(int argc, char *argv[]) {
    int N = atoi(argv[1]);

    printf("start: %d iterations\n\n", N);

    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);

    struct timespec t_start, t_end;
    clock_gettime(CLOCK_MONOTONIC, &t_start);

    for (int i = 0; i < N; i++) {

        atomic_store(&x, 0);
        atomic_store(&f, 0);
        atomic_store(&done_count, 0);

        // start
        atomic_store(&run_state, 1);

        // wait for threads to finish
        while (atomic_load(&done_count) != 2);

        // finish
        atomic_store(&run_state, 0);
        while (atomic_load(&done_count) != 4);
    }

    clock_gettime(CLOCK_MONOTONIC, &t_end);
    
    atomic_store(&run_state, 2);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    double elapsed = (t_end.tv_sec - t_start.tv_sec) + (t_end.tv_nsec - t_start.tv_nsec) / 1e9;
    double throughput = N / elapsed;

    int bugs = atomic_load(&bug);
    printf("\nIterations: %d\n", N);
    printf("Time: %.3f s\n", elapsed);
    printf("Throughput: %.0f iter/s\n", throughput);
    printf("Anomalies: %d\n", bugs);
    return 0;
}
