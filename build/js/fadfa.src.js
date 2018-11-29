
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"y1","title":"Time series","type":"Variable"},{"name":"standardise","title":"Standardise","type":"List","options":[{"name":"none","title":"No standardisation"},{"name":"meanSD","title":"Mean and SD"},{"name":"medianMAD","title":"Median and MAD"}],"default":"meanSD"},{"name":"sumORDER","title":"Adjust summation order","type":"Bool","default":false},{"name":"removeTrend","title":"Remove trend in bins:","type":"List","options":[{"name":"poly","title":"Polynomial"},{"name":"adapt","title":"Adaptive"}],"default":"poly"},{"name":"poly_order","title":"Polynomial order","type":"Number","default":1},{"name":"max_order","title":"Maximum order","type":"Number","default":5},{"name":"minScale","title":"Minimum bin size: 2^","type":"List","options":[{"name":"autoMin","title":"Calculate based on time series length"},{"name":"userMin","title":"Enter value"}],"default":"autoMin"},{"name":"userMinScale","title":"Minimum bin size: 2^","type":"Number","default":2},{"name":"maxScale","title":"Maximum bin size: 2^","type":"List","options":[{"name":"autoMax","title":"Calculate based on time series length"},{"name":"userMax","title":"Enter value"}],"default":"autoMax"},{"name":"userMaxScale","title":"Maximum bin size: 2^","type":"Number","default":4},{"name":"scaleRES","title":"Bin sizes between min-max:","type":"Number","default":30},{"name":"scaleExclude","title":"Estimates based on at least","type":"Number","default":4}];

const view = View.extend({
    jus: "2.0",

    events: [

	]

});

view.layout = ui.extend({

    label: "Detrended Fluctuation Analysis",
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
							name: "standardise_none",
							optionName: "standardise",
							optionPart: "none"
						},
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
							name: "removeTrend_poly",
							optionName: "removeTrend",
							optionPart: "poly",
							controls: [
								{
									type: DefaultControls.TextBox,
									name: "poly_order",
									label: "Polynomial order",
									format: FormatDef.number,
									inputPattern: "[0-9]+",
									enable: "(removeTrend_poly)"
								}
							]
						},
						{
							type: DefaultControls.RadioButton,
							name: "removeTrend_adapt",
							optionName: "removeTrend",
							optionPart: "adapt",
							controls: [
								{
									type: DefaultControls.TextBox,
									name: "max_order",
									label: "Maximum order",
									format: FormatDef.number,
									inputPattern: "[0-9]+",
									enable: "(removeTrend_adapt)"
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
			style: "inline",
			controls: [
				{
					type: DefaultControls.Label,
					label: "Minimum scale",
					controls: [
						{
							type: DefaultControls.RadioButton,
							name: "minScale_autoMin",
							optionName: "minScale",
							optionPart: "autoMin"
						},
						{
							type: DefaultControls.RadioButton,
							name: "minScale_userMin",
							optionName: "minScale",
							optionPart: "userMin",
							controls: [
								{
									type: DefaultControls.TextBox,
									name: "userMinScale",
									label: "Maximum bin size: 2^",
									format: FormatDef.number,
									inputPattern: "[0-9]+",
									enable: "(minScale_userMin)"
								}
							]
						}
					]
				},
				{
					type: DefaultControls.Label,
					label: "Maximum scale",
					controls: [
						{
							type: DefaultControls.RadioButton,
							name: "maxScale_autoMax",
							optionName: "maxScale",
							optionPart: "autoMax"
						},
						{
							type: DefaultControls.RadioButton,
							name: "maxScale_userMax",
							optionName: "maxScale",
							optionPart: "userMax",
							controls: [
								{
									type: DefaultControls.TextBox,
									name: "userMaxScale",
									label: "Maximum bin size: 2^",
									format: FormatDef.number,
									inputPattern: "[0-9]+",
									enable: "(maxScale_userMax)"
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
					type: DefaultControls.Label,
					label: "Scale resolution",
					controls: [
						{
							type: DefaultControls.TextBox,
							name: "scaleRES",
							format: FormatDef.number,
							inputPattern: "[0-9]+"
						},
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
		}
	]
});

module.exports = { view : view, options: options };
