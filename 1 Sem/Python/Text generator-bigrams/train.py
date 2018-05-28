import sys
import re
import argparse
import os
from collections import defaultdict


def get_arguments():
    parser = argparse.ArgumentParser()

    parser.add_argument( '--dir', '--input-dir', action='store', nargs='?', default=False,
                        help="""Принимает путь к директории, в которой
                        лежит коллекция документов. Если данный аргумент не задан,
                        тексты вводятся из stdin.""")
    parser.add_argument('--model',
                        help='Принимает путь к файлу,в который сохраняется модель')
    parser.add_argument('--lc', action='store_true',
                        help="""Необязательный аргумент. Показывает приводить ли
                        тексты к lowercase.""")
    return parser.parse_args()


def update_dict(line_str, pair_word, lc):  # Для строки добавляем её пары в словарь
    if lc:
        line_str = line_str.lower()
    split_line = (re.findall(r'[A-Za-zЁА-Яа-яё!.?,:-]+', line_str))  # Убираем неалфавитные символы
    for key, value in list(zip(split_line, split_line[1:])):  # Из пар делаем словарь
        pair_word[key][value] += 1


def main():
    args = get_arguments()

    pair_word = defaultdict(lambda: defaultdict(int))
    if(args.dir):  # Если введена директория то читаем из всех файлов в ней
        for source_direct, sub_direct, files in os.walk(args.dir):
            for f in files:
                f = open(os.path.join(source_direct, f), encoding="utf-8")
                for line_str in f.readlines():
                    update_dict(line_str, pair_word, args.lc)
                f.close()
    else:
        for line_str in sys.stdin.readlines():
            update_dict(line_str, pair_word, args.lc)

    with open(args.model, 'w', encoding="utf-8") as model:
        for first_word in pair_word.items():  # выводим тройки: первое слово, второе слово, число таких пар
            for second_word in first_word[1].items():
                model.write("{} {} {}\n".format(first_word[0], second_word[0], second_word[1]))


if __name__ == "__main__":
    main()
