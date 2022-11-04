clear;
close;
[y,fs]=audioread('./处理前1.wav');
fq = fft(y);
%获取频谱的半长度
length_half = floor(length(fq)/2);
%计算数字频率
f_x = fs/2*(0:length_half-1)/length_half;
figure(1);
%观察信号的频谱
plot(f_x,abs(fq(1:length_half)));
title('原始信号的频谱');
xlabel('频率(Hz)');
ylabel('幅度');
%初始化频谱输出
fo = zeros(1,length(y));
for i = 1:1:length(y)
    if(abs(fq(i)) >= 200)
        fo(i) = fq(i);  %截取大于幅度200的频率成分
    end
end
figure(2);
%观察截取到的频谱
plot(f_x,abs(fo(1:length_half)));
title('初步处理后的频谱');
xlabel('频率(Hz)');
ylabel('幅度');
%把初步处理的结果变换回时域
yo = ifft(fo);
%把初步处理的结果进行低通滤波
%获取FIR滤波序列
h = lowPass(0.1,0.125,0.017,0.017);
%分析滤波器
figure(4);
freqz(h);
%用卷积实现滤波
yo = conv(h,yo);
yof = fft(yo);
figure(3);
%观察低通滤波的结果的频谱
plot(f_x,abs(yof(1:length_half)));
title('最终输出的频谱');
xlabel('频率(Hz)');
ylabel('幅度');
%播放并保存结果
sound(yo,fs);
audiowrite('./处理后1.wav',yo,fs);


