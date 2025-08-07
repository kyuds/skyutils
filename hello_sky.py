import sky
import sys

# List of commands to run
commands = [
    'echo "Hello, SkyPilot!"',
    'conda env list'
]

# Define a resource object.
#   infra: (Optional) if left out, automatically pick cheapest available.
#   accelerators: 8x NVIDIA A100 GPU
resource = sky.Resources(infra='aws')

# Define a task object.
#   setup: Typical use: pip install -r requirements.txt
#   run: Typical use: make use of resources, such as running training.
#   workdir: Working directory (optional) containing the project codebase.
#      Its contents are synced to ~/sky_workdir/ on the cluster.
#      Both `setup` and `run` is invoked under the workdir (i.e., can use its files).
task = sky.Task(setup='echo "Running setup."',
                run=commands,
                workdir='.',
                resources=resource)

# Launch the task.
request_id = sky.launch(task=task, cluster_name='mycluster')

# (Optional) stream the logs from the task to the console.
job_id, handle = sky.stream_and_get(request_id)

# (Optional) tail logs from the task to the console and get return code.
returncode = sky.tail_logs(handle.get_cluster_name(),
                            job_id,
                            follow=True)

# (Optional) exit based on task result.
sys.exit(returncode)
