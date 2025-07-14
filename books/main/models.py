from django.db import models

from django.contrib.auth.models import AbstractUser
from django.contrib.auth.hashers import make_password, check_password

import traceback

from django.db.models import Q
from django.core.paginator import Paginator, EmptyPage
import json
from django.core import serializers


# 可以通过 命令 python  manage.py createsuperuser 来创建超级管理员
# 就是在这User表中添加记录


class User(AbstractUser):
    id = models.BigAutoField(primary_key=True)

    # 用户类型
    # 1： 老师  | 2：学生
    usertype = models.PositiveIntegerField()

    # 真实姓名
    realname = models.CharField(max_length=30, db_index=True)

    # 学号
    studentno = models.CharField(
        max_length=10,
        db_index=True,
        null=True, blank=True
    )

    # 备注描述
    desc = models.CharField(max_length=500, null=True, blank=True)

    REQUIRED_FIELDS = [usertype, 'realname']

    class Meta:
        db_table = "book_user"

    # 添加人员信息
    @staticmethod
    def addOne(data):

        # 如果data中的username 和 password 为空的话就返回500 报错
        if data['username'] == '' and data['password'] == '':
            return {'code': 500, 'msg': '请输入用户名和密码'}

        # username为登录名 所以不能重复  exists是否存在
        if User.objects.filter(username=data['username']).exists():
            return {'code': 500, 'msg': f"用户名{data['username']}已存在"}
        try:
            # 判断是否为空  如果为空的话就直接赋值2 默认他是一个学生   （1是老师，2是学生）
            if data['usertype'] == "":
                data['usertype'] = 2
            # 将data中的信息解析出来然后去create新建
            user = User.objects.create(
                username=data['username'],
                password=make_password(data['password']),
                usertype=data['usertype'],
                realname=data['realname'],
                desc=data['desc'],
                studentno=data['studentno'],
            )
            return {'code': 200, 'msg': user.id}
        except:
            err = traceback.format_exc()
            return {'code': 500, 'msg': err}

    # 添加人员信息
    @staticmethod
    def raddOne(data, password):

        # 如果data中的username 和 password 为空的话就返回500 报错
        if data['username'] == '' and password == '':
            return {'code': 500, 'msg': '请输入用户名和密码'}

        # username为登录名 所以不能重复  exists是否存在
        if User.objects.filter(username=data['username']).exists():
            return {'code': 500, 'msg': f"用户名{data['username']}已存在"}
        try:
                # 判断是否为空  如果为空的话就直接赋值2 默认他是一个学生   （1是老师，2是学生）
            if data['usertype'] == "":
                data['usertype'] = 2
            # 将data中的信息解析出来然后去create新建
            user = User.objects.create(
                username=data['username'],
                password=make_password(password),
                usertype=data['usertype'],
                realname=data['realname'],
                desc=data['desc'],
                studentno=data['studentno'],
            )
            return {'code': 200, 'msg': user.id}
        except:
            err = traceback.format_exc()
            return {'code': 500, 'msg': err}




    @staticmethod
    def listUser(pagenum, pagesize):
        try:
            # .order_by('-id') 表示按照 id字段的值 倒序排列
            # 这样可以保证最新的记录显示在最前面
            # 获取到所有的用户信息，然后去倒叙排列
            qs = User.objects.values().order_by('-id')

            # 使用分页对象，设定每页多少条记录
            pgnt = Paginator(qs, pagesize)

            # 从数据库中读取数据，指定读取其中第几页
            page = pgnt.page(pagenum)
            # 将 QuerySet 对象 转化为 list 类型
            retlist = list(page)

            # total指定了 一共有多少数据
            return {'code': 200, 'msg': retlist, 'total': pgnt.count}
        except EmptyPage:
            return {'code': 200, 'msg': [], 'total': 0}
        except:
            return {'code': 500, 'msg': f'未知错误\n{traceback.format_exc()}'}

    # 修改用户
    @staticmethod
    def updateUser(uid, password, newdata):
        try:
            user = User.objects.get(id=uid)
            # ~Q就是不等于  username == rf  但是  你的id 不能等于我刚传进来的id
            # SELECT * FROM user where id != uid AND username == username
            # 就是自己本身的用户名是可以查出来的，但是我不包含自己
            if User.objects.filter(~Q(id=uid), username=newdata['username']):
                return {'code': 500, 'msg': f'用户名  {newdata["username"]}  已存在，不可重复'}

            # 如果密码不为空则改密码
            if password != '':
                print("执行")
                user.password = make_password(password)

            # 就会遍历字典，将这个新的newdata赋值给user
            for fileid, value in newdata.items():
                setattr(user, fileid, value)

            user.save()
            return {'code': 200, 'msg': user.id}
        except User.DoesNotExist:
            err = traceback.format_exc()
            return {'code': 500, 'msg': err}

    # 修改密码
    @staticmethod
    def updatePassword(username, password):
        try:
            # 查找到符合的信息，username
            user = User.objects.get(username=username)
            if password:
                # 使用的django的密码加密方式
                user.password = make_password(password)
            # 保存到数据库中
            user.save()
            return {'code': 200, 'msg': user.id}
        # 可能未找到  那么就返回报错信息
        except User.DoesNotExist:
            err = traceback.format_exc()
        return {'code': 500, 'msg': err}

    # 删除方法
    @staticmethod
    def delUser(data):
        try:
            # 查找这个用户信息
            user = User.objects.filter(id=data)
            # 如果用户存在则删除否则删除失败报错500
            if user:
                user.delete()
                return {'code': 200, 'msg': "删除成功"}
            else:
                return {'code': 500, 'msg': f'id为 {data} 的用户不存在'}
        except:
            err = traceback.format_exc()
            return {'code': 500, 'msg': err}

    # 获取当前登录的用户信息
    @staticmethod
    def getInfo(username):
        try:
            # 查找username 去数据中查找username的符合的信息 username=username前面username是数据库的字段名字、后面的username是你传进来的值
            qs = User.objects.filter(username=username).values()
            username = list(qs)
            return {'code': 200, 'msg': username}
        except User.DoesNotExist:
            return {'code': 500, 'msg': f'name为 {username} 的用户不存在'}
        except:
            err = traceback.format_exc()
            return {'code': 500, 'msg': err}
