require "rspec"
require_relative "../lib/file_reader"

RSpec.describe FileReader do
  describe "#list_of_words" do
    it "returns a list of words from google-10000-english-no-swears.txt" do
      expect(subject.list_of_words).to eql(File.readlines("google-10000-english-no-swears.txt").map { |line| line.chomp })
    end
  end
end
