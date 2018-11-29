
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"y1","title":"Time Series","type":"Variable"},{"name":"Ent_edim","title":"Embedding dimension / Segment length","type":"Number","default":3},{"name":"Ent_r","title":"Filter factor / Radius","type":"Number","default":1}];

const view = View.extend({
    jus: "2.0",

    events: [

	]

});

view.layout = ui.extend({

    label: "Entropy & Roughness",
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
					label: "Time Series",
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
			controls: [
				{
					type: DefaultControls.TextBox,
					name: "Ent_edim",
					format: FormatDef.number,
					inputPattern: "[0-9]+"
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.TextBox,
					name: "Ent_r",
					format: FormatDef.number,
					inputPattern: "[0-9]+"
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
