# Bottom-Up-ALU

A 32-Bit Bottom Up ALU made using Ripple Carry Adder, Binary Multiplier(built using Full Adders) and other basic logical operations.

## ALU Opcode Operations

The ALU performs different operations based on the provided opcode. Below is a table that describes the ALU's operations:

| Opcode          | Operation        | Description                                                                 |
|-----------------|------------------|-----------------------------------------------------------------------------|
| `000`           | Addition (+)     | Performs the addition of `A` and `B`.                                         |
| `001`           | Subtraction (-)  | Performs the subtraction (`A - B`). Overflow is checked for signed numbers.  |
| `010`           | Multiplication (*) | Performs multiplication of `A` and `B` using a full adder-based multiplier. |
| `011`           | Division (/)     | Performs division (`A / B`) and returns both quotient and remainder. Handles division by zero. |
| `100`           | Right Shift (>>) | Performs arithmetic right shift on `A` by the number of positions specified in the lower 5 bits of `B`. |
| `101`           | Left Shift (<<)  | Performs logical left shift on `A` by the number of positions specified in the lower 5 bits of `B`. |
| `110`           | Bitwise AND (&)  | Performs bitwise AND operation between `A` and `B`.                          |
| `111`           | Bitwise OR       | Performs bitwise OR operation between `A` and `B`.                           |

### Notes:
- **Overflow (ov)**: For addition and subtraction, overflow is checked for signed operations, with overflow occurring when the sign bits do not match.
- **Division**: When `B` is zero, both the quotient and remainder are set to zero.
- **Shift Operations**: Both shift operations handle up to 32 positions (`A` is shifted by `B[4:0]`), ensuring that the number of shift positions is valid for 32-bit values.

### Working of the multiplier

-  Using the generate block, we iterate over each bit (from `0` to `31`). If the bit `b[i]` is `1`, a partial product is generated by shifting a left by `i` positions. If `b[i]` is `0`, the partial product is set to zero. This is assigned to `partial_products[i]`.

- An instance of an RCA adder is used to add the lower 32 bits of the running sum `(temp_sum[i][31:0])` and the current partial product `(partial_products[i][31:0])`. The sum is stored in `sum[i]`, and the carry out is stored in `carry_out[i]`.

- The sum of the lower 32 bits of the running total is assigned to the lower 32 bits of `temp_sum[i+1]`. The upper 32 bits of the running total are updated by adding the upper 32 bits of the current partial product and the carry-out, adjusted by shifting the carry-out to the appropriate position. The final product is assigned to `prod`. 
 

