function h = lowPass(Fp,Fs,ds,dp)
%lowPass 返回按要求设计的数字FIR滤波器实现对输入信号的低通滤波
%     Fp 低通数字频率
%     Fs 通带截止数字频率
%     ds 阻带波动
%     dp 通带波动
    f = [Fp Fs];
    a = [1 0];
    dev = [dp ds];
    [N,fo,ao,w] = remezord(f,a,dev);
    h = remez(N,fo,ao,w);   %时域的滤波器
end