# 使用matlab实现JEPG编解码

## 文件介绍

### 资源
1   		卡通图片的JPEG编码结果
1.bmp  	        卡通图片转bmp
1.gif	 	 卡通图片转gif
1.jpg	   	    原始卡通图片

2   		摄影照片的JPEG编码结果
2.bmp  	        摄影照片转bmp
2.gif	 	  摄影照片转gif
2.jpg	   	    原始摄影照片
### 代码

hw.m 						主函数
RGB_to_YIQ.m       				 RGB转为YIQ
subsample .m   				     二次采样
DCT.m					       DCT变换
quantization.m				   量化
RLC.m   					  AC系数的游长编码
DPCM.m  				        DC系数的差值编码
huffman_for_DC.m  			   DC系数的huffman编码
huffman_for_AC.m  			    AC系数的huffman编码
save_jpg.m  				    将JEPG编码结果保存到文件
inv_huffman_for_DC.m		   将DC系数从huffman编码恢复
inv_huffman_for_AC.m  		      将AC系数从huffman编码恢复
inv_DPCM.m  				将DC系数从差值编码恢复
inv_RLC.m 					将AC系数从游长编码恢复
un_quantization.m   		      反量化
IDCT.m 					        反DCT变换
YIQ_to_RGB.m 			         将YIQ转为RGB
evaluate_jpeg.m 			   评估jpg结果的失真度
evaluate_gif.m 			             评估gif的失真度
