require 'mail'
module Mail
  class UnstructuredField
    def encode(value)
      value.encode!(charset) if defined?(Encoding) && charset
      (value.not_ascii_only? ? [value].pack("M").gsub("=\n", '') : value).gsub("\r", "=0D").gsub("\n", "=0A")
    end
  end
end
