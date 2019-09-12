
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"y1","title":"Time series","type":"Variable"},{"name":"standardise","title":"Standardisation","type":"List","options":[{"name":"none","title":"No standardisation"},{"name":"meanSD","title":"Mean and SD"},{"name":"medianMAD","title":"Median and MAD"}],"default":"meanSD"},{"name":"removeTrend","title":"Remove trend:","type":"List","options":[{"name":"nodet","title":"No detrending"},{"name":"polydet","title":"Polynomial detrending"}],"default":"nodet"},{"name":"polydet_order","title":"Polynomial order","type":"Integer","default":1},{"name":"fs","title":"Sample rate","type":"Integer","default":1},{"name":"nfft","title":"Number of frequencies","type":"List","options":[{"name":"nyquist","title":"Use Nyquist criterion"},{"name":"user","title":"Enter value"}],"default":"nyquist"},{"name":"userNFFT","title":"Number of frequencies","type":"Integer","default":256}];

const view = function() {
    
    

    View.extend({
        jus: "2.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Power Spectral Density Slope",
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
					label: "Nonparametric Power Spectral Density",
					controls: [
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "fs",
							format: FormatDef.number
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "nfft_nyquist",
							optionName: "nfft",
							optionPart: "nyquist"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "nfft_user",
							optionName: "nfft",
							optionPart: "user",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "userNFFT",
									format: FormatDef.number,
									enable: "(nfft_user)"
								}
							]
						}
					]
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
