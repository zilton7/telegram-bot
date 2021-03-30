require 'telegram/bot'
require './process_data'

token = '1738382169:AAHcVo5q0ChpInYEaMs0BJKvv_bIhkU3BJY'

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
        case message.text
        when '/start'
            bot.api.send_message(chat_id: message.chat.id, text: "Hello, Enter Your Birthday (YYYY-MM-DD)")
        when '/end'
            bot.api.send_message(chat_id: message.chat.id, text: "Goodbye!")
        else
            month = message.text[-5..-4]
            day = message.text[-2..-1]
            data = get_data(month, day)
            bot.api.send_message(chat_id: message.chat.id, text: data)
        end
    end
end
