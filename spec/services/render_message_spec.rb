require 'spec_helper'

describe RenderMessage do
  it 'renders passed template with passed subscriber' do
    sub = Fabricate(:subscriber)
    template = Fabricate(:message, html: '{{name}}, {{email}}')
    out = described_class.new(template, sub).html
    expect(out).to include(sub.email)
    expect(out).to include(sub.name)
  end
end
