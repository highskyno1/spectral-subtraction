function h = lowPass(Fp,Fs,ds,dp)
%lowPass ���ذ�Ҫ����Ƶ�����FIR�˲���ʵ�ֶ������źŵĵ�ͨ�˲�
%     Fp ��ͨ����Ƶ��
%     Fs ͨ����ֹ����Ƶ��
%     ds �������
%     dp ͨ������
    f = [Fp Fs];
    a = [1 0];
    dev = [dp ds];
    [N,fo,ao,w] = remezord(f,a,dev);
    h = remez(N,fo,ao,w);   %ʱ����˲���
end