///////////  SRAM Design  //////////////
module SRAM4x16(input clk, rst, wr, 
		input [3:0] data, addr,
		output reg [3:0] out);

reg [3:0] mem [15:0];

always@(posedge clk)
begin
if (rst)
   out <= 0;
else
begin
   if (wr)  //wr is for write
	mem[addr] <= data;
   else 
	out <= mem[addr];
end
end

endmodule
