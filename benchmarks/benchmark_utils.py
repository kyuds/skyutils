import subprocess
import time
from tabulate import tabulate

def cmd_benchmark(cmd: str, runs: int=10) -> None:
    times = []

    for i in range(runs):
        start = time.perf_counter()
        try:
            subprocess.run(
                cmd, 
                shell=True, 
                check=True, 
                stdout=subprocess.DEVNULL, 
                stderr=subprocess.DEVNULL)
        except subprocess.CalledProcessError as e:
            print(f'Run {i} failed with error: {e}')
        end = time.perf_counter()
        times.append(end - start)
    
    table = [[i + 1, f'{t:.4f} sec'] for i, t in enumerate(times)]
    avg = sum(times) / len(times) if times else 0

    print(tabulate(table, headers=['Run', 'Time']))
    print(f'\nAverage Latency: {avg:.4f} sec\n')
