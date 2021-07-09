# Generated by Django 3.1.5 on 2021-06-30 14:35

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Posts',
            fields=[
                ('post_id', models.AutoField(primary_key=True, serialize=False)),
                ('title', models.CharField(max_length=100)),
                ('text', models.CharField(max_length=500)),
            ],
            options={
                'ordering': ('text',),
            },
        ),
        migrations.CreateModel(
            name='Coments',
            fields=[
                ('comment_id', models.AutoField(primary_key=True, serialize=False)),
                ('body_text', models.CharField(max_length=200)),
                ('postId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='comments', to='socialmedia.posts')),
            ],
        ),
    ]