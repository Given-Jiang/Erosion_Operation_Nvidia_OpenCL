#define ROWS 576
#define COLS 720

__kernel
__attribute__((task))
void erosion(__global uchar* restrict img_in, __global uchar* restrict img_out, const unsigned int iterations)
{
    unsigned int count = 0;

    while(count != iterations)
    {	
		bool isMin = 0;
		if ( count > 2 * COLS + 17)
		{
			#pragma unroll
			for (int i = 0; i < 3 ; ++i)
			{
				#pragma unroll
				for (int j = 0; j < 17; ++j)
				{
					uchar pixel = img_in[ i * COLS + j + count ];
					if (pixel == 0)
					{
						isMin = 1;
					}else if (isMin != 1)
					{
						isMin = 0;
					}
				}
			}
			uchar temp = 0;
			if (isMin)
			{
				temp = 0;
			}else
			{
				temp = 255;
			}
			img_out[count++] = temp;
		}else
		{
			img_out[count++] = 0;
		}
	}
}


