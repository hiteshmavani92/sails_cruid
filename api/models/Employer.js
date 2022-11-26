module.exports={
    schema:true,
  connection: 'Sqlserver',
  tablename:'EmpMast',
  attributes: {
    user_name:{
      type:'string'
    },
    mobile_number:{
      type:'int'
    },
    email_id:{
      type:'string'
    },
    password:{
      type:'string'

    }

  }
}