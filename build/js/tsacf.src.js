
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"dv1","title":"Time series Y1","type":"Variable"},{"name":"dv2","title":"Time series Y2 (optional)","type":"Variable"},{"name":"maxLAG","title":"Maximum lag","type":"Number","default":20},{"name":"doTest","type":"Bool","title":"Use Fisher r-to-Z test","default":true},{"name":"siglevel","type":"Number","title":"Significance level","min":0,"max":1,"default":0.05},{"name":"hypothesis","title":"Alternative hypothesis","type":"List","options":[{"name":"greater","title":"ρ > 0"},{"name":"less","title":"ρ < 0"},{"name":"both","title":"ρ ≠ 0"}],"default":"both","description":{"R":"`'greater'`, `'less'`, or `'both'` (default).\n"}},{"name":"rtLAG1","title":"Plot Y1(t) against Y1(t+n)","type":"Number","default":1},{"name":"rtLAG2","title":"Plot Y2(t) against Y2(t+n)","type":"Number","default":1}];

const view = View.extend({
    jus: "2.0",

    events: [

	]

});

view.layout = ui.extend({

    label: "Linear Temporal Correlations",
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
					label: "Time series 1",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							name: "dv1",
							maxItemCount: 1,
							isTarget: true
						}
					]
				},
				{
					type: DefaultControls.TargetLayoutBox,
					label: "Time series 2 (optional)",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							name: "dv2",
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
			controls: [
				{
					type: DefaultControls.Label,
					label: "Correlation Function Plots",
					controls: [
						{
							type: DefaultControls.TextBox,
							name: "maxLAG",
							format: FormatDef.number,
							inputPattern: "[0-9]+"
						},
						{
							type: DefaultControls.LayoutBox,
							margin: "large",
							controls: [
								{
									type: DefaultControls.CheckBox,
									name: "doTest"
								},
								{
									type: DefaultControls.LayoutBox,
									margin: "large",
									controls: [
										{
											type: DefaultControls.TextBox,
											name: "siglevel",
											format: FormatDef.number,
											inputPattern: "[0-9]+"
										},
										{
											type: DefaultControls.LayoutBox,
											margin: "large",
											controls: [
												{
													type: DefaultControls.ComboBox,
													name: "hypothesis"
												}
											]
										}
									]
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
					label: "Lag Plot",
					controls: [
						{
							type: DefaultControls.TextBox,
							name: "rtLAG1",
							format: FormatDef.number,
							inputPattern: "[0-9]+"
						},
						{
							type: DefaultControls.TextBox,
							name: "rtLAG2",
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
