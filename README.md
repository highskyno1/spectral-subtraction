# spectral-subtraction
两个谱减法实现高斯噪声滤除的例子
@[TOC](两个谱减法滤波的例子)
# 前言
首先祝大家元宵节快乐，这是在本科的时候《离散信号处理》的一个作业，今天整理硬盘发现了，发上来给大家作为谱减法的入门参考。
# 示例1（宽带白噪声的滤除）
## 频谱分析
拿到信号，第一步一般是先观察信号的频谱。
![宽带白噪声污染下的信号频谱](https://img-blog.csdnimg.cn/20210226114109922.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTQ3NjU2Mg==,size_16,color_FFFFFF,t_70)
从上图可以看出，此噪声是一个宽带白噪声，幸运的是噪声并没有把有用的频谱成分淹没。
## 谱减法初步处理
通过观察，有用信号的频谱振幅基本都在 200 以上，所以只要截取频谱幅度大于 200 的部分，就可以基本保留原始信号的主要信息，并且可以较好地过滤掉宽带白噪声。
截取结果如下图所示。
![截取频谱幅度大于 200 的部分后](https://img-blog.csdnimg.cn/20210226114456851.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTQ3NjU2Mg==,size_16,color_FFFFFF,t_70)
以上初步处理结果试听后，发现声音中仍然有尖锐的声音，这可能是由上图中的 6kHz 到 8kHz 以及2kHz附近的高频噪声导致的，所以，为了滤除高频噪声，还需要使信号通过一个低通滤波器。
## 低通滤波处理
### 数字频率
数字频率即为归一化的频率，其定义为：
$$
f_d =f_a/f_s*2
$$
其中，$f_s$表示信号的采样率，单位为(Hz)；$f_a$为模拟频率，其最大值为采样率的一半；$f_d$表示模拟频率$f_a$所对应的数字频率。
### 低通滤波器的设计
通过观察“初步处理后的频谱”，需要设置一个截止到1kHz的0.8kHz低通滤波器，因为信号的采样率为16kHz，所以数字频率分别为1kHz对应0.125，0.8kHz对应0.1。
设计出的FIR滤波器的分析如下图所示，上面的是幅频响应曲线，下面的是相频响应曲线。
![FIR滤波器的幅频响应与相频响应图](https://img-blog.csdnimg.cn/20210226120858817.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTQ3NjU2Mg==,size_16,color_FFFFFF,t_70)
观察幅频响应曲线可以发现该FIR滤波器在通带内保持平缓，在约0.125时截止。从相频响应曲线可以看到滤波器在通带内的响应具有线性相位，这点可以保证滤波时相位不失真。
### 滤波结果
滤波最终结果的频谱如下图所示，从图中可以看到大于1kHz的杂音都被去除了。
![滤波结果频谱](https://img-blog.csdnimg.cn/20210226121734128.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTQ3NjU2Mg==,size_16,color_FFFFFF,t_70)
接下来就可以聆听一下滤波后的结果。
# 示例2(窄带噪声的滤除)
## 频谱分析
按照惯例，第一步肯定是频谱分析。
![原信号频谱](https://img-blog.csdnimg.cn/20210226122458893.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTQ3NjU2Mg==,size_16,color_FFFFFF,t_70)
可以看到，信号被中心频率约为1.2kHz的窄带噪声所污染，同时，有用的频谱成分的幅度都在 1000 以下，所以用谱减法截取幅度在1000以下的频谱成分。
## 初步处理结果
初步处理结果如下图所示，截取后对音频进行试听，发现仍然有刺耳的交流成分，猜测是 1.2kHz 附近的
残留噪声在作怪，于是对信号进行二次截取。
![初步处理结果频谱](https://img-blog.csdnimg.cn/20210226143118873.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTQ3NjU2Mg==,size_16,color_FFFFFF,t_70)
## 最终处理结果
为了保留信号最重要的成分，二次截取选择的开始频率为 1kHz，截取幅度小于 450 的频谱成分。二次截取后的频谱如下图所示，此为滤波的最终结果。
![最终处理结果频谱](https://img-blog.csdnimg.cn/20210226143445982.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MTQ3NjU2Mg==,size_16,color_FFFFFF,t_70)
接下来就可以聆听一下滤波后的结果了。
# 代码
示例1的主运行文件为*soundHandle.m*
示例2为*soundHandle2.m*
