/////// Golden Vector Testbench /////////
module tb_golden_SRAM();
reg clk, rst, wr;
reg [3:0] data, addr;
wire [3:0] out;

integer i, j = 4'd15;

integer k = 4'd15;

SRAM4x16 DUT(clk, rst, wr, data, addr, out);

/////////////// Parameters for Timing ///////
parameter SETUP_TIME = 1;
parameter HOLD_TIME = 1;
parameter TIME_PERIOD=10;

initial begin
clk = 0;
forever #5 clk = ~clk;
end


// Calling the write task

initial begin
 SRAM_write(1, 1, 1111, 0110);

for(i = 0; i<16; i = i+1) begin
 #1    SRAM_write(0, 1, i, j);    // j is the data, i is the address
	j = j - 1;        end

// Calling the read task

for(i = 0; i<16; i = i+1)  begin
 SRAM_read(0, 0, i, k);    //k is the exp_out, i is the address
 k = k - 1;                end

end

////////// Task for write function //////////
task SRAM_write;
input rst_t;
input wr_t;
input [3:0] addr_t;
input [3:0] data_t;

begin
#(TIME_PERIOD/2-SETUP_TIME);
rst = rst_t;
wr = wr_t;
addr = addr_t;
data = data_t;

@(posedge clk);
#(HOLD_TIME);
rst = 1'b0;
wr = ~wr;
addr = 4'bx;
data = 4'bx;

#(TIME_PERIOD/2-SETUP_TIME);
if(wr_t)
$display("Data entered at %0t :: address = %b, data = %b", $time, addr_t, data_t);
else
$display("Some error occured at %0t :: address = %b, data = %b", $time, addr_t, data_t);

end
endtask


//////////// Task for read function ///////
task SRAM_read;
input rst_t;
input wr_t;
input [3:0] addr_t;
input [3:0] exp_out;

begin
#(TIME_PERIOD/2-SETUP_TIME);
rst = rst_t;
wr = wr_t;
addr = addr_t;

@(posedge clk);
#(HOLD_TIME);
rst = 1'b0;
wr = ~wr;
addr = 4'bx;

#(TIME_PERIOD/2-SETUP_TIME);
if(out == exp_out)
$display("Correct Data read at %0t :: address = %b, output = %b", $time, addr_t, out);
else
$display("Wrong data read at %0t :: address = %b, output = %b, exp_out = %b", $time, addr_t, out, exp_out);

end
endtask

endmodule










