
var constVar=require('../utils/constants/registerConstant.js');
module.exports={
	registration:registration,
	GetEmp:GetEmp,
	updateEmp:updateEmp,
	DeleteEmp:DeleteEmp,
}

function DeleteEmp(req,res)
{
	console.log("Delete emp action");
	
	constVar.resJson = req[constVar.FIELD_BODY];
	
	RegisterServices.DeleteEmpServices(constVar.resJson,function callback(error,response)
	{
		if(error)
		{
			console.log("Emp Not Exists");
		}
		else
		{
			console.log("Emp Delete Successfully");
			res.send(response);
		}
	});

}

function updateEmp(req,res)
{
	console.log("update emp action");
	
	constVar.resJson = req[constVar.FIELD_BODY];
	
	RegisterServices.UpdateEmpServices(constVar.resJson,function callback(error,response)
	{
		if(error)
		{
			console.log("Emp Not Exists");
		}
		else
		{
			console.log("Emp Found Successfully");
			res.send(response);
		}
	});

}

function GetEmp(req,res)
{
	console.log("Getemp action");
	
	constVar.resJson = req[constVar.FIELD_BODY];
	
	RegisterServices.GetEmpServices(constVar.resJson,function callback(error,response)
	{
		if(error)
		{
			console.log("Emp Not Exists");
		}
		else
		{
			console.log("Emp Found Successfully");
			res.send(response);
		}
	});

}

function registration(req,res)
{
	console.log("Enter:RegisterController");
 	constVar.resJson=req[constVar.FIELD_BODY];//stores the request of body in resJson variable
	console.log("The details of the user are which is store in resJson variable:"+JSON.stringify(constVar.resJson)+"\nsent resJson in registerServices ");

	//calling registerServices() function and pass the resJson object
	RegisterServices.registerServices(constVar.resJson,function callback(error,response)
	{
		if (error)
		{
			// error json
			console.log("email_id already exits,please choose another email_id");
			res.send(error);
		}
		else
		{
			// sucess json
	  	console.log("User sucessfully register");
			res.send(response);
		}
		console.log("Exit:RegisterController");
     });
 }