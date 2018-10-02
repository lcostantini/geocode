scope 'return an error' do
  test 'when the get endpoint is missing' do
    get 'missing_get_endpoint'

    assert_equal last_response.status, 404
    assert last_response.body.include? 'not found'
  end
end

scope 'geocode_address endpoint' do
  test 'get a location with a valid address' do
    location = { lat: '52.5074434', lng: '13.3903913' }

    get 'geocode_address', { q: 'checkpoint charlie' }

    assert_equal last_response.status, 200
    assert_equal last_response.body[:geometry][:location], location
  end

  test 'get a ZERO_RESULT status with an invalid address' do
    get 'geocode_address', { q: 'invalid address' }

    assert_equal last_response.status, 200
    assert_equal json_parse(last_response.body)[:status], 'ZERO_RESULTS'
  end
end
