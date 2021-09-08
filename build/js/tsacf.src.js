
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"dv1","title":"Time series Y1","type":"Variable"},{"name":"dv2","title":"Time series Y2 (optional)","type":"Variable"},{"name":"maxLAG","title":"Maximum lag","type":"Number","default":20},{"name":"doTest","type":"Bool","title":"Use Fisher r-to-Z test","default":true},{"name":"siglevel","type":"Number","title":"Significance level","min":0,"max":1,"default":0.05},{"name":"hypothesis","title":"Alternative hypothesis","type":"List","options":[{"name":"greater","title":"ρ > 0"},{"name":"less","title":"ρ < 0"},{"name":"both","title":"ρ ≠ 0"}],"default":"both","description":{"R":"`'greater'`, `'less'`, or `'both'` (default).\n"}},{"name":"rtLAG1","title":"Plot Y1(t) against Y1(t+n)","type":"Number","default":1},{"name":"rtLAG2","title":"Plot Y2(t) against Y2(t+n)","type":"Number","default":1}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Linear Temporal Correlations",
    jus: "3.0",
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
					label: "Time series 1",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
							name: "dv1",
							maxItemCount: 1,
							isTarget: true
						}
					]
				},
				{
					type: DefaultControls.TargetLayoutBox,
					typeName: 'TargetLayoutBox',
					label: "Time series 2 (optional)",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
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
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Correlation Function Plots",
					controls: [
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "maxLAG",
							format: FormatDef.number
						},
						{
							type: DefaultControls.LayoutBox,
							typeName: 'LayoutBox',
							margin: "large",
							controls: [
								{
									type: DefaultControls.CheckBox,
									typeName: 'CheckBox',
									name: "doTest"
								},
								{
									type: DefaultControls.LayoutBox,
									typeName: 'LayoutBox',
									margin: "large",
									controls: [
										{
											type: DefaultControls.TextBox,
											typeName: 'TextBox',
											name: "siglevel",
											format: FormatDef.number
										},
										{
											type: DefaultControls.LayoutBox,
											typeName: 'LayoutBox',
											margin: "large",
											controls: [
												{
													type: DefaultControls.ComboBox,
													typeName: 'ComboBox',
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
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Lag Plot",
					controls: [
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "rtLAG1",
							format: FormatDef.number
						},
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "rtLAG2",
							format: FormatDef.number
						}
					]
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
