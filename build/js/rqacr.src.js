
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"y1","title":"Time Series Y1","type":"Variable"},{"name":"y2","title":"Time Series Y2","type":"Variable"},{"name":"discretise","title":"Change to symbolic representation","type":"Bool","default":false},{"name":"emLag","title":"Embedding lag","type":"Number","default":1},{"name":"emDim","title":"Embedding dimensions","type":"Number","default":1},{"name":"fixRR","title":"RR","type":"Number","default":0.05},{"name":"fixRAD","title":"Radius","type":"Number","default":0},{"name":"fixed","title":"Fix","type":"List","default":"RAD","options":[{"name":"RAD","title":"fixed Radius"},{"name":"RR","title":"fixed Recurrence Rate"},{"name":"NO","title":"Unthresholded"}]},{"type":"Number","title":"Minimum diagonal line length","name":"DLmin","default":2},{"type":"Number","title":"Maximum diagonal line length","name":"DLmax","default":0},{"type":"Number","title":"Minimum vertical line length","name":"VLmin","default":2},{"type":"Number","title":"Maximum vertical line length","name":"VLmax","default":0},{"type":"Number","title":"Minimum horizontal line length","name":"HLmin","default":2},{"type":"Number","title":"Maximum horizontal line length","name":"HLmax","default":0},{"type":"Number","title":"Theiler window","name":"theiler","default":0},{"type":"List","title":"Distance norm","name":"norm","options":[{"title":"euclidean","name":"euclidean"},{"title":"maximum","name":"maximum"},{"title":"manhattan","name":"manhattan"},{"title":"canberra","name":"canberra"},{"title":"binary","name":"binary"},{"title":"minkowski","name":"minkowski"}],"default":"euclidean"},{"name":"plotDP","title":"Plot Diagonal Recurrence Profile","type":"Bool","default":false},{"name":"diagWin","title":"Window around LOS","type":"Number","default":10}];

const view = View.extend({
    jus: "2.0",

    events: [

	]

});

view.layout = ui.extend({

    label: "Cross RQA",
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
							name: "y1",
							maxItemCount: 1,
							isTarget: true
						}
					]
				},
				{
					type: DefaultControls.TargetLayoutBox,
					label: "Time series 2",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							name: "y2",
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
					label: "Discretise?",
					controls: [
						{
							type: DefaultControls.CheckBox,
							label: "Change to symbolic representation",
							name: "discretise"
						}
					]
				}
			]
		},
		{
			type: DefaultControls.CollapseBox,
			label: "Phase Space Parameters",
			collapsed: false,
			controls: [
				{
					type: DefaultControls.TextBox,
					label: "Embedding lag",
					name: "emLag",
					format: FormatDef.number,
					inputPattern: "[0-9]+"
				},
				{
					type: DefaultControls.TextBox,
					name: "emDim",
					format: FormatDef.number,
					inputPattern: "[0-9]+"
				},
				{
					type: DefaultControls.LayoutBox,
					margin: "large",
					controls: [
						{
							type: DefaultControls.RadioButton,
							name: "fixed_RAD",
							optionName: "fixed",
							optionPart: "RAD",
							controls: [
								{
									type: DefaultControls.TextBox,
									name: "fixRAD",
									label: "Radius",
									format: FormatDef.number,
									inputPattern: "[0-9]+",
									enable: "(fixed_RAD)"
								}
							]
						},
						{
							type: DefaultControls.RadioButton,
							name: "fixed_RR",
							optionName: "fixed",
							optionPart: "RR",
							controls: [
								{
									type: DefaultControls.TextBox,
									name: "fixRR",
									label: "RR",
									format: FormatDef.number,
									inputPattern: "[0-9]+",
									enable: "(fixed_RR)"
								}
							]
						},
						{
							type: DefaultControls.RadioButton,
							name: "fixed_NO",
							optionName: "fixed",
							optionPart: "NO"
						}
					]
				}
			]
		},
		{
			type: DefaultControls.CollapseBox,
			label: "Analysis Parameters",
			collapsed: true,
			controls: [
				{
					type: DefaultControls.TextBox,
					label: "Minimum diagonal line length",
					name: "DLmin",
					format: FormatDef.number,
					inputPattern: "[0-9]+"
				},
				{
					type: DefaultControls.TextBox,
					label: "Maximum diagonal line length",
					name: "DLmax",
					format: FormatDef.number,
					inputPattern: "[0-9]+"
				},
				{
					type: DefaultControls.TextBox,
					label: "Minimum vertical line length",
					name: "VLmin",
					format: FormatDef.number,
					inputPattern: "[0-9]+"
				},
				{
					type: DefaultControls.TextBox,
					label: "Maximum vertical line length",
					name: "VLmax",
					format: FormatDef.number,
					inputPattern: "[0-9]+"
				},
				{
					type: DefaultControls.TextBox,
					label: "Minimum horizontal line length",
					name: "HLmin",
					format: FormatDef.number,
					inputPattern: "[0-9]+"
				},
				{
					type: DefaultControls.TextBox,
					label: "Maximum horizontal line length",
					name: "HLmax",
					format: FormatDef.number,
					inputPattern: "[0-9]+"
				},
				{
					type: DefaultControls.TextBox,
					label: "Theiler window",
					name: "theiler",
					format: FormatDef.number,
					inputPattern: "[0-9]+"
				},
				{
					type: DefaultControls.ComboBox,
					label: "Distance norm",
					name: "norm"
				}
			]
		},
		{
			type: DefaultControls.CollapseBox,
			label: "Diagonal Recurrence Profile",
			collapsed: true,
			controls: [
				{
					type: DefaultControls.LayoutBox,
					margin: "large",
					controls: [
						{
							type: DefaultControls.CheckBox,
							name: "plotDP",
							controls: [
								{
									type: DefaultControls.TextBox,
									label: "Window around LOS",
									name: "diagWin",
									format: FormatDef.number,
									enable: "(plotDP)"
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
