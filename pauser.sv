module pauser(
  input logic clk, rst, pause, unpause,
  output logic master_en);
  
logic n1, n2;

assign n1 = (pause & master_en);
assign n2 = n1 | ~unpause;

always_ff @(posedge clk) begin
  if(!rst)
    master_en <= 1'b0;
  else
    master_en <= n2;
end
  
  
  
  
endmodule