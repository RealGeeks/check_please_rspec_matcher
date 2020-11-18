require 'check_please'

module CheckPleaseRspecMatcher

  module RSpecHelper
    def check_please(expected, format_diffs: nil)
      CheckPleaseRspecMatcher::Matcher.new(expected, format_diffs: format_diffs)
    end
  end

  class Matcher
    def initialize(expected, opts = {})
      @expected = expected
      @opts = opts || {}
    end

    def matches?(actual)
      @actual = actual
      diffs.empty?
    end

    def failure_message
      format = opts[:format_diffs]
      diff_text = CheckPlease::Printers.render(diffs, format: format)
      <<~EOF
        Expected two JSON data structures to match, but found the following diffs:

        #{diff_text}
      EOF
    end

    private
    attr_reader :expected, :opts, :actual

    def diffs
      @_diffs ||= ::CheckPlease.diff(@expected, @actual)
    end
  end

end
