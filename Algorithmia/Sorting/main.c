//
//  main.c
//  Algorithmia
//
//  Created by Borja Arias Drake on 06/12/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#include <stdio.h>
#include "measurement.h"
#include "sorting.h"
#include <stdlib.h>

void fill_random(int64_t *input, int64_t size, int64_t max);
void fill_ordered(int64_t *input, int64_t size, int64_t max, int asc);
int verify(int64_t *input, int64_t size);

int main(int argc, const char * argv[])
{
//    void (* straight_insertion_sort_pointer)(int64_t *, int64_t) = &straight_insertion_sort;
//    void (* merge_insertion_pointer)(int64_t *, int64_t, int64_t start, int64_t end) = &merge_insertion_sort;
//    void (* bubble_sort_knuth_pointer)(int64_t *, int64_t) = &bubble_sort_knuth;
//    void (* bubble_sort_pointer)(int64_t *, int64_t) = &bubble_sort;
    void (* quicksort_pointer)(int64_t *, int64_t, int64_t start, int64_t end) = &quick_sort;

    int64_t n = 50000;
    int64_t MAX = 70000;
    int64_t input[n];
    int64_t best_case_input[n];
    int64_t worst_case_input[n];

    // GENERATE RANDOM
    fill_ordered(best_case_input, n, MAX, 1);
    fill_random(input, n, MAX);
    fill_ordered(worst_case_input, n, MAX, 0);
    
    running_time_measurement_t times_best = measure_method(quicksort_pointer, best_case_input, n, worst_case_input, n, input, n);
    printf("**** RUN insertion_sort *****\n");
    printf(" - Best: %f, correct:%d\n", times_best.best_case_time_elapsed, verify(best_case_input, n));
    printf(" - Random: %f, correct:%d\n", times_best.random_case_time_elapsed, verify(input, n));
    printf(" - Worst: %f, correct:%d\n", times_best.worst_case_time_elapsed, verify(worst_case_input, n));
    
    return 0;
}


void fill_random(int64_t *input, int64_t size, int64_t max)
{
    for (int i=0; i<size; i++)
    {
        input[i] = rand() % max;
    }
}

void fill_ordered(int64_t *input, int64_t size, int64_t max, int asc)
{
    for (int i=0; i<size; i++)
    {
        if (asc)
        {
            input[i] = i;
        }
        else
        {
            input[i] = size - i;
        }
    }
}



int verify(int64_t *input, int64_t size)
{
    int success = 1;
    
    for (int64_t i=0; i < size-1; i++)
    {
        
        if (input[i] > input[i+1])
        {
            success = 0;
            printf("ERROR!!!! %lld:%lld, %lld:%lld", i, input[i], i+1, input[i+1]);
            break;
        }
    }
    
    return success;

}
