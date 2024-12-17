#include<stdio.h>
int Bmain(){printf("        \\0/");for(int i=0;i<361;){printf("%s%s",i++%19?"":"\n",i%19%9?i/19%9?" ":"-":i/19%9?"!":"+");}}
