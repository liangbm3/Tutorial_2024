#include<ros/ros.h>
#include<add_service/AddTwoInt.h>
//；处理计算的回调函数
bool handle_add_two_int(add_service::AddTwoInt::Request &req,add_service::AddTwoInt::Response &res){
    res.sum=req.a+req.b;
    res.product=req.a*req.b;
    if(req.a==req.b){
        res.equal="true";
    }
    else{
        res.equal="false";
    }
    ROS_INFO("Request: num1=%ld,num2=%ld",req.a,req.b);
    ROS_INFO("Response: sum=%ld, product=%ld, equal=%s",res.sum,res.product,res.equal.c_str());
    return true;
}

//初始化服务端
int main(int argc,char**argv){
    ros::init(argc,argv,"service_server");
    ros::NodeHandle n;

    ros::ServiceServer service =n.advertiseService("add_two_int",handle_add_two_int);
    ROS_INFO("Ready to calculate two ints.");
    ros::spin();
    return 0;
}