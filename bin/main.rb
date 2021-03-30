require 'telegram/bot'
require './lib/process_data'

token = '1738382169:AAHcVo5q0ChpInYEaMs0BJKvv_bIhkU3BJY'

Telegram::Bot::Client.run(token) do |bot|
    puts 'Bot is running in the background...'
    bot.listen do |message|
        case message.text
        when '/start'
            bot.api.send_message(chat_id: message.chat.id, text: "Hello, Enter Your Birthday (YYYY-MM-DD)")
        when '/end'
            bot.api.send_message(chat_id: message.chat.id, text: "Goodbye!")
        else
            unless /[0-9]{4}-[0-9]{2}-[0-9]{2}/ === message.text
                bot.api.send_message(chat_id: message.chat.id, text: 'Invalid date (Use format YYY-MM-DD)')
            else
                processor = DataProcessor.new
                month = message.text[-5..-4]
                day = message.text[-2..-1]
                data = processor.run(month, day)
                if data.empty?
                    bot.api.send_message(chat_id: message.chat.id, text: 'Unable to process. Please check your date...')
                else
                    bot.api.send_message(chat_id: message.chat.id, text: data)
                end
            end
        end
    end
end
