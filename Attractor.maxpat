{
	"patcher": {
		"fileversion": 1,
		"appversion": {
			"major": 8,
			"minor": 6,
			"revision": 2,
			"architecture": "x64",
			"modernui": 1
		},
		"classnamespace": "box",
		"rect": [
			80,
			100,
			800,
			600
		],
		"bglocked": 0,
		"openinpresentation": 1,
		"default_fontsize": 11.0,
		"default_fontface": 0,
		"default_fontname": "Arial",
		"gridonopen": 1,
		"gridsize": [
			10.0,
			10.0
		],
		"gridsnaponopen": 1,
		"objectsnaponopen": 1,
		"statusbarvisible": 2,
		"toolbarvisible": 1,
		"boxanimatetime": 200,
		"enablehscroll": 1,
		"enablevscroll": 1,
		"devicewidth": 800.0,
		"description": "Strange-attractor FM synthesizer",
		"digest": "ATTRACTOR \u2014 chaos-driven FM synth",
		"tags": "synth chaos fm attractor",
		"style": "",
		"subpatcher_template": "Instrument_Device",
		"assistshowspatchername": 0,
		"boxes": [
			{
				"box": {
					"maxclass": "comment",
					"text": "ATTRACTOR",
					"patching_rect": [
						812,
						12,
						140,
						22
					],
					"presentation": 1,
					"presentation_rect": [
						12,
						12,
						140,
						22
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 15,
					"textjustification": 0,
					"fontface": 1,
					"textcolor": [
						0.95,
						0.97,
						1.0,
						1.0
					],
					"id": "obj-1"
				}
			},
			{
				"box": {
					"maxclass": "ubutton",
					"patching_rect": [
						812,
						12,
						140,
						22
					],
					"presentation": 1,
					"presentation_rect": [
						12,
						12,
						140,
						22
					],
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"bang",
						"bang",
						"",
						"int"
					],
					"id": "obj-2"
				}
			},
			{
				"box": {
					"maxclass": "message",
					"text": "; max launchbrowser https://github.com/adriank1410/attractor-m4l",
					"patching_rect": [
						812,
						42,
						440,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"id": "obj-3"
				}
			},
			{
				"box": {
					"maxclass": "panel",
					"patching_rect": [
						812,
						32,
						100,
						2
					],
					"presentation": 1,
					"presentation_rect": [
						12,
						32,
						100,
						2
					],
					"numinlets": 1,
					"numoutlets": 0,
					"bgfillcolor_type": "color",
					"bgfillcolor_color": [
						0.95,
						0.55,
						0.2,
						1.0
					],
					"bgcolor": [
						0.95,
						0.55,
						0.2,
						1.0
					],
					"background": 1,
					"border": 0,
					"id": "obj-4"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "strange-attractor FM synthesizer \u00b7 v1.0",
					"patching_rect": [
						1310,
						0,
						290,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						510,
						0,
						290,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 10,
					"textjustification": 2,
					"textcolor": [
						0.55,
						0.62,
						0.82,
						1.0
					],
					"id": "obj-5"
				}
			},
			{
				"box": {
					"maxclass": "ubutton",
					"patching_rect": [
						1310,
						0,
						290,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						510,
						0,
						290,
						14
					],
					"numinlets": 1,
					"numoutlets": 4,
					"outlettype": [
						"bang",
						"bang",
						"",
						"int"
					],
					"id": "obj-6"
				}
			},
			{
				"box": {
					"maxclass": "message",
					"text": "; max launchbrowser https://adriankwiatkowski.eu",
					"patching_rect": [
						1310,
						30,
						320,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"id": "obj-7"
				}
			},
			{
				"box": {
					"maxclass": "live.toggle",
					"varname": "chaos",
					"patching_rect": [
						814,
						46,
						18,
						18
					],
					"presentation": 1,
					"presentation_rect": [
						14,
						46,
						18,
						18
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						""
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								1
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Chaos",
							"parameter_shortname": "Chaos",
							"parameter_linknames": 1,
							"parameter_mmin": 0,
							"parameter_mmax": 1,
							"parameter_enum": [
								"off",
								"on"
							],
							"parameter_type": 2,
							"parameter_annotation_name": "Chaos"
						}
					},
					"showname": 0,
					"annotation": "Master switch for the chaos engine. When off, no modulation is applied.",
					"id": "obj-8"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "chaos engine",
					"patching_rect": [
						838,
						46,
						92,
						18
					],
					"presentation": 1,
					"presentation_rect": [
						38,
						46,
						92,
						18
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 10,
					"textjustification": 0,
					"textcolor": [
						0.62,
						0.66,
						0.78,
						1.0
					],
					"id": "obj-9"
				}
			},
			{
				"box": {
					"maxclass": "live.menu",
					"varname": "attractor",
					"patching_rect": [
						814,
						68,
						110,
						22
					],
					"presentation": 1,
					"presentation_rect": [
						14,
						68,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"",
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_enum": [
								"Lorenz",
								"R\u00f6ssler",
								"Aizawa",
								"Thomas"
							],
							"parameter_initial": [
								0
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Attractor",
							"parameter_shortname": "Attractor",
							"parameter_linknames": 1,
							"parameter_mmax": 3,
							"parameter_type": 2,
							"parameter_unitstyle": 9,
							"parameter_annotation_name": "Attractor"
						}
					},
					"showname": 0,
					"annotation": "Strange-attractor algorithm \u2014 each gives a different chaos signature.",
					"id": "obj-10"
				}
			},
			{
				"box": {
					"maxclass": "live.dial",
					"varname": "sigma",
					"patching_rect": [
						932,
						40,
						40,
						32
					],
					"presentation": 1,
					"presentation_rect": [
						132,
						40,
						40,
						32
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								10.0
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Sigma",
							"parameter_shortname": "Sigma",
							"parameter_linknames": 1,
							"parameter_type": 0,
							"parameter_mmin": 1.0,
							"parameter_mmax": 30.0,
							"parameter_unitstyle": 1,
							"parameter_annotation_name": "Sigma"
						}
					},
					"showname": 0,
					"annotation": "Lorenz \u03c3 \u2014 Prandtl number. Higher = wilder swirl.",
					"id": "obj-11"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "\u03c3",
					"patching_rect": [
						930,
						76,
						44,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						130,
						76,
						44,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"textcolor": [
						0.78,
						0.82,
						0.92,
						1.0
					],
					"id": "obj-12"
				}
			},
			{
				"box": {
					"maxclass": "live.dial",
					"varname": "rho",
					"patching_rect": [
						980,
						40,
						40,
						32
					],
					"presentation": 1,
					"presentation_rect": [
						180,
						40,
						40,
						32
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								28.0
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Rho",
							"parameter_shortname": "Rho",
							"parameter_linknames": 1,
							"parameter_type": 0,
							"parameter_mmin": 1.0,
							"parameter_mmax": 50.0,
							"parameter_unitstyle": 1,
							"parameter_annotation_name": "Rho"
						}
					},
					"showname": 0,
					"annotation": "Lorenz \u03c1 \u2014 Rayleigh number. Below ~24 the system settles, above blooms into chaos.",
					"id": "obj-13"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "\u03c1",
					"patching_rect": [
						978,
						76,
						44,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						178,
						76,
						44,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"textcolor": [
						0.78,
						0.82,
						0.92,
						1.0
					],
					"id": "obj-14"
				}
			},
			{
				"box": {
					"maxclass": "live.dial",
					"varname": "beta",
					"patching_rect": [
						1028,
						40,
						40,
						32
					],
					"presentation": 1,
					"presentation_rect": [
						228,
						40,
						40,
						32
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								2.667
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Beta",
							"parameter_shortname": "Beta",
							"parameter_linknames": 1,
							"parameter_type": 0,
							"parameter_mmin": 0.1,
							"parameter_mmax": 10.0,
							"parameter_unitstyle": 1,
							"parameter_annotation_name": "Beta"
						}
					},
					"showname": 0,
					"annotation": "Lorenz \u03b2 \u2014 vertical damping. Classic butterfly value is 8/3 \u2248 2.667.",
					"id": "obj-15"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "\u03b2",
					"patching_rect": [
						1026,
						76,
						44,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						226,
						76,
						44,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"textcolor": [
						0.78,
						0.82,
						0.92,
						1.0
					],
					"id": "obj-16"
				}
			},
			{
				"box": {
					"maxclass": "live.dial",
					"varname": "speed",
					"patching_rect": [
						1076,
						40,
						40,
						32
					],
					"presentation": 1,
					"presentation_rect": [
						276,
						40,
						40,
						32
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								0.005
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Speed",
							"parameter_shortname": "Speed",
							"parameter_linknames": 1,
							"parameter_type": 0,
							"parameter_mmin": 0.0001,
							"parameter_mmax": 0.02,
							"parameter_unitstyle": 1,
							"parameter_exponent": 2.0,
							"parameter_annotation_name": "Speed"
						}
					},
					"showname": 0,
					"annotation": "Integration step size. Larger = faster trajectory.",
					"id": "obj-17"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "speed",
					"patching_rect": [
						1074,
						76,
						44,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						274,
						76,
						44,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"textcolor": [
						0.78,
						0.82,
						0.92,
						1.0
					],
					"id": "obj-18"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "CHAOS ENGINE",
					"patching_rect": [
						932,
						22,
						184,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						132,
						22,
						184,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"fontface": 1,
					"textcolor": [
						0.62,
						0.66,
						0.78,
						1.0
					],
					"id": "obj-19"
				}
			},
			{
				"box": {
					"maxclass": "live.dial",
					"varname": "ratio",
					"patching_rect": [
						1142,
						40,
						40,
						32
					],
					"presentation": 1,
					"presentation_rect": [
						342,
						40,
						40,
						32
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								2.0
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Ratio",
							"parameter_shortname": "Ratio",
							"parameter_linknames": 1,
							"parameter_type": 0,
							"parameter_mmin": 0.25,
							"parameter_mmax": 8.0,
							"parameter_unitstyle": 1,
							"parameter_exponent": 2.0,
							"parameter_annotation_name": "Ratio"
						}
					},
					"showname": 0,
					"annotation": "FM modulator-to-carrier frequency ratio.",
					"id": "obj-20"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "ratio",
					"patching_rect": [
						1140,
						76,
						44,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						340,
						76,
						44,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"textcolor": [
						0.78,
						0.82,
						0.92,
						1.0
					],
					"id": "obj-21"
				}
			},
			{
				"box": {
					"maxclass": "live.dial",
					"varname": "index",
					"patching_rect": [
						1190,
						40,
						40,
						32
					],
					"presentation": 1,
					"presentation_rect": [
						390,
						40,
						40,
						32
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								3.0
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Index",
							"parameter_shortname": "Index",
							"parameter_linknames": 1,
							"parameter_type": 0,
							"parameter_mmin": 0.0,
							"parameter_mmax": 10.0,
							"parameter_unitstyle": 1,
							"parameter_annotation_name": "Index"
						}
					},
					"showname": 0,
					"annotation": "FM modulation index. 0 = pure sine, higher = brighter.",
					"id": "obj-22"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "index",
					"patching_rect": [
						1188,
						76,
						44,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						388,
						76,
						44,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"textcolor": [
						0.78,
						0.82,
						0.92,
						1.0
					],
					"id": "obj-23"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "FM",
					"patching_rect": [
						1142,
						22,
						88,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						342,
						22,
						88,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"fontface": 1,
					"textcolor": [
						0.62,
						0.66,
						0.78,
						1.0
					],
					"id": "obj-24"
				}
			},
			{
				"box": {
					"maxclass": "live.dial",
					"varname": "attack",
					"patching_rect": [
						1256,
						40,
						40,
						32
					],
					"presentation": 1,
					"presentation_rect": [
						456,
						40,
						40,
						32
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								8.0
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Attack",
							"parameter_shortname": "Attack",
							"parameter_linknames": 1,
							"parameter_type": 0,
							"parameter_mmin": 1.0,
							"parameter_mmax": 2000.0,
							"parameter_unitstyle": 2,
							"parameter_exponent": 3.0,
							"parameter_annotation_name": "Attack"
						}
					},
					"showname": 0,
					"annotation": "Note attack time in milliseconds.",
					"id": "obj-25"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "attack",
					"patching_rect": [
						1254,
						76,
						44,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						454,
						76,
						44,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"textcolor": [
						0.78,
						0.82,
						0.92,
						1.0
					],
					"id": "obj-26"
				}
			},
			{
				"box": {
					"maxclass": "live.dial",
					"varname": "release",
					"patching_rect": [
						1304,
						40,
						40,
						32
					],
					"presentation": 1,
					"presentation_rect": [
						504,
						40,
						40,
						32
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								320.0
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Release",
							"parameter_shortname": "Release",
							"parameter_linknames": 1,
							"parameter_type": 0,
							"parameter_mmin": 5.0,
							"parameter_mmax": 4000.0,
							"parameter_unitstyle": 2,
							"parameter_exponent": 3.0,
							"parameter_annotation_name": "Release"
						}
					},
					"showname": 0,
					"annotation": "Note release time \u2014 how long the tail rings.",
					"id": "obj-27"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "release",
					"patching_rect": [
						1302,
						76,
						44,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						502,
						76,
						44,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"textcolor": [
						0.78,
						0.82,
						0.92,
						1.0
					],
					"id": "obj-28"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "ENVELOPE",
					"patching_rect": [
						1256,
						22,
						88,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						456,
						22,
						88,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"fontface": 1,
					"textcolor": [
						0.62,
						0.66,
						0.78,
						1.0
					],
					"id": "obj-29"
				}
			},
			{
				"box": {
					"maxclass": "live.dial",
					"varname": "depth",
					"patching_rect": [
						1370,
						40,
						40,
						32
					],
					"presentation": 1,
					"presentation_rect": [
						570,
						40,
						40,
						32
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								0.55
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Depth",
							"parameter_shortname": "Depth",
							"parameter_linknames": 1,
							"parameter_type": 0,
							"parameter_mmin": 0.0,
							"parameter_mmax": 1.0,
							"parameter_unitstyle": 1,
							"parameter_annotation_name": "Depth"
						}
					},
					"showname": 0,
					"annotation": "How strongly chaos modulates ratio, index and amplitude.",
					"id": "obj-30"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "depth",
					"patching_rect": [
						1368,
						76,
						44,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						568,
						76,
						44,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"textcolor": [
						0.78,
						0.82,
						0.92,
						1.0
					],
					"id": "obj-31"
				}
			},
			{
				"box": {
					"maxclass": "live.dial",
					"varname": "drive",
					"patching_rect": [
						1418,
						40,
						40,
						32
					],
					"presentation": 1,
					"presentation_rect": [
						618,
						40,
						40,
						32
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								0.3
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Drive",
							"parameter_shortname": "Drive",
							"parameter_linknames": 1,
							"parameter_type": 0,
							"parameter_mmin": 0.0,
							"parameter_mmax": 1.0,
							"parameter_unitstyle": 1,
							"parameter_annotation_name": "Drive"
						}
					},
					"showname": 0,
					"annotation": "Soft saturation \u2014 tanh waveshaper.",
					"id": "obj-32"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "drive",
					"patching_rect": [
						1416,
						76,
						44,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						616,
						76,
						44,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"textcolor": [
						0.78,
						0.82,
						0.92,
						1.0
					],
					"id": "obj-33"
				}
			},
			{
				"box": {
					"maxclass": "live.dial",
					"varname": "glide",
					"patching_rect": [
						1466,
						40,
						40,
						32
					],
					"presentation": 1,
					"presentation_rect": [
						666,
						40,
						40,
						32
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								30.0
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Glide",
							"parameter_shortname": "Glide",
							"parameter_linknames": 1,
							"parameter_type": 0,
							"parameter_mmin": 0.0,
							"parameter_mmax": 500.0,
							"parameter_unitstyle": 2,
							"parameter_exponent": 2.0,
							"parameter_annotation_name": "Glide"
						}
					},
					"showname": 0,
					"annotation": "Portamento time. 0 = retrigger, higher = legato.",
					"id": "obj-34"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "glide",
					"patching_rect": [
						1464,
						76,
						44,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						664,
						76,
						44,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"textcolor": [
						0.78,
						0.82,
						0.92,
						1.0
					],
					"id": "obj-35"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "MODULATION",
					"patching_rect": [
						1370,
						22,
						136,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						570,
						22,
						136,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"fontface": 1,
					"textcolor": [
						0.62,
						0.66,
						0.78,
						1.0
					],
					"id": "obj-36"
				}
			},
			{
				"box": {
					"maxclass": "live.dial",
					"varname": "volume",
					"patching_rect": [
						1532,
						40,
						40,
						32
					],
					"presentation": 1,
					"presentation_rect": [
						732,
						40,
						40,
						32
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"",
						"float"
					],
					"parameter_enable": 1,
					"saved_attribute_attributes": {
						"valueof": {
							"parameter_initial": [
								-12.0
							],
							"parameter_initial_enable": 1,
							"parameter_longname": "Volume",
							"parameter_shortname": "Volume",
							"parameter_linknames": 1,
							"parameter_type": 0,
							"parameter_mmin": -60.0,
							"parameter_mmax": 6.0,
							"parameter_unitstyle": 4,
							"parameter_annotation_name": "Volume"
						}
					},
					"showname": 0,
					"annotation": "Output level (dB). Per-note level scales with MIDI velocity.",
					"id": "obj-37"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "volume",
					"patching_rect": [
						1530,
						76,
						44,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						730,
						76,
						44,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"textcolor": [
						0.78,
						0.82,
						0.92,
						1.0
					],
					"id": "obj-38"
				}
			},
			{
				"box": {
					"maxclass": "comment",
					"text": "OUT",
					"patching_rect": [
						1532,
						22,
						40,
						14
					],
					"presentation": 1,
					"presentation_rect": [
						732,
						22,
						40,
						14
					],
					"numinlets": 1,
					"numoutlets": 0,
					"fontsize": 9,
					"textjustification": 1,
					"fontface": 1,
					"textcolor": [
						0.62,
						0.66,
						0.78,
						1.0
					],
					"id": "obj-39"
				}
			},
			{
				"box": {
					"maxclass": "jsui",
					"filename": "attractor_viz.js",
					"patching_rect": [
						804,
						92,
						792,
						73
					],
					"presentation": 1,
					"presentation_rect": [
						4,
						92,
						792,
						73
					],
					"numinlets": 1,
					"numoutlets": 3,
					"outlettype": [
						"float",
						"float",
						"float"
					],
					"parameter_enable": 0,
					"id": "obj-40"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "midiin",
					"patching_rect": [
						20,
						20,
						70,
						22
					],
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"id": "obj-41"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "midiparse",
					"patching_rect": [
						20,
						56,
						120,
						22
					],
					"numinlets": 1,
					"numoutlets": 6,
					"outlettype": [
						"list",
						"list",
						"int",
						"int",
						"int",
						"int"
					],
					"id": "obj-42"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "stripnote",
					"patching_rect": [
						20,
						92,
						120,
						22
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					],
					"id": "obj-43"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "unpack 0 0",
					"patching_rect": [
						20,
						124,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"int",
						"int"
					],
					"id": "obj-44"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "mtof",
					"patching_rect": [
						20,
						156,
						50,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": null,
					"id": "obj-45"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "pak 0. 30.",
					"patching_rect": [
						20,
						188,
						120,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-46"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "line~",
					"patching_rect": [
						20,
						220,
						70,
						22
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						"bang"
					],
					"id": "obj-47"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "/ 127.",
					"patching_rect": [
						160,
						20,
						70,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": null,
					"id": "obj-48"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "pak attack 8.",
					"patching_rect": [
						160,
						56,
						140,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-49"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "pak release 320.",
					"patching_rect": [
						160,
						88,
						140,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-50"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "adsr~ 8 50 0.85 320",
					"patching_rect": [
						160,
						124,
						200,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-51"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "snapshot~ 50",
					"patching_rect": [
						0,
						20,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"float"
					],
					"id": "obj-52"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "> 0.001",
					"patching_rect": [
						0,
						44,
						70,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"id": "obj-53"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "expr $i1 * $i2",
					"patching_rect": [
						0,
						68,
						140,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"int"
					],
					"id": "obj-54"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "metro 5",
					"patching_rect": [
						220,
						20,
						70,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"id": "obj-55"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "metro 50",
					"patching_rect": [
						0,
						100,
						80,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"id": "obj-56"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "loadbang",
					"patching_rect": [
						-80,
						100,
						70,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"id": "obj-57"
				}
			},
			{
				"box": {
					"maxclass": "message",
					"text": "1",
					"patching_rect": [
						-80,
						124,
						30,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"id": "obj-58"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "prepend fade",
					"patching_rect": [
						0,
						130,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-59"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "prepend active",
					"patching_rect": [
						20,
						156,
						120,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-60"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "prepend sigma",
					"patching_rect": [
						60,
						20,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-61"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "prepend rho",
					"patching_rect": [
						60,
						44,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-62"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "prepend beta",
					"patching_rect": [
						60,
						68,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-63"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "prepend speed",
					"patching_rect": [
						60,
						92,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-64"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "prepend mode",
					"patching_rect": [
						60,
						116,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-65"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "pak 0. 5.",
					"patching_rect": [
						220,
						92,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-66"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "line~",
					"patching_rect": [
						220,
						124,
						70,
						22
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						"bang"
					],
					"id": "obj-67"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "pak 0. 5.",
					"patching_rect": [
						340,
						92,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-68"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "line~",
					"patching_rect": [
						340,
						124,
						70,
						22
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						"bang"
					],
					"id": "obj-69"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "pak 0. 5.",
					"patching_rect": [
						460,
						92,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-70"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "line~",
					"patching_rect": [
						460,
						124,
						70,
						22
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						"bang"
					],
					"id": "obj-71"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "pak 0.55 20.",
					"patching_rect": [
						340,
						156,
						120,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-72"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "line~",
					"patching_rect": [
						340,
						188,
						60,
						22
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						"bang"
					],
					"id": "obj-73"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "pak 2.0 20.",
					"patching_rect": [
						500,
						20,
						120,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-74"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "line~",
					"patching_rect": [
						500,
						52,
						60,
						22
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						"bang"
					],
					"id": "obj-75"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "pak 3.0 20.",
					"patching_rect": [
						640,
						20,
						120,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-76"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "line~",
					"patching_rect": [
						640,
						52,
						60,
						22
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						"bang"
					],
					"id": "obj-77"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~",
					"patching_rect": [
						500,
						88,
						40,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-78"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~ 2.",
					"patching_rect": [
						500,
						116,
						50,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-79"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "+~",
					"patching_rect": [
						500,
						144,
						40,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-80"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~",
					"patching_rect": [
						500,
						176,
						40,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-81"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "phasor~ 0",
					"patching_rect": [
						500,
						208,
						70,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-82"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "cos~",
					"patching_rect": [
						500,
						240,
						50,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-83"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~",
					"patching_rect": [
						700,
						88,
						40,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-84"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~ 4.",
					"patching_rect": [
						700,
						116,
						50,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-85"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "+~",
					"patching_rect": [
						700,
						144,
						40,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-86"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~",
					"patching_rect": [
						700,
						240,
						40,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-87"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~ 0.1",
					"patching_rect": [
						700,
						268,
						60,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-88"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "phasor~ 0",
					"patching_rect": [
						500,
						272,
						70,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-89"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "+~",
					"patching_rect": [
						500,
						304,
						40,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-90"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "cos~",
					"patching_rect": [
						500,
						332,
						50,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-91"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "pak 0.3 20.",
					"patching_rect": [
						700,
						304,
						120,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-92"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "line~",
					"patching_rect": [
						700,
						332,
						60,
						22
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						"bang"
					],
					"id": "obj-93"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "scale~ 0. 1. 1. 6.",
					"patching_rect": [
						700,
						360,
						140,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-94"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~",
					"patching_rect": [
						500,
						360,
						40,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-95"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "tanh~",
					"patching_rect": [
						500,
						388,
						60,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-96"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~",
					"patching_rect": [
						500,
						416,
						40,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-97"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~",
					"patching_rect": [
						700,
						416,
						40,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-98"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~ 0.3",
					"patching_rect": [
						700,
						444,
						60,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-99"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "+~ 1.",
					"patching_rect": [
						700,
						472,
						60,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-100"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~",
					"patching_rect": [
						500,
						472,
						40,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-101"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~ 0.5",
					"patching_rect": [
						500,
						500,
						70,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-102"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "dbtoa",
					"patching_rect": [
						340,
						500,
						60,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": null,
					"id": "obj-103"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "pak 0.25 20.",
					"patching_rect": [
						340,
						528,
						130,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"list"
					],
					"id": "obj-104"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "line~",
					"patching_rect": [
						340,
						556,
						60,
						22
					],
					"numinlets": 1,
					"numoutlets": 2,
					"outlettype": [
						"signal",
						"bang"
					],
					"id": "obj-105"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "*~",
					"patching_rect": [
						500,
						528,
						40,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-106"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "tanh~",
					"patching_rect": [
						500,
						560,
						60,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"signal"
					],
					"id": "obj-107"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "plugout~ 1 2",
					"patching_rect": [
						500,
						590,
						110,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": null,
					"id": "obj-108"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "loadbang",
					"patching_rect": [
						-180,
						20,
						70,
						22
					],
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"id": "obj-109"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "delay 50",
					"patching_rect": [
						-180,
						50,
						70,
						22
					],
					"numinlets": 1,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"id": "obj-110"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "t b b b b b b b b b b b b b b",
					"patching_rect": [
						-180,
						80,
						300,
						22
					],
					"numinlets": 1,
					"numoutlets": 14,
					"outlettype": [
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang",
						"bang"
					],
					"id": "obj-111"
				}
			},
			{
				"box": {
					"maxclass": "message",
					"text": "1",
					"patching_rect": [
						-180,
						110,
						30,
						22
					],
					"numinlets": 2,
					"numoutlets": 1,
					"outlettype": [
						""
					],
					"id": "obj-112"
				}
			},
			{
				"box": {
					"maxclass": "newobj",
					"text": "loadmess 1",
					"patching_rect": [
						-80,
						140,
						110,
						22
					],
					"numinlets": 0,
					"numoutlets": 1,
					"outlettype": [
						"bang"
					],
					"id": "obj-113"
				}
			}
		],
		"lines": [
			{
				"patchline": {
					"source": [
						"obj-2",
						0
					],
					"destination": [
						"obj-3",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-6",
						0
					],
					"destination": [
						"obj-7",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-41",
						0
					],
					"destination": [
						"obj-42",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-42",
						0
					],
					"destination": [
						"obj-43",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-42",
						0
					],
					"destination": [
						"obj-44",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-43",
						0
					],
					"destination": [
						"obj-45",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-45",
						0
					],
					"destination": [
						"obj-46",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-46",
						0
					],
					"destination": [
						"obj-47",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-44",
						1
					],
					"destination": [
						"obj-48",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-48",
						0
					],
					"destination": [
						"obj-51",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-25",
						0
					],
					"destination": [
						"obj-49",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-27",
						0
					],
					"destination": [
						"obj-50",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-49",
						0
					],
					"destination": [
						"obj-51",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-50",
						0
					],
					"destination": [
						"obj-51",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-34",
						0
					],
					"destination": [
						"obj-46",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-51",
						0
					],
					"destination": [
						"obj-52",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-52",
						0
					],
					"destination": [
						"obj-53",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-53",
						0
					],
					"destination": [
						"obj-54",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-8",
						0
					],
					"destination": [
						"obj-54",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-54",
						0
					],
					"destination": [
						"obj-55",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-55",
						0
					],
					"destination": [
						"obj-40",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-57",
						0
					],
					"destination": [
						"obj-58",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-58",
						0
					],
					"destination": [
						"obj-56",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-56",
						0
					],
					"destination": [
						"obj-59",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-59",
						0
					],
					"destination": [
						"obj-40",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-8",
						0
					],
					"destination": [
						"obj-60",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-60",
						0
					],
					"destination": [
						"obj-10",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-60",
						0
					],
					"destination": [
						"obj-11",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-60",
						0
					],
					"destination": [
						"obj-13",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-60",
						0
					],
					"destination": [
						"obj-15",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-60",
						0
					],
					"destination": [
						"obj-17",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-60",
						0
					],
					"destination": [
						"obj-30",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-11",
						0
					],
					"destination": [
						"obj-61",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-13",
						0
					],
					"destination": [
						"obj-62",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-15",
						0
					],
					"destination": [
						"obj-63",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-17",
						0
					],
					"destination": [
						"obj-64",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-10",
						0
					],
					"destination": [
						"obj-65",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-61",
						0
					],
					"destination": [
						"obj-40",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-62",
						0
					],
					"destination": [
						"obj-40",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-63",
						0
					],
					"destination": [
						"obj-40",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-64",
						0
					],
					"destination": [
						"obj-40",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-65",
						0
					],
					"destination": [
						"obj-40",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-40",
						0
					],
					"destination": [
						"obj-66",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-40",
						1
					],
					"destination": [
						"obj-68",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-40",
						2
					],
					"destination": [
						"obj-70",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-66",
						0
					],
					"destination": [
						"obj-67",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-68",
						0
					],
					"destination": [
						"obj-69",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-70",
						0
					],
					"destination": [
						"obj-71",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-30",
						0
					],
					"destination": [
						"obj-72",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-72",
						0
					],
					"destination": [
						"obj-73",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-20",
						0
					],
					"destination": [
						"obj-74",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-74",
						0
					],
					"destination": [
						"obj-75",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-22",
						0
					],
					"destination": [
						"obj-76",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-76",
						0
					],
					"destination": [
						"obj-77",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-69",
						0
					],
					"destination": [
						"obj-78",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-73",
						0
					],
					"destination": [
						"obj-78",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-78",
						0
					],
					"destination": [
						"obj-79",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-75",
						0
					],
					"destination": [
						"obj-80",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-79",
						0
					],
					"destination": [
						"obj-80",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-47",
						0
					],
					"destination": [
						"obj-81",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-80",
						0
					],
					"destination": [
						"obj-81",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-81",
						0
					],
					"destination": [
						"obj-82",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-82",
						0
					],
					"destination": [
						"obj-83",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-67",
						0
					],
					"destination": [
						"obj-84",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-73",
						0
					],
					"destination": [
						"obj-84",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-84",
						0
					],
					"destination": [
						"obj-85",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-77",
						0
					],
					"destination": [
						"obj-86",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-85",
						0
					],
					"destination": [
						"obj-86",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-83",
						0
					],
					"destination": [
						"obj-87",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-86",
						0
					],
					"destination": [
						"obj-87",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-87",
						0
					],
					"destination": [
						"obj-88",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-47",
						0
					],
					"destination": [
						"obj-89",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-89",
						0
					],
					"destination": [
						"obj-90",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-88",
						0
					],
					"destination": [
						"obj-90",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-90",
						0
					],
					"destination": [
						"obj-91",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-32",
						0
					],
					"destination": [
						"obj-92",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-92",
						0
					],
					"destination": [
						"obj-93",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-93",
						0
					],
					"destination": [
						"obj-94",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-91",
						0
					],
					"destination": [
						"obj-95",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-94",
						0
					],
					"destination": [
						"obj-95",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-95",
						0
					],
					"destination": [
						"obj-96",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-96",
						0
					],
					"destination": [
						"obj-97",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-51",
						0
					],
					"destination": [
						"obj-97",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-71",
						0
					],
					"destination": [
						"obj-98",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-73",
						0
					],
					"destination": [
						"obj-98",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-98",
						0
					],
					"destination": [
						"obj-99",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-99",
						0
					],
					"destination": [
						"obj-100",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-97",
						0
					],
					"destination": [
						"obj-101",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-100",
						0
					],
					"destination": [
						"obj-101",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-101",
						0
					],
					"destination": [
						"obj-102",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-37",
						0
					],
					"destination": [
						"obj-103",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-103",
						0
					],
					"destination": [
						"obj-104",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-104",
						0
					],
					"destination": [
						"obj-105",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-102",
						0
					],
					"destination": [
						"obj-106",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-105",
						0
					],
					"destination": [
						"obj-106",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-106",
						0
					],
					"destination": [
						"obj-107",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-107",
						0
					],
					"destination": [
						"obj-108",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-107",
						0
					],
					"destination": [
						"obj-108",
						1
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-109",
						0
					],
					"destination": [
						"obj-110",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-110",
						0
					],
					"destination": [
						"obj-111",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						0
					],
					"destination": [
						"obj-37",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						1
					],
					"destination": [
						"obj-11",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						2
					],
					"destination": [
						"obj-13",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						3
					],
					"destination": [
						"obj-15",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						4
					],
					"destination": [
						"obj-17",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						5
					],
					"destination": [
						"obj-20",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						6
					],
					"destination": [
						"obj-22",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						7
					],
					"destination": [
						"obj-25",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						8
					],
					"destination": [
						"obj-27",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						9
					],
					"destination": [
						"obj-30",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						10
					],
					"destination": [
						"obj-32",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						11
					],
					"destination": [
						"obj-34",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						12
					],
					"destination": [
						"obj-10",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-111",
						13
					],
					"destination": [
						"obj-112",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-112",
						0
					],
					"destination": [
						"obj-8",
						0
					],
					"order": 0
				}
			},
			{
				"patchline": {
					"source": [
						"obj-113",
						0
					],
					"destination": [
						"obj-8",
						0
					],
					"order": 0
				}
			}
		],
		"dependency_cache": [],
		"autosave": 0
	}
}