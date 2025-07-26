if GetResourceState('snipe-motel') ~= 'started' then return end

Debug('snipe-motel for apartments list ready', 'debug')

UM_apartments = {
    ['Opium Nights Motel'] = {
        type = '1',
        coords = vec4(-702.27, -2267.87, 13.46, 67.55),
        text = 'Opium Nights Motel',
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
