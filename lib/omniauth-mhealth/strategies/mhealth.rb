require 'omniauth/strategies/oauth2'
require 'base64'
require 'openssl'
require 'rack/utils'

module OmniAuth
  module Strategies
    class Mhealth < OmniAuth::Strategies::OAuth2
      class NoAuthorizationCodeError < StandardError; end

      DEFAULT_SCOPE = '/read/health/user'

      option :client_options, {
        site: 'https://mhealth.att.com',
        authorize_url: '/auth',
        token_url: '/access_token.json'
      }

      option :token_params, {
        parse: :query
      }

      option :access_token_options, {
        header_format: 'OAuth %s',
        param_name: 'oauth_token'
      }

      option :authorize_options, [:scope]

      uid { raw_info['email']['value'] }

      info do
        prune!({
                 'email'=> raw_info['email']['value'],
                 'name'=> raw_info['name']['value'],
               })
      end

      extra do
        hash = { }
        hash['raw_info'] = raw_info unless skip_info?
        prune! hash
      end

      def raw_info
        @raw_info ||= access_token.get('https://api-mhealth.att.com/v2/health/user').parsed || { }
      end

      def authorize_params
        super.tap do |params|
          params[:scope] ||= DEFAULT_SCOPE
        end
      end

      def build_access_token
        token_client = Faraday.new url: options.client_options[:site]
        post_params = {
          grant_type: 'authorization_code',
          code: request.params['code'],
          redirect_uri: self.callback_url,
        }
        auth = "Basic #{Base64.encode64([options.client_id, options.client_secret].join(':')).gsub("\n", '')}"
        resp = token_client.post('/access_token.json', post_params, 'Authorization'=>auth)
        decoded = MultiJson.decode resp.body
        self.access_token = ::OAuth2::AccessToken.from_hash client, decoded.merge(access_token_options)
      end

      private
      def access_token_options
        options.access_token_options.inject({ }) do |hash, (key, value)|
          hash[key.to_sym] = value
          hash
        end
      end



      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end
    end
  end
end
