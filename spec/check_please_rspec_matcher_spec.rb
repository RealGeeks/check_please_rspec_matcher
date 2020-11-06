RSpec.describe CheckPleaseRspecMatcher do
  it "has a version number" do
    expect(CheckPleaseRspecMatcher::VERSION).not_to be nil
  end

  describe "the #check_please matcher (the name of which will almost certainly change!)" do

    # Because the name will almost certainly change,
    # let's make it so we only have to change it once.
    def invoke!(opts = {})
      expect( candidate ).to check_please( reference, **opts )
    end



    context "when given two equal JSON strings" do
      let(:reference) { '{ "foo": 42 }' }
      let(:candidate) { '{ "foo": 42 }' }

      it "does #match?" do
        invoke! # as long as this doesn't asplode, we're good
      end
    end

    context "when given two different JSON strings" do
      let(:reference) { '{ "foo": 42 }' }
      let(:candidate) { '{ "foo": 43 }' }

      it "does not #match?" do
        expect { invoke! }.to \
          raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      specify "#failure_message" do
        expected_diff = strip_trailing_whitespace(<<~EOF)
          TYPE     | PATH | REFERENCE | CANDIDATE
          ---------|------|-----------|----------
          mismatch | /foo | 42        | 43
        EOF

        msg = capture_failure_message { invoke! }
        expect( msg ).to match( /found the following diffs/ )
        expect( msg ).to include(expected_diff)
      end

      specify "#failure_message format can be changed with the :format_diffs kwarg" do
        expected_diff = strip_trailing_whitespace(<<~EOF)
          [
            { "type": "mismatch", "path": "/foo", "reference": 42, "candidate": 43 }
          ]
        EOF

        msg = capture_failure_message { invoke!(format_diffs: :json) }
        expect( msg ).to match( /found the following diffs/ )
        expect( msg ).to include(expected_diff)
      end
    end



    def capture_failure_message
      yield
      raise "Y U NO RAISE?"
    rescue RSpec::Expectations::ExpectationNotMetError => e
      msg = strip_trailing_whitespace( e.message )
      puts "--", msg, "--" if $debug
      return msg
    end

    def strip_trailing_whitespace(s)
      s.to_s.lines.map(&:rstrip).join("\n")
    end
  end
end
