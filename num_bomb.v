module num_bomb(
	input clk_12MHz,		// 12MHz的时钟
	input [3:0]sw,			// 控制数字大小
	input inum_1,			// 输入数字1
	input inum_2,			// 输入数字2
	input confirm,			// 确认数字
	input reset,			// 重置游戏
	output reg [2:0] rgb_left,			// 左侧rgb灯
	output reg [2:0] rgb_right,		// 右侧rgb灯
	output [7:0] led,						// led灯
	output [8:0] seg_left,				// 左侧数码管
	output [8:0] seg_right				// 右侧数码管
);

// 数码管显示
reg [8:0] seg[9:0];
initial begin
	seg[0]<=9'h3f;
	seg[1]<=9'h06;
	seg[2]<=9'h5b;
	seg[3]<=9'h4f;
	seg[4]<=9'h66;
	seg[5]<=9'h6d;
	seg[6]<=9'h7d;
	seg[7]<=9'h07;
	seg[8]<=9'h7f;
	seg[9]<=9'h6f;
end

assign seg_left	=	seg[num_1];
assign seg_right	=	seg[num_2];

// led显示
reg [7:0]led_st[8:0];
reg [3:0]state;
initial begin
	led_st[0]<=8'b1111_1111;
	led_st[1]<=8'b1111_1110;
	led_st[2]<=8'b1111_1101;
	led_st[3]<=8'b1111_1011;
	led_st[4]<=8'b1111_0111;
	led_st[5]<=8'b1110_1111;
	led_st[6]<=8'b1101_1111;
	led_st[7]<=8'b1011_1111;
	led_st[8]<=8'b0111_1111;
end
assign led=led_st[state];

// 数字设置
reg [3:0]num_1_ans;		// 数字1正确答案
reg [3:0]num_2_ans;		// 数字2正确答案
reg [3:0]num_1;			// 数字1
reg [3:0]num_2;			// 数字2

initial begin
	num_1_ans = 4'd5;
	num_2_ans = 4'd5;
end

// 标志位
reg is_confirm;
reg is_change;
initial begin
	is_confirm<=0;
	is_change<=0;
end

// 交互设计
always @(posedge confirm_out,posedge reset_out,posedge inum_1_out,posedge inum_2_out,posedge clk_10Hz)begin
	if(reset_out)begin				// 复位（重启）
		rgb_left<=3'b111;
		rgb_right<=3'b111;
		state<=4'd0;
		num_1<=4'd0;
		num_2<=4'd0;
		num_1_ans<=b;
		num_2_ans<=c;
	end
	else if(inum_1_out)begin		// 确认数字1
		num_1<=sw;
	end
	else if(inum_2_out)begin		// 确认数字2
		num_2<=sw;
	end
	else if(confirm_out)begin			// 按下确认键
		is_confirm<=1'b1;
	end
	else if(is_confirm)begin	// 循环led灯
		if(!state)
			state<=4'd8;
		else if(state==4'd1)begin
			state<=4'd0;
			is_confirm<=1'b0;
			if(num_1>num_1_ans)begin		// 数字大
				rgb_left  <= 3'b110;
				rgb_right <= 3'b110;
			end
			else if(num_1<num_1_ans)begin	// 数字小
				rgb_left  <= 3'b101;
				rgb_right <= 3'b101;
			end
			else if(num_2>num_2_ans)begin	// 数字大
				rgb_left  <= 3'b110;
				rgb_right <= 3'b110;
			end
			else if(num_2<num_2_ans)begin	// 数字小
				rgb_left  <= 3'b101;
				rgb_right <= 3'b101;
			end
			else begin							// bomb!
				rgb_left  <= 3'b011;
				rgb_right <= 3'b011;
			end
		end
		else
			state<=state-1;
	end
	else begin
		rgb_left  <= rgb_left;
		rgb_right <= rgb_right;
	end
end

// 产生随机数
reg [3:0] b,c;
always@(posedge clk_10Hz) begin
	if(b<4'd9)
		b<=b+1;
	else
		b<=4'd0;
end 
always@(posedge clk_100Hz) begin
	if(c<4'd9)
		c<=c+1;
	else
		c<=4'd0;
end 


//-----------调用模块---------------
wire inum_1_out,inum_2_out,confirm_out,reset_out;		// 防抖动后信号
debounce d_1(inum_1,clk_12MHz,inum_1_out),
			d_2(inum_2,clk_12MHz,inum_2_out),
			d_3(confirm,clk_12MHz,confirm_out),
			d_4(reset,clk_12MHz,reset_out);

wire clk_10Hz,clk_100Hz;							// 时钟分频
divide_1200000 dd_1(clk_12MHz,clk_10Hz);
divide_120000 dd_2(clk_12MHz,clk_100Hz);

endmodule