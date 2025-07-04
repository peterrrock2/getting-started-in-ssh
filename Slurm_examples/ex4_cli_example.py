import click
import sys


@click.command()
@click.option("--arg1")
@click.option("--arg2")
def main(arg1, arg2):
    print(f"Python Argument 1: {arg1}")
    print(f"Python Argument 2: {arg2}")

    print("ERROR: This is a simulated error.", file=sys.stderr)


if __name__ == "__main__":
    main()
