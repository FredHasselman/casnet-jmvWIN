
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"y1","title":"Time Series Y1","type":"Variable"},{"name":"standardise","title":"Transform time series?","type":"List","options":[{"name":"none","title":"No transformation"},{"name":"meanSD","title":"Standardise on Mean and SD"},{"name":"medianMAD","title":"Standardise on Median and MAD"},{"name":"unitScale","title":"Scale to Min. and Max. (unit scale)"},{"name":"symbolicScale","title":"Symbolic representation"}],"default":"none"},{"name":"edgeWeight","title":"Edges represent:","type":"List","options":[{"name":"none","title":"Connections (no weights)"},{"name":"si","title":"Distance in Recurrence Matrix"},{"name":"rt","title":"Recurrence Time"},{"name":"rf","title":"Recurrence Time Frequency"}],"default":"none"},{"name":"Glayout","title":"Graph layout","type":"List","options":[{"name":"ar","title":"Archimedean"},{"name":"be","title":"Bernoulli"},{"name":"fe","title":"Fermat"},{"name":"eu","title":"Euler"}]},{"name":"LayoutA","title":"Spiral parameter: a (leave 0 for default)","type":"Number","default":0},{"name":"LayoutB","title":"Spiral parameter: b (leave 0 for default)","type":"Number","default":0},{"name":"Narcs","title":"Spiral parameter: Number of arcs","type":"Number","default":4},{"name":"Glabels","title":"Add labels (time)","type":"Bool","default":true},{"name":"nsize","title":"Node size","type":"List","default":"degree","options":[{"name":"degree","title":"Node degree"},{"name":"strength","title":"Node strength (weighted network)"},{"name":"hubscore","title":"Node hubscore"},{"name":"fixed","title":"Same size"}]},{"name":"PruneDegree","title":"Prune by node degree","type":"Number","default":0},{"name":"PruneWeight","title":"Prune by edge weight","type":"Number","default":0},{"name":"emLag","title":"Embedding lag","type":"Number","default":1},{"name":"emDim","title":"Embedding dimensions","type":"Number","default":1},{"name":"fixRR","title":"RR","type":"Number","default":0.05},{"name":"fixRAD","title":"Radius","type":"Number","default":0},{"name":"fixed","title":"Fix","type":"List","default":"RAD","options":[{"name":"RAD","title":"fixed Radius"},{"name":"RR","title":"fixed Recurrence Rate"},{"name":"NO","title":"Unthresholded"}]},{"type":"Number","title":"Minimum diagonal line length","name":"DLmin","default":2},{"type":"Number","title":"Maximum diagonal line length","name":"DLmax","default":0},{"type":"Number","title":"Minimum vertical line length","name":"VLmin","default":2},{"type":"Number","title":"Maximum vertical line length","name":"VLmax","default":0},{"type":"Number","title":"Minimum horizontal line length","name":"HLmin","default":2},{"type":"Number","title":"Maximum horizontal line length","name":"HLmax","default":0},{"type":"Number","title":"Theiler window","name":"theiler","default":0},{"type":"List","title":"Distance norm","name":"norm","options":[{"title":"euclidean","name":"euclidean"},{"title":"maximum","name":"maximum"},{"title":"manhattan","name":"manhattan"},{"title":"canberra","name":"canberra"},{"title":"binary","name":"binary"},{"title":"minkowski","name":"minkowski"}],"default":"euclidean"}];

const view = function() {
    
    

    View.extend({
        jus: "2.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Recurrence Networks",
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
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "standardise_unit",
							optionName: "standardise",
							optionPart: "unitScale"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "standardise_symbolic",
							optionName: "standardise",
							optionPart: "symbolicScale"
						}
					]
				}
			]
		},
		{
			type: DefaultControls.CollapseBox,
			typeName: 'CollapseBox',
			label: "Recurrence Network",
			collapsed: false,
			controls: [
				{
					type: DefaultControls.LayoutBox,
					typeName: 'LayoutBox',
					margin: "large",
					controls: [
						{
							type: DefaultControls.Label,
							typeName: 'Label',
							label: "Edges represent:",
							controls: [
								{
									type: DefaultControls.RadioButton,
									typeName: 'RadioButton',
									name: "edgeWeigth_none",
									optionName: "edgeWeight",
									optionPart: "none"
								},
								{
									type: DefaultControls.RadioButton,
									typeName: 'RadioButton',
									name: "edgeWeigth_si",
									optionName: "edgeWeight",
									optionPart: "si"
								},
								{
									type: DefaultControls.RadioButton,
									typeName: 'RadioButton',
									name: "edgeWeigth_rt",
									optionName: "edgeWeight",
									optionPart: "rt"
								},
								{
									type: DefaultControls.RadioButton,
									typeName: 'RadioButton',
									name: "edgeWeigth_rf",
									optionName: "edgeWeight",
									optionPart: "rf"
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
							label: "Spiral layout",
							controls: [
								{
									type: DefaultControls.ComboBox,
									typeName: 'ComboBox',
									label: "Graph layout",
									name: "Glayout"
								},
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "LayoutA",
									format: FormatDef.number
								},
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "LayoutB",
									format: FormatDef.number
								},
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "Narcs",
									format: FormatDef.number
								},
								{
									type: DefaultControls.CheckBox,
									typeName: 'CheckBox',
									name: "Glabels"
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
							label: "Node size",
							controls: [
								{
									type: DefaultControls.RadioButton,
									typeName: 'RadioButton',
									name: "nsize_deg",
									optionName: "nsize",
									optionPart: "degree"
								},
								{
									name: "nsize_strength",
									type: DefaultControls.RadioButton,
									typeName: 'RadioButton',
									optionName: "nsize",
									optionPart: "strength"
								},
								{
									type: DefaultControls.RadioButton,
									typeName: 'RadioButton',
									name: "nsize_hub",
									optionName: "nsize",
									optionPart: "hubscore"
								},
								{
									name: "nsize_fixed",
									type: DefaultControls.RadioButton,
									typeName: 'RadioButton',
									optionName: "nsize",
									optionPart: "fixed"
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
							label: "Remove nodes/edges",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									label: "Prune by node degree",
									name: "PruneDegree",
									format: FormatDef.number
								},
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									label: "Prune by edge weight",
									name: "PruneWeight",
									format: FormatDef.number
								}
							]
						}
					]
				}
			]
		},
		{
			type: DefaultControls.CollapseBox,
			typeName: 'CollapseBox',
			label: "Phase Space Parameters",
			collapsed: false,
			controls: [
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					label: "Embedding lag",
					name: "emLag",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "emDim",
					format: FormatDef.number
				},
				{
					type: DefaultControls.LayoutBox,
					typeName: 'LayoutBox',
					margin: "large",
					controls: [
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "fixed_RAD",
							optionName: "fixed",
							optionPart: "RAD",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "fixRAD",
									label: "Radius",
									format: FormatDef.number,
									enable: "(fixed_RAD)"
								}
							]
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "fixed_RR",
							optionName: "fixed",
							optionPart: "RR",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "fixRR",
									label: "RR",
									format: FormatDef.number,
									enable: "(fixed_RR)"
								}
							]
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
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
			typeName: 'CollapseBox',
			label: "Analysis Parameters",
			collapsed: true,
			controls: [
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					label: "Minimum diagonal line length",
					name: "DLmin",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					label: "Maximum diagonal line length",
					name: "DLmax",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					label: "Minimum vertical line length",
					name: "VLmin",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					label: "Maximum vertical line length",
					name: "VLmax",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					label: "Minimum horizontal line length",
					name: "HLmin",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					label: "Maximum horizontal line length",
					name: "HLmax",
					format: FormatDef.number
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					label: "Theiler window",
					name: "theiler",
					format: FormatDef.number
				},
				{
					type: DefaultControls.ComboBox,
					typeName: 'ComboBox',
					label: "Distance norm",
					name: "norm"
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
