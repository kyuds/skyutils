import subprocess
import time
from tabulate import tabulate

CMD_CACHED = 'sky serve status --endpoint'
CMD_NO_CACHE = 'sky serve status --endpoint --force-refresh'

def benchmark(cmd: str, runs: int=10) -> None:
    print(f'Benchmark for: {cmd}')
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

if __name__ == '__main__':
    benchmark(CMD_CACHED)
    benchmark(CMD_NO_CACHE)
