from django.shortcuts import render

from rest_framework import generics, serializers

from .models import Posts, Coments
from .serializers import PostsSerializer, ComentsSerializer

# Create your views here.

class PostsList(generics.ListCreateAPIView):
    queryset = Posts.objects.all()
    serializer_class = PostsSerializer
    name = 'posts-list'

class PostsDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Posts.objects.all()
    serializer_class = PostsSerializer
    name = 'posts-detail'

class ComentsList(generics.ListCreateAPIView):
    queryset = Coments.objects.all()
    serializer_class = ComentsSerializer
    name = 'coments-list'

class ComentsDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Coments.objects.all()
    serializer_class = ComentsSerializer
    name = 'coments-detail'

class PostCommentsList(generics.ListCreateAPIView):
    queryset = Posts.objects.all()
    serializer_class = PostsSerializer
    name = 'posts-comments'

class PostCommentsDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Posts.objects.all()
    serializer_class = PostsSerializer
    name = 'posts-comments'