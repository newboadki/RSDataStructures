//
//  bubble_sort.h
//  Algorithmia
//
//  Created by Borja Arias Drake on 11/12/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//


#include <stdio.h>

void bubble_sort_knuth(int64_t *input, int64_t length);
void bubble_sort(int64_t *input, int64_t length);
void merge_insertion_sort(int64_t *input, int64_t length, int64_t start, int64_t end);
void quick_sort(int64_t *input, int64_t length, int64_t start, int64_t end);