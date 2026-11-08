import argparse
import json
from pathlib import Path


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--input', required=True)
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    source = Path(args.input)
    target = Path(args.output)
    try:
        rows = [json.loads(line) for line in source.read_text(encoding='utf-8').splitlines()]
        with target.open('x', encoding='utf-8', newline='\n') as stream:
            stream.write(''.join(json.dumps(row, ensure_ascii=False) + '\n' for row in rows))
    except (OSError, ValueError) as error:
        parser.error(str(error))


if __name__ == '__main__':
    main()
