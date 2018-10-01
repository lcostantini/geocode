scope do
  test 'get geocode location of an address' do
    location = { lat: '52.5074434', lng: '13.3903913' }

    VCR.use_cassette('get_geocode_of_address', record: :new_episodes) do
      res = GeocodeService.geocode_address('checkpoint charlie')

      assert_equal res[:status], 'OK'
      assert_equal res[:geometry][:location], location
    end
  end

  test 'get an error message if the address is incorrect' do
    VCR.use_cassette('fail_invalid_geocode_address', record: :new_episodes) do
      res = GeocodeService.geocode_address('invalid address')

      assert_equal res[:status], 'ZERO_RESULTS'
    end
  end

  test 'raise an error when there is an HTTP error' do
    assert_raise StandardError do
      res = Net::HTTPClientError.new('1.0', '408', 'request timeout')

      GeocodeService.handle_response(res)
    end
  end
end
