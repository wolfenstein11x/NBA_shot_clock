module mux3
#(parameter n = 4)
(input logic[n-1:0] a, b, c,
 input logic[1:0] sel,
 output logic[n-1:0] y
);

always_comb begin
  case(sel)
    2'b10: y = a;
    2'b01: y = b;
    2'b00: y = c;
    default: y = 0;
  endcase
end

endmodule