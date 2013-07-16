xml.instruct!
xml.Response do
  xml.Say "Welcome to I Heart Psychics. Please enter the psychic extension if you have one or wait on the line to be transferred.", :voice => "woman"
  xml.Say "You are calling from #{params[:From]}"
end
