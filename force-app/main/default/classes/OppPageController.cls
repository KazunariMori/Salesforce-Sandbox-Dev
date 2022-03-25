public with sharing class OppPageController {

//分页参数
public  Integer counter=0;  //偏移量
public static  Integer LIST_SIZE = 10;//每页显示记录数
public  Integer total_size; //总记录数

public OppPageController () {
   total_size = [select count() from Opportunity];
}

//变量 Opportunitys 的get方法
public List<Opportunity> getOpportunitys() {
   try {

      List<Opportunity> Opportunitys= [select Id,Name,StageName,Account.Name,Type,Probability from Opportunity limit :LIST_SIZE  offset :counter];// limit x,y

      return Opportunitys;
   } catch (Exception e) {
      ApexPages.addMessages(e);
      return null;
   }
}

//变量 DisablePrevious 的get方法
//控制上一页按钮是否可点击
public Boolean getDisablePrevious() {
   if (counter>0)
      return false;
   else
      return true;
}

//变量 DisableNext 的get方法
//控制下一页按钮是否可点击
public Boolean getDisableNext() {
   if (counter + LIST_SIZE   < total_size)
      return false;
   else
      return true;
}

//变量 Total_size 的get方法
//返回Total_size的值
public Integer getTotal_size() {
   return total_size;
}

//变量 PageNumber 的get方法
//计算当前页码
public Integer getPageNumber() {
   return counter/LIST_SIZE   + 1;
}

//变量 TotalPages 的get方法
//计算总页数
public Integer getTotalPages() {
   if (math.mod(total_size, LIST_SIZE )  > 0) {
      return total_size/LIST_SIZE   + 1;
   } else {
      return (total_size/LIST_SIZE ) ;
   }
}

//首页
public PageReference First() {
   counter = 0;
   return null;
}

//上一页
public PageReference Previous() {
   counter -= LIST_SIZE ;
   return null;
}

//下一页
public PageReference Next() {
   counter += LIST_SIZE ;
   return null;
}

//尾页
public PageReference End() {
   counter = total_size - math.mod(total_size, LIST_SIZE ) ;
   return null;
}
}