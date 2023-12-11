本代码仅供参考，切勿抄袭（小心查重[doge]）！！！

# 一、 概况

实现数字炸弹游戏设计，空闲时间也能开心一刻！

# 二、 功能设计

![image](https://github.com/polar-bei/num_bomb/assets/116292674/c6ae37b0-c106-45fd-ad62-5f2acab89a8e)

# 三、 代码说明

## 3.1 顶层模块

（1）数码管显示

![image](https://github.com/polar-bei/num_bomb/assets/116292674/fe46b54d-05de-476c-8c31-7d6112e98353)

（2） led 显示

![image](https://github.com/polar-bei/num_bomb/assets/116292674/fa2e2799-b141-4521-a6c2-f0f3cecaa388)

（3）数字设置

![image](https://github.com/polar-bei/num_bomb/assets/116292674/af5a2ee3-d64a-4a8b-a88d-ea490eb55b31)

（4）主要程序设计（即人机交互）

利用标志位的设置，实现确认后流水灯以及 RGB 的控制（代码较多，暂不展示）

（5）随机数生成

![image](https://github.com/polar-bei/num_bomb/assets/116292674/e1f028b1-441c-41a9-9b6a-5ad9e2471878)

（6）模块调用

![image](https://github.com/polar-bei/num_bomb/assets/116292674/2f3d809d-c69a-42ac-b868-c0c49417b1d2)

## 3.2 防抖模块

利用计数器实现消抖：当计数时间达到 10ms（计数值约为 12 万）时，可认为一次有效输出（高电平）

![image](https://github.com/polar-bei/num_bomb/assets/116292674/f42ba6fa-7d6a-4ed2-9a9f-9f11c76666bc)

## 3.3 时钟分频

利用计数器，实现偶数分频：当计数未达到总数一半时输出低电平，反之输出高电平，同时设计不同的总数，实现不同的分频。

产生 100Hz 时钟：

![image](https://github.com/polar-bei/num_bomb/assets/116292674/a694500f-c055-41bb-9a95-41feeaefb8e0)

产生 10Hz 时钟：

![image](https://github.com/polar-bei/num_bomb/assets/116292674/80df348f-8be3-445d-8128-2981e3df7362)

# 四、 视频演示

链接： https://www.bilibili.com/video/BV1NM411z7K9

