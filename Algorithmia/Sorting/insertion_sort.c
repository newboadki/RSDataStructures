//
//  insertion_sort.c
//  Algorithmia
//
//  Created by Borja Arias Drake on 06/12/2014.
//  Copyright (c) 2014 Borja Arias Drake. All rights reserved.
//

#include "insertion_sort.h"
#include "utils.h"

/*
 * Keeps the ordered elements at the beginning
 * Best case:  O(n) because the internal loop would be executed once for each value of i
 * Worst case: O(n^2)
 */
void straight_insertion_sort(int64_t *input, int64_t length)
{
    for (int i=1; i<length; i++)
    {
        int j = (i - 1);
        
        while ((j >= 0) && (input[j] > input[j + 1]))
        {
            swap(input, j, j+1);
            j--;
        }
    }
}




