require "spec_helper"

describe ClientNote do
  it { should belong_to :client }
end
