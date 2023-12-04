module debounce(
	input key,					// 未防抖信号
	input clk_12MHz,			// 12MHz时钟
	output reg key_out		// 防抖后信号
);

reg [12:0]cnt;		// 13位计数器

always @(posedge clk_12MHz)begin
	if(key)
		cnt <= 0;
	else if(cnt==13'd120000)
		cnt <= 13'd120000;
	else
		cnt <= cnt+1;
		
	if(cnt==13'd119999)
		key_out <=1'b1;
	else
		key_out <=1'b0;
end


endmodule