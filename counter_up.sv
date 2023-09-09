module counter_up
#(parameter max=50000000, n=32)
(input logic clk, rst,
 output logic[n-1:0] count,
 output logic at_max
);

always_ff @(posedge clk) begin
  if (!rst)
    count <= 0;
  else if (count == max)
    count <= 0;
  else
    count <= count + 1;
end



assign at_max = (count == max);






endmodule