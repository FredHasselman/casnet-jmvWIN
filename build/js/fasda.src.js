
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"y1","title":"Time series","type":"Variable"},{"name":"standardise","title":"Standardise","type":"List","options":[{"name":"meanSD","title":"Mean and SD"},{"name":"medianMAD","title":"Median and MAD"}],"default":"meanSD"},{"name":"sumORDER","title":"Adjust summation order","type":"Bool","default":false},{"name":"removeTrend","title":"Remove trend:","type":"List","options":[{"name":"nodet","title":"No detrending"},{"name":"polydet","title":"Polynomial detrending"}],"default":"nodet"},{"name":"polydet_order","title":"Polynomial order","type":"Integer","default":1},{"name":"scaleExclude","title":"Estimates based on at least","type":"Number","default":4}];

const view = View.extend({
    jus: "2.0",

    events: [

	]

});

view.layout = ui.extend({

    label: "Standardised Dispersion Analysis",
    jus: "2.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.VariableSupplier,
			persistentItems: false,
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.TargetLayoutBox,
					label: "Time series",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							name: "y1",
							maxItemCount: 1,
							isTarget: true
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			style: "inline",
			controls: [
				{
					type: DefaultControls.Label,
					label: "Adjust time series",
					controls: [
						{
							type: DefaultControls.RadioButton,
							name: "standardise_meanSD",
							optionName: "standardise",
							optionPart: "meanSD"
						},
						{
							type: DefaultControls.RadioButton,
							name: "standardise_medianMAD",
							optionName: "standardise",
							optionPart: "medianMAD"
						},
						{
							type: DefaultControls.CheckBox,
							name: "sumORDER"
						}
					]
				},
				{
					type: DefaultControls.Label,
					label: "Detrending method",
					controls: [
						{
							type: DefaultControls.RadioButton,
							name: "removeTrend_nodet",
							optionName: "removeTrend",
							optionPart: "nodet"
						},
						{
							type: DefaultControls.RadioButton,
							name: "removeTrend_polydet",
							optionName: "removeTrend",
							optionPart: "polydet",
							controls: [
								{
									type: DefaultControls.TextBox,
									name: "polydet_order",
									label: "Polynomial order",
									format: FormatDef.number,
									inputPattern: "[0-9]+",
									enable: "(removeTrend_polydet)"
								}
							]
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.TextBox,
					name: "scaleExclude",
					label: "Estimates based on at least",
					suffix: "data points",
					format: FormatDef.number,
					inputPattern: "[0-9]+"
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
