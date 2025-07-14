from django.http import JsonResponse
import json
from .models import Books, readBook
import jwt
import xlrd2
import time


class BooksManage:

    def handle(self, request):
        # 判断是否为GET请求
        if request.method == 'GET':
            pd = request.GET
        else:
            pd = json.loads(request.body)

        request.pd = pd
        action = pd.get('action')

        if action == 'listBooks':
            return self.listBooks(request)
        elif action == 'addBooks':
            return self.addBooks(request)
        elif action == 'updateBooks':
            return self.updateBooks(request)
        elif action == 'deleteBooks':
            return self.deleteBooks(request)
        else:
            return JsonResponse({'code': 500, 'msg': 'action参数错误'})

    # 获取所有的图书信息
    def listBooks(self, request):
        # 当前第几页
        pagenum = int(request.pd.get('pageNum'))
        # 这一页一共要多少行
        pagesize = int(request.pd.get('pageSize'))
        # 模糊查询的键： bookname：书名、type：类型、author：作者、isbn：ISBN
        key = request.pd.get('key')
        # 模糊查询的值
        value = request.pd.get('value')
        res = Books.listBooks(pagenum, pagesize, key, value)
        return JsonResponse(res)

    # 添加图书

    def addBooks(self, request):
        # 获取request请求体中的data
        data = request.pd.get('data')
        res = Books.addBooks(data)

        return JsonResponse(res)

    # 修改图书
    def updateBooks(self, request):
        # 解析出newdata
        newdata = request.pd.get('newdata')
        # 解析出id
        uid = newdata['id']
        # 去更新
        res = Books.updateBooks(uid, newdata)
        return JsonResponse(res)

    # # 删除图书
    def deleteBooks(self, request):
        data = request.pd.get('id')
        res = Books.deleteBooks(data)
        return JsonResponse(res)

    # 上传Excel文件
    def upload(self, request):
        # 获取request中的file文件
        file = request.FILES.get('file')
        # 拿到文件名 和 时间戳去拼接  (1655120584批量插入图书-模板.xlsx)
        filename = str(int(time.time())) + file.name
        # 写入文件
        dest = open("./excel模板/" + filename, 'wb+')
        for chunk in file.chunks():  # 分块写入文件
            dest.write(chunk)
        # 关闭
        dest.close()
        # 用xlrd2 打开这个文件
        workbook = xlrd2.open_workbook("./excel模板/" + filename)
        # 选中单元格的表
        sheet = workbook.sheet_by_name('批量插入')
        # 这个新建一个空的数组
        bookList = list()
        # sheet.nrows 当前表共有多少行
        for i in range(sheet.nrows):
            if i > 6:
                # 实例化对象 相当于new books()
                obj = Books()
                obj.bookname = sheet.cell(i, 0).value
                obj.author = sheet.cell(i, 1).value
                obj.press = sheet.cell(i, 2).value
                # 日期 将时间戳转换成日期 年 月
                obj.time = sheet.cell(i , 3).value
                obj.type = sheet.cell(i, 4).value
                obj.isbn = sheet.cell(i, 5).value
                bookList.append(obj)
        print(bookList)
        # 批量添加
        Books.objects.bulk_create(bookList)
        return JsonResponse({'code': 200, 'msg': "成功"})

# 借阅管理的类
class ReadManage:
    def handle(self, request):

        # 判断是否为GET请求
        if request.method == 'GET':
            pd = request.GET
        else:
            pd = json.loads(request.body)

        request.pd = pd
        action = pd.get('action')

        if action == 'readlist':
            return self.readlist(request)
        elif action == 'readbook':
            return self.readbook(request)
        elif action == 'returnbook':
            return self.returnbook(request)
        else:
            return JsonResponse({'code': 500, 'msg': 'action参数错误'})

    # 获取自己所有的借阅信息
    def readlist(self, request):
        pagenum = int(request.pd.get('pageNum'))
        pagesize = int(request.pd.get('pageSize'))
        # 逻辑是 当前账号下的所有的借阅信息
        token = request.COOKIES.get('vue_admin_template_token')

        # 解密token
        if token:
            username = jwt.decode(token, "ukc8BDbRigUDaY6pZFfWus2jZWLPHO", algorithms=["HS256"])
            res = readBook.readbook(pagenum, pagesize, username['username'])
            return JsonResponse(res)
        return JsonResponse({'code': 500, 'msg': '会话过期了'})

    #  借阅图书
    def readbook(self, request):
        data = request.pd.get('data')
        token = request.COOKIES.get('vue_admin_template_token')
        if token:
            username = jwt.decode(token, "ukc8BDbRigUDaY6pZFfWus2jZWLPHO", algorithms=["HS256"])
            res = readBook.addReadBook(data, username['username'])
            return JsonResponse(res)

        return JsonResponse({'code': 500, 'msg': '会话过期了'})

    # 归还图书
    def returnbook(self, request):
        id = request.pd.get('data')
        res = readBook.returnbook(id)

        return JsonResponse(res)
