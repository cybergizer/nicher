module OmniauthMacros
  # :reek:UtilityFunction
  # :reek:TooManyStatements
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    mock_auth = OmniAuth.config.mock_auth

    mock_auth[:google_oauth2] = {
      'provider': 'google_oauth2',
      'uid': '118093278763232643707',
      'info': {
        'name': 'Shizuku Tsukishima',
        'email': 'test_user@gmail.com',
        'first_name': 'Shizuku',
        'last_name': 'Tsukishima'
      },
      'extra': {
        'id_info': {
          'email': 'test_user@gmail.com',
          'email_verified': true,
          'at_hash': '16Zz8cBkzBYh2aIcKJAHaw',
          'exp': 1_534_401_382,
          'iss': 'accounts.google.com',
          'iat': 1_534_397_782
        },
        'raw_info': {
          'kind': 'plus#personOpenIdConnect',
          'gender': 'male',
          'name': 'Shizuku Tsukishima',
          'given_name': 'Shizuku',
          'family_name': 'Tsukishima',
          'email': 'test_user@gmail.com',
          'email_verified': 'true',
          'locale': 'ru'
        }
      }
    }

    mock_auth[:yandex] = {
      'provider': 'yandex',
      'uid': '1130000015191778',
      'info': {
        'nickname': 'test_user@tut.by', 'email': 'test_user@tut.by', 'name': 'Геннадий Батькович'
      },
      'extra': {
        'raw_info': {
          'first_name': 'Геннадий',
          'last_name': 'Батькович',
          'display_name': 'test_user@tut.by',
          'emails': ['test_user@tut.by'],
          'default_email': 'test_user@tut.by',
          'real_name': 'Геннадий Батькович',
          'login': 'test_user@tut.by',
          'sex': 'male',
          'id': '1130000015191778'
        }
      }
    }

    mock_auth[:vkontakte] = {
      'provider': 'vkontakte',
      'uid': '5858320',
      'info': {
        'name': 'Геннадий Симонович',
        'nickname': 'gsimon',
        'email': nil,
        'first_name': 'Геннадий',
        'last_name': 'Симонович'
      },
      'extra': {
        'raw_info': {
          'id': 5_858_320,
          'first_name': 'Геннадий',
          'last_name': 'Симонович',
          'sex': 2,
          'nickname': 'gsimon',
          'screen_name': 'gsimonovich'
        }
      }
    }

    mock_auth[:facebook] = {
      'provider': 'facebook',
      'uid': '10209738170170964',
      'info': {
        'email': 'test_user@mail.ru', 'name': 'Henadzi Simonovich'
      },
      'extra': {
        'raw_info': {
          'name': 'Henadzi Simonovich', 'email': 'test_user@mail.ru', 'id': '10209738170170964'
        }
      }
    }

    mock_auth[:github] = {
      'provider': 'github',
      'uid': '13178207',
      'info': {
        'nickname': 'simonovich',
        'email': nil,
        'name': nil
      },
      'extra': {
        'raw_info': {
          'login': 'simonovich',
          'id': 13_178_207,
          'email': nil
        }
      }
    }
  end

  def to_recursive_ostruct(hash)
    OpenStruct.new(hash.each_with_object({}) do |(key, val), memo|
      memo[key] = val.is_a?(Hash) ? to_recursive_ostruct(val) : val
    end)
  end
end
