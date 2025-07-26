if GetResourceState('nolag_properties') ~= 'started' then return end

Debug('nolag_properties for apartments list ready', 'debug')

UM_apartments = {
    ['Alta Street'] = {
        type = '1',
        coords = vec4(-702.27, -2267.87, 13.46, 67.55),
        text = 'Alta Street',
        image = 'https://files.fivemerr.com/images/2fec38dd-47bc-41d8-b146-2a7e8e726039.png',
        features = {
            beds = '1',
            bath = '1',
            sqft = '1'
        },
        desc = 'Just a quaint motel.',
        star = 4,
        tag = "rent"
    },
}
