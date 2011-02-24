require 'mail/body'
Mail::Body.module_eval do
  def encoded(transfer_encoding = '8bit')
    if multipart?
      self.sort_parts!
      encoded_parts = parts.map { |p| p.encoded }
      ([preamble] + encoded_parts).join(crlf_boundary) + end_boundary + epilogue.to_s
    else
      be = get_best_encoding(transfer_encoding)
      dec = Mail::Encodings::get_encoding(encoding)
      enc = Mail::Encodings::get_encoding(be)
      if transfer_encoding == encoding and dec.nil?
        # Cannot decode, so skip normalization
        raw_source
      else
        # Decode then encode to normalize and allow transforming 
        # from base64 to Q-P and vice versa
        decoded = dec.decode(raw_source)
        if defined?(Encoding) && charset && charset != "US-ASCII"
          decoded.encode!(charset)
          decoded.force_encoding('BINARY') unless Encoding.find(charset).ascii_compatible?
        end
        enc.encode(decoded)
      end
    end
  end
end

