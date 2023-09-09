module dec_to_disp
(
  input logic[3:0] dec,
  output logic[6:0] disp
);

always_comb begin
  case (dec)
    4'd0  : disp = 7'b1000000;
	 4'd1  : disp = 7'b1111001;
	 4'd2  : disp = 7'b0100100;
	 4'd3  : disp = 7'b0110000;
	 4'd4  : disp = 7'b0011001;
	 4'd5  : disp = 7'b0010010;
	 4'd6  : disp = 7'b0000010;
	 4'd7  : disp = 7'b1111000;
	 4'd8  : disp = 7'b0000000;
	 4'd9  : disp = 7'b0011000;
	 4'd10 : disp = 7'b0001000;
	 4'd11 : disp = 7'b0000011;
	 4'd12 : disp = 7'b1000110;
	 4'd13 : disp = 7'b0100001;
	 4'd14 : disp = 7'b0000110;
	 4'd15 : disp = 7'b0001110;
  endcase
end






endmodule