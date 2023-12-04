module divide_1200000(
	input clk,					// 12MHz时钟
	output reg clk_out		// 10Hz时钟
);

reg [20:0]cnt;					// 21位计数器

always @(posedge clk)begin

	if(cnt==21'd1199999)
		cnt<=0;
	else
		cnt<=cnt+1;
	
	if(cnt<21'd600000)
		clk_out<=0;
	else
		clk_out<=1;

end


endmodule