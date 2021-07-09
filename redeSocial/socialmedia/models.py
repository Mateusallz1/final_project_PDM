from django.db import models

# Create your models here.

class Posts(models.Model):
    post_id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=100)
    text = models.CharField(max_length=500)

    class Meta:
        ordering = ('post_id',)

    def __str__(self):
        return self.title

class Coments(models.Model):
    comment_id = models.AutoField(primary_key=True)
    body_text = models.CharField(max_length=200)
    postId = models.ForeignKey(Posts, related_name='comments', on_delete=models.CASCADE)

    class Meta:
        ordering = ('comment_id',)

    def __str__(self):
        return self.body_text