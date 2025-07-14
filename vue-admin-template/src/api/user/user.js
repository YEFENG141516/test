import request  from "@/utils/request";

export const reqUser = (pageNum,pageSize) => request({ url: `api/user` , method: 'post',data: {'action': 'listUser','pageNum': pageNum, 'pageSize': pageSize}})

export const reqSaveAndUpdateUser = (user,password) => {

  if (user.id){
    return  request({ url: `api/user`, method: 'put' ,data: { "action": "updateOne","newdata": user,"password":password} })
  }else{
    return  request({ url: `api/user`, method: 'post' ,data: { "action": "radOne","data": user,"password":password} })
  }

}

export const delUser = (id) => request({ url: `api/user`,method: 'delete', data: {"action": "deleteOne","id": id } })

export const reqPasswordUP = (data) => request( {url: `api/sign`,method: 'post',data: {"action": "uppd",'data': data}} )
