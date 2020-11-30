require 'check_please'

module CheckPleaseRspecMatcher

  module RSpecHelper
    def check_please(expected, flags = {})
      ::CheckPleaseRspecMatcher::Matcher.new(expected, flags)
    end
  end

  class Matcher
    def initialize(expected, flags = {})
      @expected = expected
      @flags = flags || {}
    end

    def matches?(actual)
      @actual = actual
      diffs.empty?
    end

    def failure_message
      diff_text = ::CheckPlease::Printers.render(diffs, flags)
      <<~EOF
        Expected two JSON data structures to match, but found the following diffs:

        #{diff_text}
      EOF
    end

    private
    attr_reader :expected, :flags, :actual

    def diffs
      @_diffs ||= ::CheckPlease.diff(expected, actual, flags)
    end
  end

end
