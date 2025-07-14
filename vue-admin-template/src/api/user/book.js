import request  from "@/utils/request";

export const reqBooks = (pageNum,pageSize,key,value) => request({ url: `api/books` ,
                                                    method: 'post',
                                                    data: {'action': 'listBooks','pageNum': pageNum, 'pageSize': pageSize, 'key': key,'value': value}})

export const reqSaveAndUpdateBooks = (book) => {

  if (book.id){
    return  request({ url: `api/books`, method: 'put' ,data: { "action": "updateBooks","newdata": book} })
  }else{
    return  request({ url: `api/books`, method: 'post' ,data: { "action": "addBooks","data": book} })
  }

}

export const delBooks = (id) => request({ url: `api/books`,method: 'delete', data: {"action": "deleteBooks","id": id } })


// 借阅管理的API

export const reqReadBook = (pageNum,pageSize) => request({ url: `api/read`,method: 'post',data: {'action': 'readlist','pageNum': pageNum, 'pageSize': pageSize} })

export const readBook = (data) => request({ url: `api/read`,method: 'post',data: {'action': 'readbook','data': data} })

export const returnBook = (id) => request({ url: `api/read`,method: 'post',data: {'action': 'returnbook','data': id} })
