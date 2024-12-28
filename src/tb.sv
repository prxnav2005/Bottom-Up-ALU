module alu_tb;
  logic [31:0] a, b;
  logic [2:0] opcode;
  logic [63:0] res;
  logic ov;
  
  alu DUT(.a(a), .b(b), .opcode(opcode), .res(res), .ov(ov));

  initial begin
    a = 32'hA5A5A5A5;
    b = 32'h5A5A5A5A;
    opcode = 3'b000;
    #10;
    
    a = 32'hA5A5A5A5;
    b = 32'h5A5A5A5A;
    opcode = 3'b001;
    #10;
    
    a = 32'hA5A5A5A5;
    b = 32'h5A5A5A5A;
    opcode = 3'b010;
    #10;
    
    a = 32'hA5A5A5A5;
    b = 32'h5A5A5A5A;
    opcode = 3'b011;
    #10;
    
    a = 32'hA5A5A5A5;
    b = 32'h5A5A5A5A;
    opcode = 3'b100;
    #10;
    
    a = 32'hA5A5A5A5;
    b = 32'h5A5A5A5A;
    opcode = 3'b101;
    #10;
    
    a = 32'hA5A5A5A5;
    b = 32'h5A5A5A5A;
    opcode = 3'b110;
    #10;
    
    a = 32'hA5A5A5A5;
    b = 32'h5A5A5A5A;
    opcode = 3'b111;
    #10;
    
    $stop;
  end
endmodule