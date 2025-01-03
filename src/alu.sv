module FA(input logic a, b, cin, output logic sum, cout);
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (b & cin) | (cin & a);
endmodule

module RCA(input logic [31:0] a, b, output logic [31:0] sum, output logic cout);
  logic [32:0] carry;
  assign carry[0] = 0;
  generate
    for (genvar i = 0; i < 32; i++) begin
      assign {carry[i+1], sum[i]} = a[i] + b[i] + carry[i];
    end
  endgenerate
  assign cout = carry[32];
endmodule

module subtractor(input logic [31:0] a, b, output logic [31:0] diff, output logic ov);
  logic [31:0] neg_b;
  logic cout;
  
  assign neg_b = ~b + 1;
  
  RCA adder(.a(a), .b(neg_b), .sum(diff), .cout(cout));
  
  assign ov = (a[31] != b[31]) && (a[31] != diff[31]);
endmodule

module multiplier(input logic [31:0] a, b, output logic [63:0] prod);
  logic [63:0] partial_products[31:0];
  logic [63:0] temp_sum[32:0];
  logic carry_out[31:0];
  logic [31:0] sum[31:0];

  assign temp_sum[0] = 64'b0;

  generate
    for (genvar i = 0; i < 32; i++) begin
      assign partial_products[i] = (b[i]) ? (a << i) : 64'b0;
      RCA adder(.a(temp_sum[i][31:0]), .b(partial_products[i][31:0]), .sum(sum[i]), .cout(carry_out[i]));
      assign temp_sum[i+1][31:0] = sum[i];
      assign temp_sum[i+1][63:32] = temp_sum[i][63:32] + partial_products[i][63:32] + {31'b0, carry_out[i]};
    end
  endgenerate

  assign prod = temp_sum[32];
endmodule

module ALU(input logic [31:0] a, b, input logic [2:0] opcode, output logic [63:0] res, output logic ov);
  logic [31:0] sum, diff, quotient, remainder, s_r, s_l, and_o, or_o;
  logic [63:0] prod;
  logic carry;
  
  RCA adder(.a(a), .b(b), .sum(sum), .cout(carry));
  
  subtractor sub(.a(a), .b(b), .diff(diff), .ov(ov));
  
  multiplier mul(.a(a), .b(b), .prod(prod));
  
  assign quotient = (b != 0) ? a / b : 32'b0;
  assign remainder = (b != 0) ? a % b : 32'b0;
  
  assign s_r = a >> b[4:0];
  assign s_l = a << b[4:0];
  assign and_o = a & b;
  assign or_o = a | b;
  
  always_comb begin
    case(opcode)
      3'b000: begin
        res = {32'b0, sum};
        ov = carry;
      end
      3'b001: begin
        res = {32'b0, diff};
      end
      3'b010: begin
        res = prod;
        ov = 1'b0;
      end
      3'b011: begin
        res = {remainder, quotient};
        ov = 1'b0;
      end
      3'b100: begin
        res = {32'b0, s_r};
        ov = 1'b0;
      end
      3'b101: begin
        res = {32'b0, s_l};
        ov = 1'b0;
      end
      3'b110: begin
        res = {32'b0, and_o};
        ov = 1'b0;
      end
      3'b111: begin
        res = {32'b0, or_o};
        ov = 1'b0;
      end
      default: begin
        res = 64'b0;
        ov = 1'b0; 
      end
    endcase
  end
endmodule
