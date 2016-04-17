require 'httparty'

class ConversationController < ApplicationController
    def index

    end

    def respond
        incoming_message = params[:message]
        outgoing_message = ""

        if params.has_key? :autorespond
            outgoing_message = "Hello"
        else
            sentiment = get_sentiment(incoming_message)

            positive_keywords = []
            neutral_keywords = []
            negative_keywords = []

            sentiment['keywords'].each do |keyword|
                if keyword['sentiment']['type'] == "positive"
                    positive_keywords << keyword['text']
                elsif keyword['sentiment']['type'] == "neutral"
                    neutral_keywords << keyword['text']
                elsif keyword['sentiment']['type'] = "negative"
                    negative_keywords << keyword['text']
                end
            end

            outgoing_message = "Goodbye"
        end

        render json: { message: outgoing_message, code: 0 }
    end

    private
    def get_sentiment(message)
        query = {
            'apikey': ENV['API_ALCHEMY'],
            'outputMode': 'json',
            'text': message,
            'sentiment': 1
        }

        headers = {
            'accept-encoding': 'none'
        }

        response = HTTParty.get("http://gateway-a.watsonplatform.net/calls/text/TextGetRankedKeywords", query: query, headers: headers)

        return JSON.parse response.body
    end
end
