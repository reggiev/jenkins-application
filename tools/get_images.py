import sys
import subprocess


def get_image(yaml):
    # Returns list of images from the yaml file
    lines = yaml.split('\n')
    images = []
    # TODO Implement a cleaner and safer image parsing
    for line in lines:
        if "image: " in line:
            images.append(line.split("image:")[1])
    return images


def get_images(yfile):
    # TODO Potential bug, a yaml file may actually contain --- in the future
    images = []
    with open(yfile, 'r') as stream:
        yamls = stream.read().split("---")
        for yaml in yamls:
            images += get_images(yaml)
    return images


if __name__ == '__main__':
    if len(sys.argv) != 2:
        raise Exception("Error with parameters. Usage: python scan_artifact.py [yaml file to scan]")

    return get_images(sys.argv[1])
