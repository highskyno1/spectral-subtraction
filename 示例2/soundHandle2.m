clear;
close;
[y,fs]=audioread('./����ǰ2.wav');
fq = fft(y);
f_len_half = floor(length(fq)/2);
f_x = fs/2*(0:f_len_half-1)/f_len_half;
figure(1);
%�۲�������Ƶ��
plot(f_x,abs(fq(1:f_len_half)));
title('ԭ�����źŵ�Ƶ��');
xlabel('Ƶ��(Hz)');
ylabel('����');
%��ȡƵ�׷���С��800�Ĳ���
fo = zeros(1,length(fq));
for i=1:1:length(fq)
    if abs(fq(i)) < 1000
        fo(i) = fq(i);
    end
end
figure(2);
plot(f_x,abs(fo(1:f_len_half)));%������Ƶ��
title('����������Ƶ��');
xlabel('Ƶ��(Hz)');
ylabel('����');
%��ȡ����1kHz���ֵķ���С��500�Ĳ���Ƶ��
low = 30000;    %��Ӧ1kHz
fo2 = [fo(1:low),zeros(1,length(fo)-2 * low),fo(length(fo)-low+1:length(fo))];
for i=low + 1:1:length(fo)-low
    if abs(fo(i)) < 450
        fo2(i) = fo(i);
    end
end
yout = ifft(fo2);%���źŴ�Ƶ�򷵻���ʱ��
figure(3);
yof = fft(yout);
long3 = floor(length(yof)/2);
fout = fs/2/long3*(0:long3-1);
plot(fout,abs(yof(1:long3)));
title('���մ�������Ƶ��');
xlabel('Ƶ��(Hz)');
ylabel('����');
sound(yout,fs);
audiowrite('./�����2.wav',yout,fs);