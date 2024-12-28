// Code your design here
module mul(input logic [31:0] a,b, output logic [63:0] prod);
  logic[63:0] i_s;
  logic[63:0] s_a;
  
  always_comb
    begin
    i_s = 64'b0;
    for(int i = 0; i < 32; i++)
        begin
          if(b[i] == 1)
            begin
              s_a = a << i;
              i_s = i_s + s_a;
            end
        end
    end
  
  assign prod = i_s;
endmodule

module alu(input logic[31:0] a,b, input logic [2:0] opcode, output logic [63:0] res, output logic ov);
  
  logic [31:0] sum, diff, quotient, remainder, s_r, s_l, and_o, or_o;
  logic [63:0] prod;
  logic carry;
  
  logic[31:0] c_o;
  assign {carry,sum} = a+b;
  
  logic[31:0] neg_b;
  assign neg_b = (~b) + 1;
  assign diff = a + neg_b;
  
  mul multiplier(.a(a), .b(b), .prod(prod));
  
  assign quotient = (b != 0) ? a/b : 32'b0;
  assign remainder = (b != 0) ? a%b : 32'b0;
  
  assign s_r = a >> b[4:0];
  assign s_l = a << b[4:0];
  
  assign and_o = a & b;
  assign or_o = a | b;
  
  always_comb
    begin
      case(opcode)
        3'b000 : begin
          res = {32'b0, sum};
          ov = carry;
        end
        3'b001 : begin
          res = {32'b0, diff};
          ov = (a[31] != b[31]) && (a[31] != diff[31]);
        end
        3'b010 : begin
          res = prod;
          ov = 1'b0;
        end
        3'b011 : begin
          res = {remainder,quotient};
          ov = 1'b0;
        end
        3'b100 : begin
          res = {32'b0, s_r};
          ov = 1'b0;
        end
        3'b101 : begin
          res = {32'b0, s_l};
          ov = 1'b0;
        end
        3'b110 : begin
          res = {32'b0, and_o};
          ov = 1'b0;
        end
        3'b111 : begin
          res = {32'b0, or_o};
          ov = 1'b0;
        end
        default : begin
          res = 64'b0;
          ov = 1'b0;
        end
      endcase
    end
endmodule