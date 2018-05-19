//
//  utils.c
//  Algorithmia
//
//  Created by Borja Arias Drake on 09/12/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#include "utils.h"


void swap(int64_t *input, int64_t i, int64_t j)
{
    int64_t temp = input[i];
    input[i] = input[j];
    input[j] = temp;
}