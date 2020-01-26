def FlagsForFile( file_name, **kwargs ):
  # Ensure that the client data parameter is actually supplied (just in case)
  if kwargs and 'client_data' in kwargs:
    # Extract the client_data parameter (see README.md entry for
    # g:ycm_extra_conf_vim_data)
    client_data = kwargs[ 'client_data' ]

    # Ensure the g:ycm_cpp_flags entry was supplied (paranoia)
    if client_data and 'b:ycm_cpp_flags' in client_data:
      # The return value is a dictionary containing:
      #   - flags = a list of compiler flags
      #   - do_cache = whether or not to cache the results. Always True
      print(client_data[ 'b:ycm_cpp_flags' ])
      return {
        'flags': client_data[ 'b:ycm_cpp_flags' ],
        'do_cache': True
      }

  # Otherwise, we don't know what flags to use, so return None (you could throw
  # an exception here instead with rasie RuntimeError( 'Missing client data' )
  # or something.
  return None
