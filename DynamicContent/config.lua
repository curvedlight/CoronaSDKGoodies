application =
{
        content =
        {
               -- Must be the portrait orientation dimensions of your app world
               --  even if it is a landscape app-  see Corona config.lua docs
               width = 320,
               height = 480,
               scale = "letterbox",

				imageSuffix =
				{

					["-2x"] = 1.5,	-- play with this value to trigger
                                    -- what image gets loaded based on the devices true resolution
				},

		},

} 