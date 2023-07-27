# calculate simple arithmetic expressions
:1234::heavy_plus_sign:/:heavy_minus_sign:/:heavy_multiplication_x::1234:=:question:

This shell script calculates all possible solutions from provided numbers using simple arithmetic operations, excluding exponentiation  (+, -, *, /). You can also provide a desired solution. Then the script provides those options that evaluate to your solution.

### Usage
The script takes 2 input parameters that are provided via flags:
* `-i`: followed by the input numbers, separated by white space. At least two numbers have to be provided.
* `-s`: followed by the desired solution (optional).

### Algorithm
First, all possible combinations of simple arithmetic operations are calculated.<br/>
Next, combinations with calculations resulting in a non-integer solution (division with remainder) are irgnored.<br/>
Finally, the calculations based on all combinations are evaluated, compared to the desired solution, if provided, and then printed,

### Example 1
sample command: `sh calculate.sh -i 1 4 2`

output:
* 1 + 4 + 2  = 7
* 1 + 4 - 2  = 3
* 1 + 4 * 2  = 9
* 1 + 4 / 2  = 3
* 1 - 4 + 2  = -1
* 1 - 4 - 2  = -5
* 1 - 4 * 2  = -7
* 1 - 4 / 2  = -1
* 1 * 4 + 2  = 6
* 1 * 4 - 2  = 2
* 1 * 4 * 2  = 8
* 1 * 4 / 2  = 2

output not provided:  1 / 4 ... since the division has a remainder

### Example 2
sample command: `sh calculate.sh -i 1 4 2 -s 2`

output:
* 1 * 4 - 2  = 2
* 1 * 4 / 2  = 2


