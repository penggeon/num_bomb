module divide_120000(
	input clk,					// 12MHz时钟
	output reg clk_out		// 100Hz时钟
);

reg [16:0]cnt;					// 17位计数器

always @(posedge clk)begin

	if(cnt==17'd119999)
		cnt<=0;
	else
		cnt<=cnt+1;
	
	if(cnt<17'd60000)
		clk_out<=0;
	else
		clk_out<=1;

end


endmodule