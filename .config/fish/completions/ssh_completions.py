#!/usr/bin/env python3

from storm import Storm


def get_hosts(config_file=None):
    return [entry['host'] for entry in Storm(config_file).list_entries(only_servers=True) if '*' not in entry['host']]


def main():
    print(' '.join(get_hosts()))

if __name__ == '__main__':
    main()

