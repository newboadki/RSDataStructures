//
//  measurement.c
//  Algorithmia
//
//  Created by Borja Arias Drake on 06/12/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#include "measurement.h"
#include <time.h>

double calculate_best_running_time(void (* method)(int64_t *, int64_t, int64_t, int64_t), int64_t *input, int64_t length, int number_of_times);



running_time_measurement_t measure_method(void (* method)(int64_t *, int64_t, int64_t, int64_t), int64_t *best_case_input, int64_t best_case_length, int64_t *worst_case_input, int64_t worst_case_length, int64_t *random_case_input, int64_t random_case_length)
{
    running_time_measurement_t times = {0, 0, 0};
    
    times.best_case_time_elapsed = calculate_best_running_time(method, best_case_input, best_case_length, 5);
    times.random_case_time_elapsed = calculate_best_running_time(method, random_case_input, random_case_length, 5);
    times.worst_case_time_elapsed = calculate_best_running_time(method, worst_case_input, worst_case_length, 5);
    
    return times;
}


double calculate_best_running_time(void (* method)(int64_t *, int64_t, int64_t, int64_t), int64_t *input, int64_t length, int number_of_times)
{
//    double best_time = 1000000.0;
    double time = 0.0;
    
    time_t initial_time, final_time;
    
    
    
    // COPY THE INPUTS BEFORE EACH RUN !!!!
//    for (int i=0; i< number_of_times; i ++)
//    {
        initial_time = clock();
        (*method)(input, length, 0, length-1);
        final_time = clock();
        time = ((double)(final_time - initial_time) / CLOCKS_PER_SEC);

//        if (time < best_time)
//        {
//            best_time = time;
//        }
//    }
    
    return time;
}