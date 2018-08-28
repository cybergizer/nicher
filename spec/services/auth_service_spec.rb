describe AuthService do
  context 'yandex' do
    let(:auth) { mock_auth[:'yandex'] }
    it 'is valid with valid oauth attributes' do
      expect(AuthService.new(auth, signed_in_resource = nil).find_for_oauth).to be_valid
    end    
  end

  context 'google' do
    let(:auth) { mock_auth[:'google_oauth2'] }
    it 'is valid with valid oauth attributes' do
      expect(AuthService.new(auth, signed_in_resource = nil).find_for_oauth).to be_valid
    end    
  end

  context 'vkontakte' do
    let(:auth) { mock_auth[:'vkontakte'] }
    it 'is valid with valid oauth attributes' do
      expect(AuthService.new(auth, signed_in_resource = nil).find_for_oauth).to_not be_valid
    end    
  end

  context 'facebook' do
    let(:auth) { mock_auth[:'facebook'] }
    it 'is valid with valid oauth attributes' do
      expect(AuthService.new(auth, signed_in_resource = nil).find_for_oauth).to be_valid
    end    
  end

  context 'github' do
    let(:auth) { mock_auth[:'github'] }
    it 'is valid with valid oauth attributes' do
      expect(AuthService.new(auth, signed_in_resource = nil).find_for_oauth).to_not be_valid
    end    
  end
end
