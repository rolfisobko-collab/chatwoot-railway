FROM chatwoot/chatwoot:v3.12.0

# Allow iframe embedding from Frappe
RUN printf "Rails.application.config.action_dispatch.default_headers.delete('X-Frame-Options')\nRails.application.config.action_dispatch.default_headers['Content-Security-Policy'] = \"frame-ancestors *\"\n" > /app/config/initializers/allow_iframe.rb
