from collections import defaultdict
import argparse
import numpy


def get_arguments():
    parser = argparse.ArgumentParser()

    parser.add_argument('--model', action='store', nargs=1,
                        help='Принимает путь к файлу модели.')
    parser.add_argument('--seed', action='store', nargs='?', default=False,
                        help="""Необязательный аргумент. Начальное слово. Если не
                        указано,первое слово будет случайным из всех слов""")
    parser.add_argument('--length', action='store', nargs=1,
                        help='Длина генерируемой последовательности')
    parser.add_argument('--output', action='store', nargs='?', default=False,
                        const=False, help="""Необязательный аргумент. Файл, в
                        который будет записан результат. Если аргумент отсутствует,
                        вывод произойдет в stdout.""")
    return parser.parse_args()


def my_print(out, val, end):
    if out:  # Если есть файл, то выводим в него
        out.write(str(val) + end)
    else:
        print(val, end=end)


def main():
    args = get_arguments()

    with open(args.model[0], 'r', encoding="utf-8") as model:
        next_word = defaultdict(list)  # словарь из слова и следующим за ним
        meeting_next_word = defaultdict(list)  # словарь из слова и колличества встреч соответсвующих слов из словаря выше
        for line in model.readlines():
            split_line = line.split()
            next_word[split_line[0]].append(split_line[1])  # добавляем следующее слово
            meeting_next_word[split_line[0]].append(int(split_line[2]))  # добавляем статистику встреч слова, добавленого в первый словарь

    if args.seed:  # Выбираем первое слово
        prev_word = args.seed
    else:
        prev_word = str(numpy.random.choice(list(next_word.keys())))
    if args.output:
        out = open(args.output, 'w')
        my_print(out, prev_word.capitalize(), end='')
    else:
        my_print(args.output, prev_word.capitalize(), end='')
    for length in range(int(args.length[0])):
        if not next_word[prev_word]:  # Если для слова нет пары, то это конец предложения
            successor = str(numpy.random.choice(list(next_word.keys()))).capitalize()  # Новое предложение начинается с рандомного слова
        else:  # Если пара у слова есть, то выводим её
            if meeting_next_word[prev_word][0] < 1:  # Если вероятность уже посчитана
                continue
            else:  # Иначе заменяем просто кол-во встречь на вероятность каждой
                meeting_next_word[prev_word] = list(numpy.array(meeting_next_word[prev_word]) / sum(meeting_next_word[prev_word]))
            successor = numpy.random.choice(next_word[prev_word], 1, meeting_next_word[prev_word])[0]
        prev_word = successor.lower()
        if args.output:
            my_print(out, ' ' + successor, end='')
        else:
            my_print(args.output, ' ' + successor, end='')
    if args.output:
        out.close()


if __name__ == "__main__":
    main()
