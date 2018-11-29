
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"y1","title":"Time series","type":"Variable"},{"name":"surmethod","title":"Surrogate method","type":"List","options":[{"title":"Choose a method","name":"choose"},{"title":"Random shuffle","name":"randshuffle"},{"title":"Block randomisation [not implemented]","name":"blockshuffle"},{"title":"Random phases (FFT)","name":"randphase"},{"title":"Amplitude adjusted random phases (AAFT)","name":"randphase"}],"default":"choose"},{"name":"numSUR","title":"Number of surrogates to generate:","type":"Integer","default":1},{"name":"Save","title":"Save surrogates to a file","type":"Bool","default":false},{"name":"savePath","title":"Provide a valid path","type":"String","default":""}];

const view = View.extend({
    jus: "2.0",

    events: [

	]

});

view.layout = ui.extend({

    label: "Generate random surrogates",
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
			controls: [
				{
					type: DefaultControls.ComboBox,
					name: "surmethod"
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			margin: "large",
			controls: [
				{
					type: DefaultControls.TextBox,
					name: "numSUR",
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
					type: DefaultControls.CheckBox,
					name: "Save",
					controls: [
						{
							type: DefaultControls.TextBox,
							label: "Provide a valid path",
							name: "savePath",
							format: FormatDef.string,
							enable: "(Save)"
						}
					]
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
