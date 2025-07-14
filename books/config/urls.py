"""config URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path

from main import views as v2
from booksManage import views as v1

urlpatterns = [
    path('admin/', admin.site.urls),

    # 登录、注册、请求个人信息、修改密码
    path('api/sign',v2.LoginAndOut().handle),

    # 用户增删改查
    path('api/user', v2.UserManage().handle),

    # 图书的增删改查、模糊查询
    path('api/books',v1.BooksManage().handle),

    path('api/read',v1.ReadManage().handle),

    # 书籍的批量添加
    path('api/upload',v1.BooksManage().upload)
]
