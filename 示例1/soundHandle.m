clear;
close;
[y,fs]=audioread('./����ǰ1.wav');
fq = fft(y);
%��ȡƵ�׵İ볤��
length_half = floor(length(fq)/2);
%��������Ƶ��
f_x = fs/2*(0:length_half-1)/length_half;
figure(1);
%�۲��źŵ�Ƶ��
plot(f_x,abs(fq(1:length_half)));
title('ԭʼ�źŵ�Ƶ��');
xlabel('Ƶ��(Hz)');
ylabel('����');
%��ʼ��Ƶ�����
fo = zeros(1,length(y));
for i = 1:1:length(y)
    if(abs(fq(i)) >= 200)
        fo(i) = fq(i);  %��ȡ���ڷ���200��Ƶ�ʳɷ�
    end
end
figure(2);
%�۲��ȡ����Ƶ��
plot(f_x,abs(fo(1:length_half)));
title('����������Ƶ��');
xlabel('Ƶ��(Hz)');
ylabel('����');
%�ѳ�������Ľ���任��ʱ��
yo = ifft(fo);
%�ѳ�������Ľ�����е�ͨ�˲�
%��ȡFIR�˲�����
h = lowPass(0.1,0.125,0.017,0.017);
%�����˲���
figure(4);
freqz(h);
%�þ��ʵ���˲�
yo = conv(h,yo);
yof = fft(yo);
figure(3);
%�۲��ͨ�˲��Ľ����Ƶ��
plot(f_x,abs(yof(1:length_half)));
title('���������Ƶ��');
xlabel('Ƶ��(Hz)');
ylabel('����');
%���Ų�������
sound(yo,fs);
audiowrite('./�����1.wav',yo,fs);


