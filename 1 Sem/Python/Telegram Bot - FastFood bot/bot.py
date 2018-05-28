import telebot
import sqlite3
import geocoder


def answer(bot, update):
    chat_id = update['chat']['id']
    if update['text'][0] == '/':
        if update['text'] == '/start':
            bot.send_message(chat_id, "Hello! Enter any place in the USA and I will find where you can eat nearby")
            return
        if update['text'] == '/help':
            bot.send_message(chat_id, "Hello! It's a FastFood bot. You can send them the name of some\
             place in the USA and it'll send you where you can eat nearby.\
             Send /start to start. It doesn't know another command yet.")
            return
        else:
            bot.send_message(chat_id, "Excuse me. I haven't been taught that command yet.")
            return
    else:
        coordinates = update['text'].split(', ')
        geo = None
        # Если пользователь ввел географические координаты
        if coordinates[0].replace('.', '', 1).isdigit() and coordinates[1].replace('.', '', 1).isdigit():
            USA_coordinates = geocoder.geocodefarm('USA').bbox
            if USA_coordinates['southwest'][0] < float(coordinates[0]) < USA_coordinates['northeast'][0] and \
               USA_coordinates['southwest'][1] < float(coordinates[1]) < USA_coordinates['northeast'][1]:
                geo = coordinates
            else:
                bot.send_message(chat_id, "Sorry, the service works only for US restaurants")
                return
        else:
            geo = geocoder.arcgis(update['text'])  # Возвращает характеристики географического объекта введенного словами
            if geo.latlng is None:
                bot.send_message(chat_id, "Please make sure that you entered the data correctly")
                return
            else:
                temp = geo.latlng  # Оставляем в geo только географические координаты
                geo = temp
        database = sqlite3.connect("FastFood.db")
        cursor = database.cursor()
        # Выбираем из базы ресторан(ы) близжайший к указаной точке
        restaurants = cursor.execute("SELECT name, address, city, websites, MIN((latitude - {})*(latitude - {}) + \
        (longitude - {})*(longitude - {})) FROM FastFood".format(geo[0], geo[0], geo[1], geo[1]))
        for restaurant in restaurants:
            bot.send_message(chat_id, "The restaurant next to you: {}, {}, {} {}"
                             .format(restaurant[0], restaurant[1], restaurant[2], restaurant[3]))


def main():
    with open("token.txt", 'r') as f:
        token = f.readline()
    bot = telebot.TeleBot(__name__)  # Создаем объект нашего бота
    bot.config['api_key'] = token
    if bot.get_updates()['result']:
        last_mes = bot.get_updates()['result'][-1]['update_id']  # Находим последнее сообщение
    else:
        last_mes = -1  # Если за сутки не прислали ни одного сообщения
    while True:
        updates = bot.get_updates()
        for update in updates['result']:
            if last_mes == -1:
                last_mes = update['update_id']
            if update['update_id'] >= last_mes:
                answer(bot, update['message'])  # Вызываем функцию обработки сообщения
                last_mes += 1


if __name__ == "__main__":
    main()
