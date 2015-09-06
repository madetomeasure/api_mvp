require 'spec_helper'

describe RenderMessage do
  it 'renders passed template with passed subscriber' do
    sub = Fabricate(:subscriber, metadata: {fun_level: 3})
    template = Fabricate(:message, html: '{{name}}, {{email}} {{metadata.fun_level}}')
    out = described_class.new(template, sub).html
    expect(out).to eql("#{sub.name}, #{sub.email} 3")
  end
end
