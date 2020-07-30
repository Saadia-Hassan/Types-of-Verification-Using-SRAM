////Reference module for read operation//////
module SRAM_ref(input clk, rst, wr, [3:0] data, addr, output [3:0] out_exp);

SRAM4x16 REF_inst(clk, rst, wr, data, addr, out_exp);

endmodule


/////////Randomization test bench//////////////
module SRAM4x16_tb();

reg clk, rst_tb, wr;
reg [3:0] data, addr;
wire [3:0] out, out_exp;

SRAM4x16 DUT(clk, rst_tb, wr, data, addr, out);
SRAM_ref REF(clk, rst_tb, wr, data, addr, out_exp);

parameter SETUP_TIME = 1;
parameter HOLD_TIME = 1;
parameter TIME_PERIOD=10;

initial begin
clk = 0;
forever #5 clk = ~clk;
end

// Calling the write tasks
initial 
begin
ram_write_chk(1,1, $random,$random);

repeat(10) begin
ram_write_chk(0,1,$random, $random); end 

//Calling read task
repeat(10) begin
 ram_read_chk(0,0,$random); end
end

task ram_write_chk;

input rst_t;
input wr_t;
input [3:0] data_t;
input [3:0] addr_t;

begin
#(TIME_PERIOD/2-SETUP_TIME);
rst_tb=rst_t;
wr = wr_t;
data = data_t;
addr = addr_t;

@(posedge clk);
#(HOLD_TIME);
rst_tb=1'b0;
wr = ~wr;

#(TIME_PERIOD/2-SETUP_TIME);
if(wr_t==1'b1)
$display("Data written at %0t :: address = %b, data = %b", $time, addr_t, data_t);
else
$display("Error occured at %0t", $time);

end
endtask


task ram_read_chk;

input rst_t;
input wr_t;
input [3:0] addr_t;

begin
#(TIME_PERIOD/2-SETUP_TIME);
rst_tb=rst_t;
wr = wr_t;
addr = addr_t;

@(posedge clk);
#(HOLD_TIME);
rst_tb=1'b0;
wr = ~wr;

#(TIME_PERIOD/2-SETUP_TIME);
if((wr_t==1'b0) && (out==out_exp))
$display("Correct data read at %0t :: address = %b, data = %b", $time, addr_t, out);
else
$display("Error occured at %0t:: address = %b, data = %b", $time, addr_t, out);

end
endtask

endmodule




