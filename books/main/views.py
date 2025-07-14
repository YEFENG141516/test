from django.shortcuts import render
from django.http import JsonResponse

from django.contrib.auth import authenticate, login, logout
import json
from .models import User
from django.contrib.auth.hashers import make_password
import traceback
import jwt


# 登录
class LoginAndOut:

    def handle(self, request):

        pd = json.loads(request.body)
        # 请求体有action 直接获取到action去比较
        action = pd.get('action')
        request.pd = pd
        if action == 'signin':
            return self.signin(request)
        elif action == 'signout':
            return self.signout(request)
        elif action == 'info':
            # 从 HTTP POST 请求中获取用户名、密码参数
            return self.info(request)
        elif action == 'uppd':
            # 从 HTTP POST 请求中获取用户名、密码参数
            return self.updatePassword(request)
        else:
            return JsonResponse({'code': 500, 'msg': 'action参数错误'})

    # 登录处理
    def signin(self, request):
        # 从请求体里面找到username和password
        username = request.pd.get('username')
        password = request.pd.get('password')
        # 比对如果username和password为空的话就直接返回500 并提示请输入用户名和密码
        if username == '' and password == '':
            return JsonResponse({'code': 500, 'msg': '请输入用户名和密码'})

        # 使用 Django auth 库里面的 方法校验用户名、密码
        user = authenticate(username=username, password=password)
        # 用户名找不到或者密码错误都会为none
        if user is None:
            return JsonResponse({'code': 500, 'msg': '用户名密码错误'})

        # 生成Token  放入username 而且用 MD5 + 盐 加密
        encoded = jwt.encode({"username": username}, "ukc8BDbRigUDaY6pZFfWus2jZWLPHO", algorithm="HS256")
        print("生成token：" + encoded)
        # 登录，将当前用户信息存储在会话中
        login(request, user)
        return JsonResponse({'code': 200, 'msg': encoded})

    # 获取用户信息
    def info(self, request):
        # 把Token拿出来
        token = request.COOKIES.get('vue_admin_template_token')
        # 如果token不为空,那么解密token
        if token:
            # 解密token 将{'username': 'rf'}获取出来
            username = jwt.decode(token, "ukc8BDbRigUDaY6pZFfWus2jZWLPHO", algorithms=["HS256"])
            # 将username的值 rf 获取出来 然后进入getInfo方法
            data = User.getInfo(username["username"])
            return JsonResponse(data)
        return JsonResponse({'code': 500, 'msg': '会话过期了'})

    # 登出处理
    def signout(self, request):
        # 使用登出方法
        logout(request)
        return JsonResponse({'code': 200})

    # 修改密码
    def updatePassword(self, request):
        token = request.COOKIES.get('vue_admin_template_token')
        # 将请求体中的data解析出来
        password = request.pd.get('data')
        # 解密token
        if token:
            # 解密token 将{'username': 'rf'}获取出来
            username = jwt.decode(token, "ukc8BDbRigUDaY6pZFfWus2jZWLPHO", algorithms=["HS256"])
        else:
            username = request.pd.get('username')
        data = User.updatePassword(username["username"], password)
        return JsonResponse(data)


# 用户增删改查
class UserManage:

    def handle(self, request):

        # 判断是否为GET请求
        if request.method == 'GET':
            pd = request.GET
        else:
            pd = json.loads(request.body)
        request.pd = pd
        action = pd.get('action')

        if action == 'listUser':
            return self.listUser(request)
        elif action == 'addOne':
            return self.addOne(request)
        elif action == 'updateOne':
            return self.updateOne(request)
        elif action == 'deleteOne':
            return self.deleteOne(request)
        elif action == 'raddOne':
            return self.deleteOne(request)
        else:
            return JsonResponse({'code': 500, 'msg': 'action参数错误'})

    # 获取所有的用户信息
    def listUser(self, request):
        # 当前页
        pagenum = int(request.pd.get('pageNum'))
        # 当前总条数
        pagesize = int(request.pd.get('pageSize'))
        res = User.listUser(pagenum, pagesize)
        return JsonResponse(res)

    # 添加用户
    def addOne(self, request):
        data = request.pd.get('data')
        res = User.addOne(data)
        return JsonResponse(res)

    # 修改用户
    def updateOne(self, request):
        # 获取newdata中的数据
        newdata = request.pd.get('newdata')
        # 从newdata中获取id
        uid = newdata['id']
        # 从requset请求体中获取password
        password = request.pd.get('password')
        res = User.updateUser(uid, password, newdata)
        return JsonResponse(res)

    # # 删除用户
    def deleteOne(self, request):
        data = request.pd.get('id')
        res = User.delUser(data)

        return JsonResponse(res)
