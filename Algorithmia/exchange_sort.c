//
//  bubble_sort.c
//  Algorithmia
//
//  Created by Borja Arias Drake on 11/12/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#include "exchange_sort.h"
#include "utils.h"
#include <math.h>



void init_queue(int64_t *array, int64_t *input, int64_t start, int64_t end);
void merge(int64_t *input, int64_t length, int64_t start, int64_t middle, int64_t end);
int64_t qs_partition(int64_t *input, int64_t start, int64_t end);

/*
 * Bubble sort finishes when the array is ordered
 * In each iteration or the internal loop, highest
 */
void bubble_sort_knuth(int64_t *input, int64_t length)
{
    
    int64_t highest_not_order_index = length; // Highest index for which the record is not know to be in its final position
    int64_t last_swapped_index = INT64_MAX; // Everytime we find an unordered element

    
    
    for (int i=0; i<length; i++)
    {
        printf("Comparing %d\n", i);
    }
    
    while (last_swapped_index > 0)
    {
        int64_t j = 0;
        
        while (j < (highest_not_order_index - 1))
        {
            //printf("Comparing %lld, %lld", input[j], input[j+1]);
            if (input[j] > input[j+1])
            {
                swap(input, j, j+1);
                last_swapped_index = j;
            }
            j++;
        }
        
        highest_not_order_index = last_swapped_index;
        

        if (last_swapped_index == INT64_MAX)
        {
            // No swaps, terminate
            last_swapped_index = 0;
        }
    }
    
    
    
}


/* bubble up */
void bubble_sort(int64_t *input, int64_t length)
{
    for (int64_t i = length; i >= 0; i--)
    {
        for (int64_t j = 0; j < i-1; j++)
        {
            if (input[j] > input[j+1])
            {
                swap(input, j, j+1);
            }            
        }
    }
}

/* Merge sort */

void merge_insertion_sort(int64_t *input, int64_t length, int64_t start, int64_t end)
{
    if (start < end)
    {
        // Divide
        int64_t middle_index = floor((double)(start + end) / 2.0);
        
        // Conquer
        merge_insertion_sort(input, length, start, middle_index);
        merge_insertion_sort(input, length, middle_index+1, end);
        
        // Combine
        merge(input, length, start, middle_index, end);
    }
    
}

void merge(int64_t *input, int64_t length, int64_t start, int64_t middle, int64_t end)
{
    int64_t first_part_size = (middle - start + 1);
    int64_t second_part_size = (end - middle);
    int64_t first_part[first_part_size];
    int64_t second_part[second_part_size];
    
    init_queue(first_part, input, start, middle);
    init_queue(second_part, input, middle+1, end);
    
    int64_t i = start;
    int64_t i_A = 0;
    int64_t i_B = 0;
    
    while ((i_A < first_part_size) && (i_B < second_part_size))
    {
        if (first_part[i_A] < second_part[i_B])
        {
            input[i++] = first_part[i_A++];
        }
        else
        {
            input[i++] = second_part[i_B++];
        }
    }
    
    while (i_A < first_part_size) {input[i++] = first_part[i_A++];}
    while (i_B < second_part_size) {input[i++] = second_part[i_B++];}
}

void init_queue(int64_t *array, int64_t *input, int64_t start, int64_t end)
{
    int64_t size = (end-start+1);
    for (int64_t i=0; i<size; i++)
    {
        array[i] = input[start+i];
    }
}


/* Quick sort*/
void quick_sort(int64_t *input, int64_t length, int64_t start, int64_t end)
{
    if (start < end)
    {
        int64_t pivot_index = qs_partition(input, start, end);
        quick_sort(input, length, start, pivot_index-1);
        quick_sort(input, length, pivot_index+1, end);
    }
}


int64_t qs_partition(int64_t *input, int64_t start, int64_t end)
{
    int64_t firsthigh = start; // Index of the first element that is bigger than the
    int64_t pivot_index = end;
    
    for (int64_t i = start; i<end; i++)
    {
        if (input[i] < input[pivot_index])
        {
            swap(input, i, firsthigh);
            firsthigh++;
        }
    }
    
    swap(input, firsthigh, pivot_index);
    
    return firsthigh;
}
