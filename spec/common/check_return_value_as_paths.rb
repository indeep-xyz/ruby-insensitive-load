shared_examples 'to return paths correctly' do |size|
  it 'return an array' do
    expect(subject).to \
        be_a_kind_of(Array)
  end

  it 'return an array of proper size' do
    expect(subject.size).to \
        eq(size)
  end

  it 'return the equivalent insensitively' do
    lower_result = subject.map(&:downcase)
    lower_path_source = path_source.downcase

    expect(lower_result).to \
        all(eq(lower_path_source))
  end
end
