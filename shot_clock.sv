module shot_clock
(input logic clk, rst, pause, unpause,
 output logic[6:0] count0_disp,
 output logic[6:0] count1_disp,
 output logic[9:0] debug_leds);
 

// pause/unpause hardware
logic master_en;
pauser p(clk, rst, pause, unpause, master_en);
//

// internal counter outputs
logic[31:0] clk_count;
logic clk_count_at_max;
logic[1:0] cde2_count;
logic[3:0] cde4_count;
logic[3:0] cde9_count;
logic[3:0] cde9_2_count;

// count values that feed into 7 segment display
logic[3:0] count0, count1;

// counter enablers
logic cde2_en, cde4_en, cde9_en, cde9_2_en;

// signals that indicate if a counter is at zero, which is used to enable another counter
logic cde2_at_zero, cde4_at_zero, cde9_at_zero, cde9_2_at_zero;

// counter enablers
assign cde2_en = (((clk_count_at_max & cde4_at_zero & cde2_count == 2) | (clk_count_at_max & cde9_at_zero & cde2_count == 1)) & master_en);
assign cde4_en = (clk_count_at_max & master_en);
assign cde9_en = ((clk_count_at_max & (cde2_count != 2)) & master_en);
assign cde9_2_en = ((clk_count_at_max & cde9_at_zero & cde2_at_zero) & master_en);

// counter instances
counter_up cu(clk, rst, clk_count, clk_count_at_max);
counter_down_en #(2, 2) cde2(clk, rst, cde2_en, cde2_count, cde2_at_zero);
counter_down_en #(4, 3) cde4(clk, rst, cde4_en, cde4_count, cde4_at_zero);
counter_down_en #(9, 4) cde9(clk, rst, cde9_en, cde9_count, cde9_at_zero);
counter_down_en #(9, 4) cde9_2(clk, rst, cde9_2_en, cde9_2_count, cde9_2_at_zero);

// logic for 2 input mux that determines which counter to connect to the 1st 7-seg display (counter cde2_en is always connected to the 2nd 7-seg display)
logic[3:0] a, b, c, y;
logic[1:0] sel;
assign a = cde4_count;
assign b = cde9_count;
assign c = cde9_2_count;
assign sel = cde2_count;

mux3 m3(a, b, c, sel , count0);
assign count1 = {2'b00, cde2_count};
// end of mux logic

// convert 4-bit count values to 7 bits for 7-seg display
dec_to_disp dtd0(count0, count0_disp);
dec_to_disp dtd1(count1, count1_disp);
 
// debug leds
//assign debug_leds[0] = master_en;
assign debug_leds[9:0] = 10'h0;
 
 endmodule