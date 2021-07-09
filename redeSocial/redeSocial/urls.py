"""redeSocial URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
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

from socialmedia import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('posts/', views.PostsList.as_view(), name=views.PostsList.name),
    path('post/<int:pk>/', views.PostsDetail.as_view(), name=views.PostsDetail.name),
    path('coments/', views.ComentsList.as_view(), name=views.ComentsList.name),
    path('coment/<int:pk>/', views.ComentsDetail.as_view(), name=views.ComentsDetail.name),
    path('post-comments/', views.PostCommentsList.as_view(), name=views.PostCommentsList.name),
    path('post-comments/<int:pk>/', views.PostCommentsDetail.as_view(), name=views.PostCommentsDetail.name),
]
