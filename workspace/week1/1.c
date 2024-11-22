#include<stdio.h>


int main(){
int a=0,b=1,c=0;
int cnt;
scanf("%d",&cnt);
if(cnt==0){
printf("0\n");
return 0;
}
if(cnt==1){
printf("1\n");
return 0;
}
cnt--;
while(cnt--){
c=a+b;
a=b;
b=c;

}
printf("%d\n",c);
return 0;


}
