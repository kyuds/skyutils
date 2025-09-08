import benchmark_utils

CMD_CACHED = 'sky serve status --endpoint'
CMD_NO_CACHE = 'sky serve status --endpoint --force-refresh'

if __name__ == '__main__':
    print(f'Benchmarking {CMD_CACHED}')
    benchmark_utils.cmd_benchmark(CMD_CACHED)
    print(f'Benchmarking {CMD_NO_CACHE}')
    benchmark_utils.cmd_benchmark(CMD_NO_CACHE)
