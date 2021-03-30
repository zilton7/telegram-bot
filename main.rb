require 'telegram/bot'

token = '1738382169:AAHcVo5q0ChpInYEaMs0BJKvv_bIhkU3BJY'

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
        case message.text
        when '/start'
            bot.api.send_message(chat_id: message.chat.id, text: "Hello, Enter Your Birthday (YYYY-MM-DD)")
        when '/end'
            bot.api.send_message(chat_id: message.chat.id, text: "Goodbye!")
        else
            bot.api.send_message(chat_id: message.chat.id, text: "You have entered #{message.text}")
        end
    end
end
