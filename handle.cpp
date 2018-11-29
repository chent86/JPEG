#include <string>
#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <limits.h>
using namespace std;

struct rgb { // 转为YIQ后会复用这一结构体
	float r; // Y
  float g; // I  
	float b; // Q
	int num;   // rgb元素的编号，由于处理之后还原顺序
};

vector<rgb> table;

bool num_comp(const rgb &x, const rgb &y){   // 排序的一些辅助函数
    return x.num < y.num;
}

void read_rgb(vector<rgb>& v) {
  std::ifstream file1("1.txt");   
  string my_read;
  int p[2], j, r, g, b, length;
  int k = 0;
  while(getline(file1, my_read)) {
    j=0;
    length = my_read.length();
    for(int i = 0; i < length; i++) {
      if(my_read[i] == ' ')
        p[j++] = i;
    }
    r = atoi(my_read.substr(0, p[0]).c_str());
    g = atoi(my_read.substr(p[0]+1, p[1]-p[0]+1).c_str());
    b = atoi(my_read.substr(p[1]+1, length-p[1]).c_str());   // 读入rgb元素
    v.push_back({r,g,b,k++});
  }
}

void RGB_to_YIQ(rgb& t) {
  float Y = 0.299*t.r + 0.587*t.g + 0.144*t.b;
  float I = 0.595879*t.r - 0.274133*t.g - 0.321746*t.b;
  float Q = 0.211205*t.r - 0.523083*t.g - 0.311878*t.b;
  t.r = Y;
  t.g = I;
  t.b = Q;
}

void subsample(vector<rgb>& v, int width, int height) {  // 4:2:0 二次采样
  // todo: 边界问题
  int i = 0, j = 0;
  for(i = 0; i < height; i+=2) {
    if(i == height-1)
      break;
    for(j = 0; j < width; j+=4) {
      if(width-1-j < 3)
        break;
      float I = v[i*width+j].g;
      float Q = v[(i+1)*width+j].b;
      for(int k = 0; k < 4; k++) {
        v[i*width+j+k].g = I;
        v[i*width+j+k].b = I;
        v[(i+1)*width+j+k].g = Q;
        v[(i+1)*width+j+k].b = Q;
      }
    }
  }
}

int main() {
  int width = 1000;
  int height = 715;
  vector<rgb> v;
  read_rgb(v);
  RGB_to_YIQ(v);
  subsample(v, width, height);

	 // std::ofstream file2("2.txt");
   //    for(auto&i : v)
   //    	file2 << i.r << " " << i.g << " " << i.b << " ";  // 写入文件
   //    file2.close();
   //    file1.close();
}
