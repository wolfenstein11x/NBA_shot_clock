module counter_down_en
#(parameter max = 9, n = 4)
(input logic clk, rst, en,
 output logic[n-1:0] count,
 output logic at_zero);
 
 always_ff @(posedge clk) begin
   if(!rst)
	  count <= max;
	else if (count == 0)
	  count <= 0;
	else if (en)
	  count <= count - 1;
	else
	  count <= count;
 end
 
 assign at_zero = (count == 0);
 
 endmodule