var constVar=require('../utils/constants/registerConstant.js');


module.exports ={
  /*this function gets the response from the Stored procedure*/
  resFun:function(error,msg)
  {
    constVar.constJson.error=error;
    constVar.constJson.message=msg;
    console.log("Errr"+constVar.constJson.error+"-"+constVar.constJson.message);
    
    return constVar.constJson; // returns json
  },

  /*this function provides the connection to sqlServer*/
  connection:function(queryRes,callbackConnection)
  {
    Employer.query(queryRes,function(error,results)
    {
      console.log("error in Store procedure: "+JSON.stringify(error));
      console.log("response of the Store procedure: "+JSON.stringify(results));
      console.log("Result: "+results[0].msg);
      callbackConnection(results[0].msg); //call the callbackfunction and pass the response of the Store procedure
     // callbackConnection(results);
    });
  }
};
