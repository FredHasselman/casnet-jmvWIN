
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"y1","title":"Time series","type":"Variable"},{"name":"standardise","title":"Standardise","type":"List","options":[{"name":"none","title":"No standardisation"},{"name":"meanSD","title":"Mean and SD"},{"name":"medianMAD","title":"Median and MAD"}],"default":"meanSD"},{"name":"sumORDER","title":"Adjust summation order","type":"Bool","default":false},{"name":"removeTrend","title":"Remove trend:","type":"List","options":[{"name":"nodet","title":"No detrending"},{"name":"polydet","title":"Polynomial detrending"}],"default":"nodet"},{"name":"polydet_order","title":"Polynomial order","type":"Integer","default":1},{"name":"minScale","title":"Minimum bin size: 2^","type":"List","options":[{"name":"autoMin","title":"Calculate based on time series length"},{"name":"userMin","title":"Enter value"}],"default":"autoMin"},{"name":"userMinScale","title":"Minimum bin size: 2^","type":"Number","default":2},{"name":"maxScale","title":"Maximum bin size: 2^","type":"List","options":[{"name":"autoMax","title":"Calculate based on time series length"},{"name":"userMax","title":"Enter value"}],"default":"autoMax"},{"name":"userMaxScale","title":"Maximum bin size: 2^","type":"Number","default":4},{"name":"scaleRES","title":"Bin sizes between min-max:","type":"Number","default":30},{"name":"scaleExclude","title":"Estimates based on at least","type":"Number","default":4}];

const view = function() {
    
    

    View.extend({
        jus: "2.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Standardised Dispersion Analysis",
    jus: "2.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.VariableSupplier,
			typeName: 'VariableSupplier',
			persistentItems: false,
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.TargetLayoutBox,
					typeName: 'TargetLayoutBox',
					label: "Time series",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
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
			typeName: 'LayoutBox',
			margin: "large",
			style: "inline",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Adjust time series",
					controls: [
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "standardise_none",
							optionName: "standardise",
							optionPart: "none"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "standardise_meanSD",
							optionName: "standardise",
							optionPart: "meanSD"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "standardise_medianMAD",
							optionName: "standardise",
							optionPart: "medianMAD"
						},
						{
							type: DefaultControls.CheckBox,
							typeName: 'CheckBox',
							name: "sumORDER"
						}
					]
				},
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Detrending method",
					controls: [
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "removeTrend_nodet",
							optionName: "removeTrend",
							optionPart: "nodet"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "removeTrend_polydet",
							optionName: "removeTrend",
							optionPart: "polydet",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "polydet_order",
									label: "Polynomial order",
									format: FormatDef.number,
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
			typeName: 'LayoutBox',
			margin: "large",
			style: "inline",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Minimum scale",
					controls: [
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "minScale_autoMin",
							optionName: "minScale",
							optionPart: "autoMin"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "minScale_userMin",
							optionName: "minScale",
							optionPart: "userMin",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "userMinScale",
									label: "Maximum bin size: 2^",
									format: FormatDef.number,
									enable: "(minScale_userMin)"
								}
							]
						}
					]
				},
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Maximum scale",
					controls: [
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "maxScale_autoMax",
							optionName: "maxScale",
							optionPart: "autoMax"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "maxScale_userMax",
							optionName: "maxScale",
							optionPart: "userMax",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "userMaxScale",
									label: "Maximum bin size: 2^",
									format: FormatDef.number,
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
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Scale resolution",
					controls: [
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "scaleRES",
							format: FormatDef.number
						},
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "scaleExclude",
							label: "Estimates based on at least",
							suffix: "data points",
							format: FormatDef.number
						}
					]
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
