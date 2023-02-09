module TB_sin_wave;
reg Din;
reg reset_n;
reg enable;
reg clk;
wire [15:0] out;

fsk_modulation Modulate(
	.out(out),
	.Din(Din),
	.clk(clk),
	.reset_n(reset_n),
	.enable(enable));

always
begin
    #1 clk=~clk;
end

initial
begin
// $monitor("out=%d Din=%d Mod=%d Freq=%d clk=%b",out,Din,Mod,Freq,clk);
    clk=0;Din=0;reset_n=0;enable =1;
	#5
	reset_n=1;
	enable =0;
            #1024 Din=1;
	reset_n=1;

            #1024 Din=0;
			enable =1;
			reset_n=1;
			#1024 Din=1;
            #1024 Din=0;
			#1024 Din=1;
            #1024 Din=0;
            #512 Din=1;
			#1020
            #512 Din=0;
			#1002
            #512 Din=0;
			repeat(500) begin
			#50
			Din=~Din;
			end
		$stop();
end


endmodule

module TB_fsk ();
	logic  Din,clk;                          //Din=input data stream 
	logic [15:0] out;    

FSK fsk_tb(
	.Din(Din),
	.clk(clk),
	.out(out)
);
always
begin
    #1 clk=~clk;
end
initial
begin
// $monitor("out=%d Din=%d Mod=%d Freq=%d clk=%b",out,Din,Mod,Freq,clk);
    clk=0;Din=0;
	#5

	#1024 Din=1;
	#1042 Din=0;
	#1024 Din=1;
	#1024 Din=0;
	#1024 Din=1;
	#1024 Din=0;

	#512 Din=1;
	#1020
	#512 Din=0;
	#1020
	#512 Din=0;
		$stop();
end


endmodule