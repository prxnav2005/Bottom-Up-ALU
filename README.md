# Bottom-Up-ALU

A 32-Bit Bottom Up ALU. 

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


