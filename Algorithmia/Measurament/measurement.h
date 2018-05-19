//
//  measurement.h
//  Algorithmia
//
//  Created by Borja Arias Drake on 06/12/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#ifndef __Algorithmia__measurement__
#define __Algorithmia__measurement__

#include <stdio.h>

typedef struct
{
    double best_case_time_elapsed;
    double worst_case_time_elapsed;
    double random_case_time_elapsed;
    
} running_time_measurement_t;


running_time_measurement_t measure_method(void (* method)(int64_t *, int64_t, int64_t, int64_t), int64_t *best_case_input, int64_t best_case_length, int64_t *worst_case_input, int64_t worst_case_length, int64_t *random_case_input, int64_t random_case_length);

#endif /* defined(__Algorithmia__measurement__) */
