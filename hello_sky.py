import sky

def run():
    resource = sky.Resources(infra='aws',)
                            # accelerators='A100:8')

    task = sky.Task(setup='echo "Running setup."',
                    run='echo "Hello, SkyPilot!"',
                    workdir='.',
                    resources=resource)

    request_id = sky.launch(task=task,
                            cluster_name='mycluster')

    sky.stream_and_get(request_id)
    print('=== Task Complete! ===')

if __name__ == '__main__':
    run()
