import sky

if __name__ == '__main__':
    bucket_name = 'kyuds-bucket-v2'
    task = sky.Task.from_yaml('task.yaml', complete_setup=False)
    task.update_envs({'DATA_BUCKET_NAME': bucket_name})
    sky.launch(task, down=True)
