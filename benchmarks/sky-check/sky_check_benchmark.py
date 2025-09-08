from benchmarks import benchmark_utils

CMD = 'sky check'

if __name__ == '__main__':
    print(f'Benchmarking `{CMD}` (parallel mode)')
    benchmark_utils.cmd_benchmark(CMD)
