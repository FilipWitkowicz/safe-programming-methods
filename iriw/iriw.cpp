#include <iostream>
#include <atomic>
#include <pthread.h>

using namespace std;

const int THREADS_PER_GROUP = 4;

// alignas(64)
struct alignas(64) ThreadsGroup {
    atomic<int> x, y;
    int x2, y2, y3, x3;
    int violations;
    pthread_barrier_t go, done;
};

// Args for threads
struct Args {
    ThreadsGroup* group;
    int role;
    int core;
    int ITERATIONS;
};



void* thread_func(void* ptr) {
    Args* a = (Args*)ptr;
    ThreadsGroup& g = *a->group;

    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(a->core, &cpuset);
    pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);

    for (int i = 0; i < a->ITERATIONS; i++) {
        pthread_barrier_wait(&g.go); // start

        if (a->role == 0)
        {
            g.x.store(1, memory_order_relaxed);
        }
        else if (a->role == 1) 
        { 
            g.x2 = g.x.load(memory_order_relaxed);
            g.y2 = g.y.load(memory_order_relaxed); 
        }
        else if (a->role == 2) 
        { 
            g.y3 = g.y.load(memory_order_relaxed);
            g.x3 = g.x.load(memory_order_relaxed); 
        }
        else
        { 
            g.y.store(1, memory_order_relaxed);
        }

        pthread_barrier_wait(&g.done);  // stop

        // check and reset (thread 0)
        if (a->role == 0) {
            if (g.x2 == 1 && g.y2 == 0 && g.y3 == 1 && g.x3 == 0)
                g.violations++;
            g.x.store(0, memory_order_relaxed);
            g.y.store(0, memory_order_relaxed);
        }
    }
    return nullptr;
}

int main(int argc, char* argv[]) {
    int CORES = atoi(argv[1]);
    int ITERATIONS = atoi(argv[2]);
    int NUM_GROUPS = CORES / THREADS_PER_GROUP;

    cout << "[LOG] " << NUM_GROUPS << " groups, " << CORES << " cores, " << ITERATIONS << " iterations" << endl;

    ThreadsGroup* groups = new ThreadsGroup[NUM_GROUPS];
    pthread_t* thr = new pthread_t[CORES];
    Args* args = new Args[CORES];

    // group initialization
    for (int i = 0; i < NUM_GROUPS; i++) {
        groups[i].x = 0;
        groups[i].y = 0;
        groups[i].x2 = groups[i].y2 = groups[i].y3 = groups[i].x3 = 0;
        groups[i].violations = 0;
        pthread_barrier_init(&groups[i].go, nullptr, THREADS_PER_GROUP);
        pthread_barrier_init(&groups[i].done, nullptr, THREADS_PER_GROUP);
    }

    // thread creation
    for (int i = 0; i < CORES; i++) {
        args[i] = { &groups[i / THREADS_PER_GROUP], i % THREADS_PER_GROUP, i, ITERATIONS };
        pthread_create(&thr[i], nullptr, thread_func, &args[i]);
    }

    for (int i = 0; i < CORES; i++)
        pthread_join(thr[i], nullptr);

    // count violations
    int violations = 0;
    for (int i = 0; i < NUM_GROUPS; i++) {
        violations += groups[i].violations;
        pthread_barrier_destroy(&groups[i].go);
        pthread_barrier_destroy(&groups[i].done);
    }

    delete[] groups;
    delete[] thr;
    delete[] args;

    // NUM_GROUPS, CORES, ITERATIONS, VIOLATIONS
    cout << NUM_GROUPS << "," << CORES << "," << ITERATIONS << "," << violations << endl;
    return 0;
}