var constVar=require('../utils/constants/registerConstant.js');

var func=require('../utils/utility_functions.js');

// module.exports = {
//     registerServices:registerServices,
//     GetEmpServices,GetEmpServices,

//     };
    
    module.exports = {
        registerServices:registerServices,
        GetEmpServices:GetEmpServices,
        UpdateEmpServices:UpdateEmpServices,
        DeleteEmpServices:DeleteEmpServices,
        };

        function DeleteEmpServices(req,callback)
        {
          console.log("Enter in DeleteEmpServices Services");         
          constVar.user = req[constVar.FIELD_USER_NAME];
          console.log("user : "+ constVar.user);
          constVar.queryRes='DECLARE @out_returnvalue int; EXEC DeleteEMP @USER_NAME ="'+constVar.user+'",@out_returnvalue=@out_returnvalue output; select @out_returnvalue as msg;';
          console.log("queryRes variable details: "+constVar.queryRes);
          func.connection(constVar.queryRes,function callbackConnection(results)
          {
            if(results==1)
            {
              console.log("Enter in DeleteEmpServices ");
                constVar.resJson = func.resFun(false,"Employee delete Successfully :"+ constVar.user);
                callback(null,constVar.constJson);
            }
            else
            {
              constVar.constJson = func.resFun(true,"Emp Not Found");
              callback(constVar.resJson,null)

            }
             
          });
        }

        function UpdateEmpServices(resJson,callback)
        {
          console.log("Enter:UpdateEmpServices()");
          //stores the response of the register function to respected variables
          constVar.user=resJson[constVar.FIELD_USER_NAME];
          constVar.mobileNo=resJson[constVar.FIELD_MOBILE_NO];
          constVar.emailId=resJson[constVar.FIELD_EMAIL_ID];
          constVar.password=resJson[constVar.FIELD_PASSWORD];
        
          console.log("User details are \n user:"+constVar.user+"\n mobile:"+constVar.mobileNo+" \nemail:"+constVar.emailId+" \npass:"+constVar.password);
        
          /*to stores the calling functionlity of procedure checkRegister to the queryRes variable*/
          constVar.queryRes='DECLARE @out_returnvalue int; EXEC updateemp @in_user_name ="'+constVar.user+'",@in_mobile_no="'+constVar.mobileNo+'",@in_email_id="'+constVar.emailId+'",@in_password="'+constVar.password+'",@out_returnvalue=@out_returnvalue output; select @out_returnvalue as msg;';
          console.log("queryRes variable details: "+constVar.queryRes);
          /*calling the connection() function to pass the constVar.queryRes which will available in func.js file*/
          func.connection(constVar.queryRes,function callbackConnection(results)
          {
            if(results==1)
            {
              //success response from checkRegister procedure
              constVar.constJson= func.resFun(false," update sucessfully ")
              console.log("Exit:UpdateEmpServices()");
              callback(null,constVar.constJson);
            }
            else
            {
              //error from checkRegister procedure
              constVar.constJson=func.resFun(true,"user not found");
              console.log("exit on UpdateEmpServices");
              callback(constVar.constJson,null);
            }
          });
        }

        function GetEmpServices(req,callback)
        {
          console.log("Enter in GetEmp Services");         
          constVar.user = req[constVar.FIELD_USER_NAME];
          console.log("user : "+ constVar.user);
          constVar.queryRes='DECLARE @out_returnvalue int; EXEC GETEMP @USER_NAME ="'+constVar.user+'",@out_returnvalue=@out_returnvalue output; select @out_returnvalue as msg;';
          console.log("queryRes variable details: "+constVar.queryRes);
          func.connection(constVar.queryRes,function callbackConnection(results)
          {
            if(results==1)
            {
              console.log("Enter in register Services");
                constVar.resJson = func.resFun(false,"Employee Get Successfully");
                callback(null,constVar.constJson);
            }
            else
            {
              constVar.constJson = func.resFun(true,"Emp Not Found");
              callback(constVar.resJson,null)

            }
             
          });
        }
        
        function registerServices(resJson,callback)
        {
          console.log("Enter:registerServices()");
          //stores the response of the register function to respected variables
          constVar.user=resJson[constVar.FIELD_USER_NAME];
          constVar.mobileNo=resJson[constVar.FIELD_MOBILE_NO];
          constVar.emailId=resJson[constVar.FIELD_EMAIL_ID];
          constVar.password=resJson[constVar.FIELD_PASSWORD];
        
          console.log("User details are \n user:"+constVar.user+"\n mobile:"+constVar.mobileNo+" \nemail:"+constVar.emailId+" \npass:"+constVar.password);
        
          /*to stores the calling functionlity of procedure checkRegister to the queryRes variable*/
          constVar.queryRes='DECLARE @out_returnvalue int; EXEC checkRegister @in_user_name ="'+constVar.user+'",@in_mobile_no="'+constVar.mobileNo+'",@in_email_id="'+constVar.emailId+'",@in_password="'+constVar.password+'",@out_returnvalue=@out_returnvalue output; select @out_returnvalue as msg;';
          console.log("queryRes variable details: "+constVar.queryRes);
          /*calling the connection() function to pass the constVar.queryRes which will available in func.js file*/
          func.connection(constVar.queryRes,function callbackConnection(results)
          {
            if(results==1)
            {
              //success response from checkRegister procedure
              constVar.constJson= func.resFun(false,"sucessfully register")
              console.log("Exit:registerServices()");
              callback(null,constVar.constJson);
            }
            else
            {
              //error from checkRegister procedure
              constVar.constJson=func.resFun(true,"email_id already exits,please choose another email_id");
              console.log("exit on registerServices");
              callback(constVar.constJson,null);
            }
          });
        }
        