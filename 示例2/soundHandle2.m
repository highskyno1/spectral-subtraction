clear;
close;
[y,fs]=audioread('./处理前2.wav');
fq = fft(y);
f_len_half = floor(length(fq)/2);
f_x = fs/2*(0:f_len_half-1)/f_len_half;
figure(1);
%观察声音的频谱
plot(f_x,abs(fq(1:f_len_half)));
title('原声音信号的频谱');
xlabel('频率(Hz)');
ylabel('幅度');
%截取频谱幅度小于800的部分
fo = zeros(1,length(fq));
for i=1:1:length(fq)
    if abs(fq(i)) < 1000
        fo(i) = fq(i);
    end
end
figure(2);
plot(f_x,abs(fo(1:f_len_half)));%处理后的频谱
title('初步处理后的频谱');
xlabel('频率(Hz)');
ylabel('幅度');
%截取大于1kHz部分的幅度小于500的部分频谱
low = 30000;    %对应1kHz
fo2 = [fo(1:low),zeros(1,length(fo)-2 * low),fo(length(fo)-low+1:length(fo))];
for i=low + 1:1:length(fo)-low
    if abs(fo(i)) < 450
        fo2(i) = fo(i);
    end
end
yout = ifft(fo2);%把信号从频域返回至时域
figure(3);
yof = fft(yout);
long3 = floor(length(yof)/2);
fout = fs/2/long3*(0:long3-1);
plot(fout,abs(yof(1:long3)));
title('最终处理结果的频谱');
xlabel('频率(Hz)');
ylabel('幅度');
sound(yout,fs);
audiowrite('./处理后2.wav',yout,fs);