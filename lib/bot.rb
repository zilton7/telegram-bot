require 'telegram/bot'

# rubocop: disable Metrics/MethodLength: Method has too many lines

class Bot
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def begin
    Telegram::Bot::Client.run(@token) do |b|
      puts 'Bot is running in the background...'

      b.listen do |message|
        case message.text
        when '/start'
          send_hello(b, message)
        when '/end'
          send_goodbye(b, message)
        else
          if valid_date?(message.text)
            month = extract_month(message.text)
            day = extract_day(message.text)
            processor = DataProcessor.new(month, day)
            processor.run
            if processor.data.empty?
              send_unable_to_process(b, message)
            else
              b.api.send_message(chat_id: message.chat.id, text: processor.data)
            end
          else
            send_invalid_date(b, message)
          end
        end
      end
    end
  end

  def extract_month(str)
    result = str[-5..-4]
    result if result =~ /[0-9]{2}/
  end

  def extract_day(str)
    result = str[-2..-1]
    result if result =~ /[0-9]{2}/
  end

  def valid_date?(str)
    str =~ /[0-9]{4}-[0-9]{2}-[0-9]{2}/
  end

  private

  def send_hello(bot_obj, message_obj)
    bot_obj.api.send_message(chat_id: message_obj.chat.id, text: 'Hello, Enter Your Birthday (YYYY-MM-DD)')
  end

  def send_goodbye(bot_obj, message_obj)
    bot_obj.api.send_message(chat_id: message_obj.chat.id, text: 'Goodbye!')
  end

  def send_unable_to_process(bot_obj, message_obj)
    bot_obj.api.send_message(chat_id: message_obj.chat.id, text: 'Unable to process. Please check your date...')
  end

  def send_invalid_date(bot_obj, message_obj)
    bot_obj.api.send_message(chat_id: message_obj.chat.id, text: 'Invalid date (Use format YYYY-MM-DD)')
  end
end

# rubocop: enable Metrics/MethodLength: Method has too many lines
